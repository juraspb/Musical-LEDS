unit SerialLink;

interface

uses
  Classes, Windows, SysUtils;

type
  TOnErrorEvent = procedure(Sender: TObject; const Msg: string) of object;

  TSerialLink = class(TComponent)
  private
    FHandle: Cardinal;
    FActive: Boolean;
    FPort: string;
    FSpeed: integer;
    FError: integer;
    FOnError: TOnErrorEvent;
    FBytesReceived: integer;
    procedure SetActive(val: Boolean);
    procedure SetPort(val: string);
    procedure SetSpeed(val: integer);
  protected
    procedure DoErrorEvent(const Msg: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Active: Boolean read FActive write SetActive;
    property Port: string read FPort write SetPort;
    property Speed: integer read FSpeed write SetSpeed;
    property Error: integer read FError;
    property BytesReceived: integer read FBytesReceived;
    property OnError: TOnErrorEvent read FOnError write FOnError;
    procedure Open;
    procedure Close;
    procedure SendCommand(var SendBuff: array of Byte);
    procedure SendBuffer(var SendBuff: array of byte; ToSend: Cardinal);
    procedure SendChar(var SendBuff: array of AnsiChar; ToSend: Cardinal);
    procedure SendString(var s: ansistring);
    procedure ReceiveBuffer(var RcvBuff: array of AnsiChar; ToReceive: Cardinal);
    function SetTimeouts(ReadTotal: Cardinal): Boolean;
    function GetBytesReceived : boolean;
  end;

implementation
{ TSerialLink }

const
  MAX_TRYNMB = 1;

procedure TSerialLink.Close;
begin
  if not Active then Exit;
  try
    CloseHandle(FHandle);
  finally
    FActive:= False;
  end;
end;

constructor TSerialLink.Create(AOwner: TComponent);
begin
  inherited;
  FActive:= False;
  FError:= 0;
  FPort:= '';
  FSpeed:= 115200;
end;


destructor TSerialLink.Destroy;
begin
  Close;
  inherited;
end;

procedure TSerialLink.DoErrorEvent(const Msg: string);
begin
  if Assigned(OnError) then OnError(Self, Msg);
end;

procedure TSerialLink.Open;
var
  _DCB : TDCB;
begin
  {Откроем порт}
  FHandle := CreateFile(PChar(Port), GENERIC_READ+GENERIC_WRITE, 0, nil,
               OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if FHandle = INVALID_HANDLE_VALUE then
  begin
    DoErrorEvent('Не могу открыть порт');
    FError:= -1;
    Exit;
  end;
 try
  {Установить параметры порта}
  if not GetCommState(FHandle, _DCB) then
  begin
    DoErrorEvent('Не могу получить состояние порта');
    FError:= -2;
    Exit;
  end;
  with _DCB do
  begin
    BaudRate := FSpeed;
    Flags := $00000001;
    ByteSize := DATABITS_8;
    Parity := NOPARITY;
    StopBits := ONESTOPBIT;
  end;
  if not SetCommState(FHandle, _DCB) then
  begin
    DoErrorEvent('Не могу установить состояние порта');
    FError:= -3;
    Exit;
  end;
  EscapeCommFunction(FHandle, SETDTR);
  if not SetTimeouts(10000) then Exit;
  FActive:= True;
  FError:= 0;
 finally
   if not FActive then CloseHandle(FHandle);
 end;
end;

function TSerialLink.GetBytesReceived : boolean;
var CS : TComStat;
    dwError : DWORD;
Begin
 if not ClearCommError(FHandle, dwError, @CS) then
   begin
    DoErrorEvent('Не могу установить состояние порта');
    FError:= -6;
    FBytesReceived := 0;
    Result := false;
    Exit;
   end;
  FError:= 0;
  FBytesReceived := CS.cbInQue;
  Result := true;
End;

procedure TSerialLink.SetActive(val: Boolean);
begin
  if val then Open else Close;
end;

procedure TSerialLink.SetPort(val: string);
begin
  if FPort = val then Exit;

  FPort:= val;
  if FActive then
  begin
    Close;
    Open;
  end;
end;

procedure TSerialLink.SetSpeed(val: integer);
begin
  if FSpeed = val then Exit;

  FSpeed:= val;
  if FActive then
  begin
    Close;
    Open;
  end;
end;

function TSerialLink.SetTimeouts(ReadTotal: Cardinal): Boolean;
var
  _CommTimeouts : TCommTimeouts;
begin
  Result:= False;
  with _CommTimeouts do
  begin
    ReadIntervalTimeout:= 20;
    ReadTotalTimeoutMultiplier:= 4;
    ReadTotalTimeoutConstant:= ReadTotal;
    WriteTotalTimeoutMultiplier:= 0;
    WriteTotalTimeoutConstant:= 0;
  end;
  if not SetCommTimeouts(FHandle, _CommTimeouts) then
  begin
    DoErrorEvent('Не могу установить таймаут порта');
    Exit;
  end;
  Result:= True;
end;

procedure TSerialLink.SendString(var s:ansistring);
var written: Cardinal;
begin
  if not WriteFile(FHandle, s, length(s), written, nil) Or (written <> length(s)+2) then
   begin
    DoErrorEvent('Не могу записать в порт');
    FError:= -4;
    Exit;
   end;
  FlushFileBuffers(FHandle);
  FError:= 0;
end;

procedure TSerialLink.SendBuffer(var SendBuff: array of byte; ToSend: Cardinal);
var written: Cardinal;
begin
  if not WriteFile(FHandle, SendBuff, ToSend, written, nil) Or (written <> ToSend) then
   begin
    DoErrorEvent('Не могу записать в порт');
    FError:= -4;
    Exit;
   end;
  FlushFileBuffers(FHandle);
  FError:= 0;
end;

procedure TSerialLink.SendChar(var SendBuff: array of ANsiChar; ToSend: Cardinal);
var written: Cardinal;
begin
  if not WriteFile(FHandle, SendBuff, ToSend, written, nil) Or (written <> ToSend) then
   begin
    DoErrorEvent('Не могу записать в порт');
    FError:= -4;
    Exit;
   end;
  FlushFileBuffers(FHandle);
  FError:= 0;
end;

procedure TSerialLink.ReceiveBuffer(var RcvBuff: array of ansichar; ToReceive: Cardinal);
var rcvd: Cardinal;
begin
  if not ReadFile(FHandle, RcvBuff, ToReceive, rcvd, nil) then
   begin
    DoErrorEvent('Не могу прочитать из порта');
    FError:= -5;
    FBytesReceived:= -1;
    Exit;
   end;
  if rcvd = 0 then
   begin
    FBytesReceived:=rcvd;
    DoErrorEvent('Пустой буфер порта');
    FError:= 1;
    Exit;
   end;
  FBytesReceived:=rcvd;
  FError:= 0;
end;

procedure TSerialLink.SendCommand(var SendBuff: array of Byte);
var  TCount,T1Count: longint;
     written: Cardinal;
     _DCB : TDCB;
Begin
  PurgeComm(FHandle,PURGE_TXCLEAR+PURGE_RXCLEAR);
{*** Приготовили для передачи команду ******************}
  if not GetCommState(FHandle, _DCB) then
   begin
    DoErrorEvent('Не могу получить состояние порта');
    FError:= -7;
    Exit;
   end;
  _DCB.Parity := EVENPARITY;
  if not SetCommState(FHandle, _DCB) then
  begin
    DoErrorEvent('Не могу установить состояние порта');
    FError:= -8;
    Exit;
  end;
  WriteFile(FHandle, SendBuff ,1,written,Nil);
  FlushFileBuffers(FHandle);

  TCount:=GetTickCount;
  Repeat
   T1Count:=GetTickCount;
   if TCount > T1Count then
   Begin
    TCount:=GetTickCount;
    T1Count:=GetTickCount;
   End;
  Until ((T1Count-TCount) > 2);
  if not GetCommState(FHandle, _DCB) then
  begin
    DoErrorEvent('Не могу получить состояние порта');
    FError:= -9;
    Exit;
  end;
  _DCB.Parity := NOPARITY;
  if not SetCommState(FHandle, _DCB) then
  begin
    DoErrorEvent('Не могу установить состояние порта');
    FError:= -10;
    Exit;
  end;
  if SendBuff[0]=$AA then WriteFile(FHandle,SendBuff[1],1,written,Nil)
                     else WriteFile(FHandle,SendBuff[1],4,written,Nil);
  FlushFileBuffers(FHandle);
  FError:= 0;
End;


end.
