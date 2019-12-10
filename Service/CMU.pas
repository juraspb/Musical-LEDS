unit CMU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SerialLink, ExtCtrls, Menus, Buttons, ComCtrls, Grids, TeEngine,
  Series, TeeProcs, Chart, Spin;

const
   colorTab: array [0..111] of TColor=(
      $FF0000,$FF1100,$FF2200,$FF3300,$FF4400,$FF5500,$FF6600,$FF7700,$FF8800,$FF9900,$FFAA00,$FFBB00,$FFCC00,$FFDD00,$FFEE00,$FFFF00,  //??????? - ??????
      $FFFF00,$EEFF00,$DDFF00,$CCFF00,$BBFF00,$AAFF00,$99FF00,$88FF00,$77FF00,$66FF00,$55FF00,$44FF00,$33FF00,$22FF00,$11FF00,$00FF00,  //?????? Ч ???????
      $00FF00,$00FF11,$00FF22,$00FF33,$00FF44,$00FF55,$00FF66,$00FF77,$00FF88,$00FF99,$00FFAA,$00FFBB,$00FFCC,$00FFDD,$00FFEE,$00FFFF,  //??????? Ч ???? (???????)
      $00FFFF,$00EEFF,$00DDFF,$00CCFF,$00BBFF,$00AAFF,$0099FF,$0088FF,$0077FF,$0066FF,$0055FF,$0044FF,$0033FF,$0022FF,$0011FF,$0000FF,  //??????? Ч ?????
      $0000FF,$1100FF,$2200FF,$3300FF,$4400FF,$5500FF,$6600FF,$7700FF,$8800FF,$9900FF,$AA00FF,$BB00FF,$CC00FF,$DD00FF,$EE00FF,$FF00FF,  //????? Ч ?????? (????????)
      $FF00FF,$FF00EE,$FF00DD,$FF00CC,$FF00BB,$FF00AA,$FF0099,$FF0088,$FF0077,$FF0066,$FF0055,$FF0044,$FF0033,$FF0022,$FF0011,$FF0000, //???????? Ч ???????
      $FFFFFF,$EEEEEE,$DDDDDD,$CCCCCC,$BBBBBB,$AAAAAA,$999999,$888888,$777777,$666666,$555555,$444444,$333333,$222222,$111111,$000000); //???????? Ч ???????

type
    TColorSubr =  record
      subprog:integer;
      subcolor:integer;
      cl:DWORD;
end;

type
    TPlayList =  record
      prog:integer;
      subprog:integer;
      direction:integer;
      tempo:integer;
end;


