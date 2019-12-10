unit MNTR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SerialLink, ExtCtrls, Spin, Buttons, ComCtrls;

type
  TDSForm = class(TForm)
    SB: TStatusBar;
    cnfgTimer: TTimer;
    Panel2: TPanel;
    trckbr1: TTrackBar;
    lbl4: TLabel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Label5: TLabel;
    TrackBar4: TTrackBar;
    Label7: TLabel;
    GroupBox2: TGroupBox;
    SE8: TSpinEdit;
    Label2: TLabel;
    se3: TSpinEdit;
    se2: TSpinEdit;
    se1: TSpinEdit;
    lbl1: TLabel;
    Button1: TButton;
    CB2: TComboBox;
    CB11: TComboBox;
    CB12: TComboBox;
    ComboBox2: TComboBox;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure cnfgTimerTimer(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure se1Change(Sender: TObject);
    procedure trckbr1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CB2Change(Sender: TObject);
  private
    { Private declarations }
    FLink: TSerialLink;
    number_bytes: integer;
    str_recv: ansistring;
    led: array [0..11] of integer;
    band: array [0..11] of integer;
    procedure sendCMD(s:ansistring;answ:boolean);
  public
    { Public declarations }
    CommunicPortName: string;
    CommunicPortSpeed: integer;
    time: Cardinal;
    SendBuff : array[0..255] of Byte;
    RcvBuff : array[0..32767] of ansichar;
  end;

var
  DSForm : TDSForm;
  Timeout: Cardinal;

implementation

{$R *.DFM}

procedure TDSForm.FormCreate(Sender: TObject);
var i,j:Integer;
begin
  CommunicPortName:='COM5';
  CommunicPortSpeed:=115200;
  cnfgTimer.Enabled:=true;
  led[0]:=30;
  led[1]:=36;
  led[2]:=50;
  led[3]:=60;
  led[4]:=72;
  led[5]:=100;
  led[6]:=120;
  led[7]:=144;
  led[8]:=150;
  led[9]:=200;
  led[10]:=216;
  led[11]:=240;
  band[0]:=5;
  band[1]:=6;
  band[2]:=10;
  band[3]:=15;
  band[4]:=18;
  band[5]:=20;
  band[6]:=30;
  str_recv:='';
  number_bytes:=0;
end;

procedure TDSForm.Button1Click(Sender: TObject);
begin
  sendCMD('AT+SS',True);
end;

procedure TDSForm.cnfgTimerTimer(Sender: TObject);
begin
  cnfgTimer.Enabled:=false;
  try
    if FLink = nil then FLink:= TSerialLink.Create(nil);
    FLink.Port:=CommunicPortName;
    FLink.Speed:=CommunicPortSpeed;
    FLink.Open;
   finally
    if not FLink.Active then
     begin
      Label1.Font.Color:=clRed;
      Label1.Caption:='Not available';
      MessageDlg('No connection', mtError, [mbOK], 0);
     end else
     begin
      Label1.Font.Color:=clGreen;
      Label1.Caption:='Open';
     end;
  end;
end;

procedure TDSForm.ComboBox1Change(Sender: TObject);
begin
   WITH Sender AS TComboBox DO
    begin
     case tag of
       0 : begin
            CommunicPortName:=Text;
            FLink.Port:= CommunicPortName;
            if not FLink.Active then cnfgTimer.Enabled:=true;
           end;
       end;
    end;
end;

procedure TDSForm.CB2Change(Sender: TObject);
var s:ansistring;
begin
  with Sender as TComboBox do
   begin
    case tag of
     0: begin
      s:='AT+NM'+inttostr(ItemIndex)+','+inttostr(se8.Value);
      sendCMD(s,True);
     end;
     1: begin
//      s:='AT+L'+CB11.Items[CB11.ItemIndex]+','+CB12.Items[CB12.ItemIndex];
      s:='AT+L'+CB11.Text+','+CB12.Text;
      sendCMD(s,True);
      sb.Panels[1].Text:='LEDs per band (color) => '+inttostr(strtoint(CB11.Text) div strtoint(CB12.Text));
     end;
     2: begin
      s:='AT+U'+inttostr(ItemIndex);
      sendCMD(s,True);
     end;
    end;
   end;
end;

procedure TDSForm.trckbr1Change(Sender: TObject);
var s:ansistring;
begin
  with Sender as TTrackBar do
   begin
    case tag of
     0: begin
      s:='AT+B'+inttostr(position);
      sendCMD(s,True);
      s:='AT+M'+inttostr(position);
      sendCMD(s,True);
     end;
     1: begin
      s:='AT+T'+inttostr(position);
      sendCMD(s,True);
     end;
    end;
   end;
end;

procedure TDSForm.se1Change(Sender: TObject);
var s:ansistring;
begin
  with Sender as TSpinEdit do
   begin
    if tag=1 then
     begin
      s:='AT+NM'+inttostr(CB2.ItemIndex)+','+inttostr(se8.Value);
     end else
     begin
      s:='AT+ND'+inttostr(se1.Value)+','+inttostr(se2.Value)+','+inttostr(se3.Value);
     end;
    sendCMD(s,True);
   end;
end;

procedure TDSForm.sendCMD(s:ansistring;answ:Boolean);
var n,i:Byte;
    ch:array[0..255] of AnsiChar;
    si:AnsiString;
    timeRead,timeCrt:Cardinal;
    str_ready:Boolean;
begin
    n:=Length(s);
    for i:=0 to n-1 do ch[i]:=s[i+1];
    ch[n]:=#10;
    ch[n+1]:=#13;
    FLink.SendChar(ch,n+2);
    SB.Panels[0].Text:='Send:'+s;
    if answ then
     begin
      si:='time_out';
      str_ready:=False;
      timeRead:=GetTickCount;
      repeat
       if FLink.GetBytesReceived then
        begin
         n:=FLink.BytesReceived;          // байт в буфере
         if n>0 then
          begin
           timeRead:=GetTickCount;
           FLink.ReceiveBuffer(RcvBuff,n);
           for i:=1 to n do
            begin
               if (RcvBuff[i-1]=#13)or(RcvBuff[i-1]=#10) then
                begin
                 if str_recv>'' then
                  begin
                   si:=str_recv;
                   str_recv:='';
                   str_ready:=True;
                  end;
                end else
                begin
                 str_recv:=str_recv+RcvBuff[i-1];
                end;
            end;
          end;
        end;
        timeCrt:=GetTickCount;
      until (((timeCrt-timeRead)>500) or str_ready);
      SB.Panels[0].Text:='Answer:'+si;
     end;
end;

end.