type
  TDSForm = class(TForm)
    SB: TStatusBar;
    cnfgTimer: TTimer;
    Timer1: TTimer;
    SvDlg: TSaveDialog;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    PLAY: TPageControl;
    ts1: TTabSheet;
    dg1: TDrawGrid;
    dg2: TDrawGrid;
    btn1: TSpeedButton;
    btn3: TSpeedButton;
    ts4: TTabSheet;
    ts2: TTabSheet;
    Memo1: TMemo;
    sg1: TStringGrid;
    btn2: TBitBtn;
    btn4: TSpeedButton;
    ts3: TTabSheet;
    btn5: TButton;
    ts5: TTabSheet;
    rg1: TRadioGroup;
    Button1: TButton;
    btn6: TButton;
    btn7: TSpeedButton;
    opDlg: TOpenDialog;
    btn8: TSpeedButton;
    rg3: TRadioGroup;
    se1: TSpinEdit;
    se2: TSpinEdit;
    se3: TSpinEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    Button3: TButton;
    edt1: TEdit;
    se4: TSpinEdit;
    SpeedButton1: TSpeedButton;
    rg2: TRadioGroup;
    lbl3: TLabel;
    se5: TSpinEdit;
    trckbr1: TTrackBar;
    lbl4: TLabel;
    btn9: TSpeedButton;
    btn10: TSpeedButton;
    btn11: TSpeedButton;
    btn12: TSpeedButton;
    btn13: TSpeedButton;
    Memo2: TMemo;
    rg4: TRadioGroup;
    rg5: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure cnfgTimerTimer(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure dg1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure dg2SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure dg2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btn1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure sg1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure sg1DblClick(Sender: TObject);
    procedure dg1DblClick(Sender: TObject);
    procedure dg2DblClick(Sender: TObject);
    procedure btnColorClick(Sender: TObject);
    procedure se1Change(Sender: TObject);
    procedure se4Change(Sender: TObject);
    procedure se5Change(Sender: TObject);
    procedure rg2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure trckbr1Change(Sender: TObject);
    procedure btn10Click(Sender: TObject);
    procedure btn13Click(Sender: TObject);
  private
    { Private declarations }
    FLink: TSerialLink;
    colorSubr:TColorSubr;
    colorProg:array[0..7,0..5] of byte;
    bpGain:array[0..7,0..31] of byte;
    PlayList:array[0..79] of TPlayList;
    number_bytes: integer;
    setTB:Boolean;
    str_recv: ansistring;
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
  setTB:=False;
  CommunicPortName:='COM4';
  CommunicPortSpeed:=115200;
  cnfgTimer.Enabled:=true;
  str_recv:='';
  number_bytes:=0;
  for j:=0 to 6 do
   begin
    for i:=0 to 15 do
     begin
//      dg1.Canvas.Brush.Color:=colorTab[j*16+i];
      dg1.Canvas.Brush.Color:=clBlack;
      dg1.Canvas.FillRect(dg1.CellRect(i,j));
     end;
   end;
   dg1.repaint;
  for j:=0 to 7 do
   begin
    for i:=0 to 31 do bpGain[j,i]:=31;
   end;
end;

procedure TDSForm.cnfgTimerTimer(Sender: TObject);
begin
  cnfgTimer.Enabled:=false;
  try
    if FLink = nil then
     begin
      FLink:= TSerialLink.Create(nil);
     end;
    FLink.Port:=CommunicPortName;
    FLink.Speed:=CommunicPortSpeed;
    FLink.Open;
   finally
    if not FLink.Active then
     begin
      Label1.Font.Color:=clRed;
      Label1.Caption:='Close';
      MessageDlg('No connection established', mtError, [mbOK], 0);
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
           end;
       end;
     if not FLink.Active then cnfgTimer.Enabled:=true;
    end;
end;

procedure TDSForm.Timer1Timer(Sender: TObject);
var i,n:integer;
begin
   if FLink.GetBytesReceived then
    begin
     n:=FLink.BytesReceived;          // байт в буфере
     if n>0 then
      begin
       FLink.ReceiveBuffer(RcvBuff,n);
       for i:=1 to n do
        begin
           if (RcvBuff[i-1]=#13)or(RcvBuff[i-1]=#10) then
            begin
             if str_recv>'' then
              begin
               memo1.Lines.Add(str_recv);
               str_recv:='';
              end;
            end else
            begin
             str_recv:=str_recv+RcvBuff[i-1];
            end;
        end;
      end;
    end;
end;

procedure TDSForm.Button1Click(Sender: TObject);
begin
 memo1.Clear;
 number_bytes:=0;
end;

procedure TDSForm.btn6Click(Sender: TObject);
begin
    if SvDlg.Execute then memo1.Lines.SaveToFile(SvDlg.FileName);
end;

procedure TDSForm.btn5Click(Sender: TObject);
var s:string;
    i,j:Integer;
begin
   for i:=0 to (512 div 16)-1 do
    begin
     s:='';
     for j:=0 to 15 do
      begin
       s:=s+'0x'+inttohex(Round(32768*(0.53836-0.46164*cos(2*pi*(i*16+j)/1023))),4)+',';
      end;
     Memo1.Lines.Add(s);
    end;

end;

procedure TDSForm.dg1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var cl:TColor;
begin
  with Sender as TDrawGrid do
   begin
     cl:=colorTab[ARow*16+ACol];
     cl:=(cl shr 16)+(cl and $00FF00)+((cl and $FF) shl 16);
     Canvas.Brush.Color:=cl;
     Canvas.FillRect(Rect);
   end;
end;

procedure TDSForm.dg2SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  colorSubr.subprog:=ARow;
  colorSubr.subcolor:=ACol-1;
end;

procedure TDSForm.dg2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var cl:TColor;
    num:Integer;
begin
  with Sender as TDrawGrid do
   begin
     if ACol>0 then
      begin
        num:=colorProg[ARow,ACol-1];
        if (num>95) then num:=num-16;
        cl:=colorTab[num];
        cl:=(cl shr 16)+(cl and $00FF00)+((cl and $FF) shl 16);
        Canvas.Brush.Color:=cl;
        Canvas.FillRect(Rect);
      end else Canvas.TextOut(10,Rect.Top+10,IntToStr(ARow));
   end;
end;

procedure TDSForm.btn1Click(Sender: TObject);
var s,sn:AnsiString;
    i,j,k,n:Byte;
    sl:TStringList;
begin
    Timer1.Enabled:=False;
    Memo1.Clear;
    sendCMD('AT+PC',false);
    sl:=TStringList.Create;
    repeat
     if FLink.GetBytesReceived then
      begin
       n:=FLink.BytesReceived;          // байт в буфере
       if n>0 then
        begin
         FLink.ReceiveBuffer(RcvBuff,n);
         for i:=1 to n do
          begin
             if (RcvBuff[i-1]=#13)or(RcvBuff[i-1]=#10) then
              begin
               if str_recv>'' then
                begin
                 sl.Add(str_recv);
                 str_recv:='';
                end;
              end else
              begin
               str_recv:=str_recv+RcvBuff[i-1];
              end;
          end;
        end;
      end;
    until(sl.Count>8);
    for i:=1 to sl.Count-1 do
     begin
      s:=sl.Strings[i];
      Memo1.Lines.Add(s);
      k:=1;
      for j:=0 to 5 do
       begin
         while (s[k]<>#9) do inc(k);
         inc(k);
         sn:='';
         while (s[k]<>',') do
          begin
            sn:=sn+s[k];
            inc(k);
          end;
          inc(k);
          colorProg[i-1,j]:=strtoint(sn);
       end;
     end;
    dg2.Repaint;
    sl.Free;
    Timer1.Enabled:=True;
end;


procedure TDSForm.Button3Click(Sender: TObject);
begin
    sendCMD(edt1.Text,False);
    Timer1.Enabled:=True;
end;

procedure TDSForm.btn2Click(Sender: TObject);
var s,sn:AnsiString;
    i,j,k,n:Byte;
    sl:TStringList;
    timeRead,timeCrt:Cardinal;
begin
    Timer1.Enabled:=False;
    sendCMD('AT+PP',False);
    Memo1.Clear;
    sl:=TStringList.Create;
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
                 sl.Add(str_recv);
                 str_recv:='';
                end;
              end else
              begin
               str_recv:=str_recv+RcvBuff[i-1];
              end;
          end;
        end;
      end;
      timeCrt:=GetTickCount;
    until ((timeCrt-timeRead)>1000);
    i:=0;
    while i<sl.Count do
     begin
      s:=sl.Strings[i];
      if (s[1]<'0')or(s[1]>'9')  then
       begin
         sl.Delete(i);
       end else Inc(i);
     end;
    for i:=0 to sl.Count-1 do
     begin
      s:=sl.Strings[i];
      Memo1.Lines.Add(s);
      k:=1;
      for j:=0 to 3 do
       begin
         while (s[k]<>#9) do inc(k);
         inc(k);
         sn:='';
         while (s[k]<>',') do
          begin
            sn:=sn+s[k];
            inc(k);
          end;
          inc(k);
          case (j) of
           0: PlayList[i].prog:=strtoint(sn);
           1: PlayList[i].subprog:=strtoint(sn);
           2: PlayList[i].tempo:=strtoint(sn);
           3: PlayList[i].direction:=strtoint(sn);
          end;
       end;
     end;
    for i:=sl.Count to 79 do
     begin
       PlayList[i].prog:=255; // OFF
       PlayList[i].subprog:=0;
       PlayList[i].tempo:=40;
       PlayList[i].direction:=0;
     end;
    sl.Free;

    for i:=0 to sg1.RowCount-1 do
     begin
      for j:=0 to sg1.ColCount-1 do
       begin
         if (j=0) then
          begin
            if (i>0) then sg1.Cells[j, i]:=IntToStr(i-1);
          end else
          begin
            if (i=0) then
             begin
               case (j) of
                1: sg1.Cells[j, i]:='prog';
                2: sg1.Cells[j, i]:='subprog';
                3: sg1.Cells[j, i]:='dir';
                4: sg1.Cells[j, i]:='tempo';
               end;
             end else
             begin
               case (j) of
                1: sg1.Cells[j, i]:=IntToStr(PlayList[i-1].prog);
                2: sg1.Cells[j, i]:=IntToStr(PlayList[i-1].subprog);
                3: sg1.Cells[j, i]:=IntToStr(PlayList[i-1].direction);
                4: sg1.Cells[j, i]:=IntToStr(PlayList[i-1].tempo);
               end;
             end;
          end;
       end;
     end;
    btn13.Enabled:=True;
    Timer1.Enabled:=True;
end;

procedure TDSForm.sg1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: String);
var s:ansistring;
begin
   if (ACol>0)and(Value<>'') then
     begin
      if (ACol)<>4 then
       begin
         if (PlayList[ARow-1].tempo<10) then
          begin
            sg1.Cells[ARow,4]:='100';
            PlayList[ARow-1].tempo:=100;
          end;
       end;
      case (ACol) of
       1: PlayList[ARow-1].prog:=StrToInt(Value);
       2: PlayList[ARow-1].subprog:=StrToInt(Value);
       3: PlayList[ARow-1].direction:=StrToInt(Value);
       4: PlayList[ARow-1].tempo:=StrToInt(Value);
      end;
      s:='AT+I'+IntToStr(ARow-1)+','+IntToStr(PlayList[ARow-1].prog)+','+IntToStr(PlayList[ARow-1].subprog)+','+IntToStr(PlayList[ARow-1].direction)+','+IntToStr(PlayList[ARow-1].tempo);
      sendCMD(s,True);
     end;
end;

procedure TDSForm.sg1DblClick(Sender: TObject);
var s:ansistring;
    ARow:Integer;
begin
  with Sender as TStringGrid do
  begin
    ARow:=Row-1;
    s:='AT+N'+ IntToStr(PlayList[ARow].prog)+','+ IntToStr(PlayList[ARow].subprog)+','+ IntToStr(PlayList[ARow].direction)+','+ IntToStr(PlayList[ARow].tempo);
    sendCMD(s,True);
  end;
end;

procedure TDSForm.dg1DblClick(Sender: TObject);
var num:Integer;
    s:ansistring;
begin
   with Sender as TDrawGrid do
   begin
    num:=Row*16+Col;
    if (num>95) then num := num+16;
    colorProg[colorSubr.subprog,colorSubr.subcolor]:=num;
    s:='AT+C'+ IntToStr(colorSubr.subprog)+','+ IntToStr(colorSubr.subcolor)+','+ IntToStr(colorProg[colorSubr.subprog,colorSubr.subcolor]);
    sendCMD(s,True);
    dg2.Repaint;
   end;
end;

procedure TDSForm.dg2DblClick(Sender: TObject);
var s:ansistring;
begin
   with Sender as TDrawGrid do
   begin
    s:='AT+CS'+ IntToStr(Row);
    sendCMD(s,True);
   end;
end;

procedure TDSForm.btnColorClick(Sender: TObject);
var sl:TStringList;
    i,j,k:Integer;
    s:AnsiString;
begin
  with Sender as TSpeedButton do
   begin
    if (Tag=0) then
     begin
      if SvDlg.Execute then
       begin
         sl:=TStringList.Create;
         for i:=0 to 7 do
          begin
           sl.Add('// subprog='+inttostr(i));
           for j:=0 to 5 do sl.Add(IntToStr(colorProg[i,j]));
          end;
         sl.SavetoFile(SvDlg.Filename);
         sl.Free;
       end;
     end else
     begin
      if opDlg.Execute then
       begin
         sl:=TStringList.Create;
         sl.LoadFromFile(opDlg.Filename);
         k:=0;
         if (sl.Strings[k]='// subprog=0') then
          begin
           for i:=0 to 7 do
            begin
             Inc(k);
             for j:=0 to 5 do
              begin
               colorProg[i,j]:=StrToInt(sl.Strings[k]);
               s:='AT+C'+ IntToStr(i)+','+ IntToStr(j)+','+ IntToStr(colorProg[i,j]);
               sendCMD(s,True);
               sleep(200);
               Inc(k);
              end;
            end;
           sleep(200);
           sendCMD('AT+CS0',True);
          end;
         sl.Free;
         dg2.Repaint;
       end;
     end;
   end;
end;

procedure TDSForm.se1Change(Sender: TObject);
var s:ansistring;
begin
  with Sender as TSpinEdit do
   begin
    s:='AT+N'+inttostr(se1.Value)+','+inttostr(se2.Value)+','+inttostr(se3.Value);
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

procedure TDSForm.se4Change(Sender: TObject);
var s:ansistring;
begin
  with Sender as TSpinEdit do
   begin
    if Value>=10 then
     begin
      s:='AT+T'+inttostr(Value);
      sendCMD(s,True);
     end;
   end;
end;

procedure TDSForm.se5Change(Sender: TObject);
var cl:TColor;
begin
  with Sender as TSpinEdit do
   begin
    cl:=colorTab[Round(Value*95/strtoint(rg2.Items.Strings[rg2.ItemIndex]))];
    cl:=(cl shr 16)+(cl and $00FF00)+((cl and $FF) shl 16);
    lbl3.Font.Color:=cl;
    setTB:=True;
    trckbr1.Position:=bpGain[rg2.ItemIndex,se5.Value];
    lbl4.Caption:=FloatToStrF((bpGain[rg2.ItemIndex,se5.Value]+1)/32,ffFixed,6,4);
    setTB:=False;
   end;
end;

procedure TDSForm.rg2Click(Sender: TObject);
var s:ansistring;
begin
  with Sender as TRadioGroup do
   begin
    case Tag of
     0: begin
          s:='AT+QN'+rg2.Items.Strings[ItemIndex]; //inttostr(ItemIndex);
          se5.MaxValue:=strtoint(rg2.Items.Strings[ItemIndex])-1;
        end;
     1: s:='AT+U'+inttostr(ItemIndex);
     2: s:='AT+U'+inttostr(6-ItemIndex);
     3: s:='AT+R'+inttostr(ItemIndex);
     4: s:='AT+L'+Items.Strings[ItemIndex];
    end;
    sendCMD(s,True);
   end;
end;

procedure TDSForm.SpeedButton1Click(Sender: TObject);
begin
  with Sender as TSpeedButton do
   begin
     case (tag) of
      0: sendCMD('AT+SS',True);
      1: sendCMD('AT+SC',True);
      2: sendCMD('AT+SP',True);
      3: sendCMD('AT+SQ',True);
     end;
   end;
end;

procedure TDSForm.trckbr1Change(Sender: TObject);
var n,m:Integer;
    s:ansistring;
begin
  with Sender as TTrackBar do
   begin
    if not setTB then
     begin
      m:=rg2.ItemIndex;
      n:=se5.Value;
      bpGain[m,n]:=Position;
      lbl4.Caption:=FloatToStrF((bpGain[m,n]+1)/32,ffFixed,6,4);
      s:='AT+QG'+inttostr(n)+','+inttostr(Position);
      sendCMD(s,True);
     end;
   end;
end;

procedure TDSForm.btn10Click(Sender: TObject);
var sl:TStringList;
    i,j,k:Integer;
begin
  with Sender as TSpeedButton do
   begin
    if (Tag=0) then
     begin
      sl:=TStringList.Create;
      if SvDlg.Execute then
       begin
        for j:=0 to 7 do
         begin
          sl.Add('bpN='+IntToStr(j));
          for i:=0 to 31 do sl.Add(IntToStr(bpGain[j,i]));
         end;
        sl.SaveToFile(SvDlg.FileName);
        sl.Free;
       end;
     end else
     begin
      if opDlg.Execute then
       begin
        sl:=TStringList.Create;
        sl.LoadFromFile(opDlg.FileName);
        k:=0;
        for j:=0 to 7 do
         begin
          inc(k); // skip string
          for i:=0 to 31 do
           begin
            bpGain[j,i]:=StrToInt(sl.Strings[k]);
            inc(k);
           end;
         end;
        sl.Free;
       end;
     end;
   end;
end;

procedure TDSForm.btn13Click(Sender: TObject);
var sl:TStringList;
    i,j,k:Integer;
    s:AnsiString;
    load_end:Boolean;
begin
  with Sender as TSpeedButton do
   begin
    if (Tag=0) then
     begin
      if SvDlg.Execute then
       begin
         sl:=TStringList.Create;
         i:=0;
         repeat
          sl.Add('//play list prog['+inttostr(i+1)+']');
          sl.Add(IntToStr(PlayList[i].prog));
          sl.Add(IntToStr(PlayList[i].subprog));
          sl.Add(IntToStr(PlayList[i].direction));
          sl.Add(IntToStr(PlayList[i].tempo));
          inc(i);
         until(PlayList[i].prog=255);
         sl.SavetoFile(SvDlg.Filename);
         sl.Free;
       end;
     end else
     begin
      if opDlg.Execute then
       begin
         btn13.Enabled:=True;
         sl:=TStringList.Create;
         sl.LoadFromFile(opDlg.Filename);
         i:=0;
         k:=0;
         if (sl.Strings[i]='//play list prog[1]') then
          begin
            repeat
              Inc(i);
              PlayList[k].prog:=StrToInt(sl.Strings[i]);
              Inc(i);
              PlayList[k].subprog:=StrToInt(sl.Strings[i]);
              Inc(i);
              PlayList[k].direction:=StrToInt(sl.Strings[i]);
              Inc(i);
              PlayList[k].tempo:=StrToInt(sl.Strings[i]);
              s:='AT+I'+IntToStr(k)+','+IntToStr(PlayList[k].prog)+','+IntToStr(PlayList[k].subprog)+','+IntToStr(PlayList[k].direction)+','+IntToStr(PlayList[k].tempo);
              sendCMD(s,True);
              sleep(200);
              Inc(k);
              Inc(i);
              load_end:=True;
              if (i<sl.Count)then
               begin
                s:='//play list prog['+inttostr(k+1)+']';
                if (s=sl.Strings[i]) then load_end:=False;
               end;
            until(load_end);
          end;
         for i:=k to 79 do
          begin
           PlayList[i].prog:=255; // OFF
           PlayList[i].subprog:=0;
           PlayList[i].tempo:=40;
           PlayList[i].direction:=0;
          end;
         for i:=0 to sg1.RowCount-1 do
          begin
            for j:=0 to sg1.ColCount-1 do
             begin
               if (j=0) then
                begin
                  if (i>0) then sg1.Cells[j, i]:=IntToStr(i-1);
                end else
                begin
                  if (i=0) then
                   begin
                     case (j) of
                      1: sg1.Cells[j, i]:='prog';
                      2: sg1.Cells[j, i]:='subprog';
                      3: sg1.Cells[j, i]:='dir';
                      4: sg1.Cells[j, i]:='tempo';
                     end;
                   end else
                   begin
                     case (j) of
                      1: sg1.Cells[j, i]:=IntToStr(PlayList[i-1].prog);
                      2: sg1.Cells[j, i]:=IntToStr(PlayList[i-1].subprog);
                      3: sg1.Cells[j, i]:=IntToStr(PlayList[i-1].direction);
                      4: sg1.Cells[j, i]:=IntToStr(PlayList[i-1].tempo);
                     end;
                   end;
                end;
             end;
          end;
         sl.Free;
       end;
     end;
   end;
end;

end.

