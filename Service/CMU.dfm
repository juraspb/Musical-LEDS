object DSForm: TDSForm
  Left = 224
  Top = 326
  ActiveControl = se2
  Caption = 'Musical LEDs service program'
  ClientHeight = 362
  ClientWidth = 948
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 24
    Top = 192
    Width = 136
    Height = 20
    Caption = 'Dinamic program'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clFuchsia
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl2: TLabel
    Left = 16
    Top = 296
    Width = 61
    Height = 20
    Caption = 'TEMPO'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clFuchsia
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 16
    Top = 144
    Width = 177
    Height = 22
    Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102' '#1074#1086' FLASH '#1052#1050
    Caption = 'CONFIG WRITE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton1Click
  end
  object SB: TStatusBar
    Left = 0
    Top = 338
    Width = 948
    Height = 24
    Panels = <
      item
        Width = 200
      end
      item
        Width = 210
      end
      item
        Width = 50
      end>
  end
  object GroupBox1: TGroupBox
    Left = 12
    Top = 8
    Width = 185
    Height = 129
    Caption = 'PORT'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label4: TLabel
      Left = 18
      Top = 28
      Width = 40
      Height = 20
      Caption = 'COM:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 25
      Top = 61
      Width = 62
      Height = 20
      Caption = 'Disabled'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ComboBox1: TComboBox
      Left = 65
      Top = 26
      Width = 96
      Height = 28
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ItemIndex = 3
      ParentFont = False
      TabOrder = 0
      Text = 'COM4'
      OnChange = ComboBox1Change
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8')
    end
    object Button3: TButton
      Left = 128
      Top = 92
      Width = 41
      Height = 25
      Hint = #1055#1077#1088#1077#1076#1072#1090#1100' AT '#1082#1086#1084#1072#1085#1076#1091
      Caption = 'SEND'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button3Click
    end
    object edt1: TEdit
      Left = 12
      Top = 92
      Width = 109
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      Text = 'AT+H'
    end
  end
  object PLAY: TPageControl
    Left = 206
    Top = 0
    Width = 742
    Height = 338
    ActivePage = ts5
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object ts5: TTabSheet
      Caption = 'LEDs'
      ImageIndex = 4
      object lbl3: TLabel
        Left = 24
        Top = 240
        Width = 95
        Height = 22
        Caption = 'BandPass'
        Color = clBtnFace
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clRed
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object lbl4: TLabel
        Left = 360
        Top = 272
        Width = 46
        Height = 22
        Caption = 'GAIN'
        Color = clBtnFace
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object btn9: TSpeedButton
        Tag = 3
        Left = 624
        Top = 280
        Width = 89
        Height = 22
        Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1086' FLASH '#1052#1050
        Caption = 'WRITE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton1Click
      end
      object btn10: TSpeedButton
        Left = 624
        Top = 216
        Width = 89
        Height = 22
        Hint = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074' '#1092#1072#1081#1083
        Caption = 'SAVE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = btn10Click
      end
      object btn11: TSpeedButton
        Tag = 1
        Left = 624
        Top = 240
        Width = 89
        Height = 22
        Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
        Caption = 'LOAD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = btn10Click
      end
      object rg1: TRadioGroup
        Tag = 4
        Left = 12
        Top = 12
        Width = 220
        Height = 150
        Caption = 'LEDs'
        Columns = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemIndex = 2
        Items.Strings = (
          '30'
          '60'
          '120'
          '240'
          '36'
          '72'
          '144'
          '216'
          '50'
          '100'
          '150'
          '200')
        ParentFont = False
        TabOrder = 0
        OnClick = rg2Click
      end
      object rg3: TRadioGroup
        Tag = 3
        Left = 252
        Top = 12
        Width = 85
        Height = 197
        Caption = 'RGB'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemIndex = 0
        Items.Strings = (
          'RGB'
          'GRB'
          'BGR'
          'BRG'
          'GBR'
          'RBG')
        ParentFont = False
        TabOrder = 1
        OnClick = rg2Click
      end
      object rg2: TRadioGroup
        Left = 356
        Top = 12
        Width = 101
        Height = 197
        Caption = 'Band pass'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemIndex = 2
        Items.Strings = (
          '5'
          '6'
          '10'
          '15'
          '18'
          '20'
          '30')
        ParentFont = False
        TabOrder = 2
        OnClick = rg2Click
      end
      object se5: TSpinEdit
        Left = 128
        Top = 232
        Width = 65
        Height = 42
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -27
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxValue = 29
        MinValue = 0
        ParentFont = False
        TabOrder = 3
        Value = 0
        OnChange = se5Change
      end
      object trckbr1: TTrackBar
        Left = 208
        Top = 240
        Width = 393
        Height = 33
        Max = 255
        Frequency = 16
        Position = 32
        TabOrder = 4
        OnChange = trckbr1Change
      end
      object rg4: TRadioGroup
        Tag = 1
        Left = 492
        Top = 12
        Width = 197
        Height = 77
        Caption = 'Audio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemIndex = 0
        Items.Strings = (
          'Micrphone'
          'Line In')
        ParentFont = False
        TabOrder = 5
        OnClick = rg2Click
      end
      object rg5: TRadioGroup
        Tag = 2
        Left = 492
        Top = 104
        Width = 197
        Height = 105
        Caption = 'Microphone Gain'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemIndex = 0
        Items.Strings = (
          '60db'
          '50db'
          '40db')
        ParentFont = False
        TabOrder = 6
        OnClick = rg2Click
      end
    end
    object ts1: TTabSheet
      Caption = 'COLOR'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object btn1: TSpeedButton
        Left = 8
        Top = 16
        Width = 57
        Height = 22
        Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1052#1050
        Caption = 'READ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = btn1Click
      end
      object btn3: TSpeedButton
        Tag = 1
        Left = 8
        Top = 40
        Width = 57
        Height = 22
        Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1086' FLASH '#1052#1050
        Caption = 'WRITE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton1Click
      end
      object btn7: TSpeedButton
        Left = 8
        Top = 112
        Width = 57
        Height = 22
        Hint = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074' '#1092#1072#1081#1083
        Caption = 'SAVE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = btnColorClick
      end
      object btn8: TSpeedButton
        Tag = 1
        Left = 8
        Top = 136
        Width = 57
        Height = 22
        Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
        Caption = 'LOAD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = btnColorClick
      end
      object dg1: TDrawGrid
        Left = 320
        Top = 8
        Width = 403
        Height = 180
        Hint = #1058#1072#1073#1083#1080#1094#1072' '#1094#1074#1077#1090#1086#1074'  ('#1076#1074#1086#1081#1085#1086#1081' '#1082#1083#1080#1082' '#1076#1083#1103' '#1091#1089#1090#1072#1085#1086#1074#1082#1080')'
        ColCount = 16
        DefaultColWidth = 24
        FixedCols = 0
        RowCount = 7
        FixedRows = 0
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnDblClick = dg1DblClick
        OnDrawCell = dg1DrawCell
      end
      object dg2: TDrawGrid
        Left = 72
        Top = 8
        Width = 236
        Height = 270
        Hint = #1062#1074#1077#1090#1072' '#1087#1086#1076#1087#1088#1086#1075#1088#1072#1084#1084' ('#1082#1083#1080#1082' '#1076#1083#1103' '#1074#1099#1073#1086#1088#1072' '#1094#1074#1077#1090#1072')'
        ColCount = 7
        DefaultColWidth = 32
        DefaultRowHeight = 32
        RowCount = 8
        FixedRows = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnDblClick = dg2DblClick
        OnDrawCell = dg2DrawCell
        OnSelectCell = dg2SelectCell
      end
      object Memo2: TMemo
        Left = 320
        Top = 192
        Width = 401
        Height = 97
        BorderStyle = bsNone
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = []
        Lines.Strings = (
          'Load colors of subroutines from CMU or from a file. Double'
          'click  on  the  left  window  displays  the  colors  used  in'
          'subroutine  on  tape.  A click in the left window selects a'
          'color.  Double  click  in  the  right  window  changes'
          'the selected color in the subroutine.')
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
    end
    object ts4: TTabSheet
      Caption = 'PlayList'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object btn4: TSpeedButton
        Tag = 2
        Left = 360
        Top = 36
        Width = 113
        Height = 22
        Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1086' FLASH '#1052#1050
        Caption = 'STORE'
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton1Click
      end
      object btn12: TSpeedButton
        Tag = 1
        Left = 360
        Top = 120
        Width = 113
        Height = 22
        Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
        Caption = 'LOAD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = btn13Click
      end
      object btn13: TSpeedButton
        Left = 360
        Top = 96
        Width = 113
        Height = 22
        Hint = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074' '#1092#1072#1081#1083
        Caption = 'SAVE'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = btn13Click
      end
      object sg1: TStringGrid
        Left = 0
        Top = 0
        Width = 345
        Height = 310
        Hint = #1044#1074#1086#1081#1085#1086#1081' '#1082#1083#1080#1082' '#1076#1083#1103' '#1074#1099#1074#1086#1076#1072' '#1087#1086#1076#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1085#1072' '#1083#1077#1085#1090#1091'.'
        Align = alLeft
        DefaultRowHeight = 18
        RowCount = 81
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnDblClick = sg1DblClick
        OnSetEditText = sg1SetEditText
      end
      object btn2: TBitBtn
        Left = 360
        Top = 8
        Width = 113
        Height = 25
        Hint = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1052#1050
        Caption = 'READ'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btn2Click
      end
    end
    object ts2: TTabSheet
      Caption = 'Monitor'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Memo1: TMemo
        Left = 96
        Top = 0
        Width = 638
        Height = 310
        Align = alRight
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Button1: TButton
        Left = 4
        Top = 8
        Width = 85
        Height = 25
        Caption = 'CLEAR'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = Button1Click
      end
      object btn6: TButton
        Left = 4
        Top = 40
        Width = 85
        Height = 25
        Caption = 'SAVE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = btn6Click
      end
    end
    object ts3: TTabSheet
      Caption = 'only you'
      ImageIndex = 3
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object btn5: TButton
        Left = 16
        Top = 9
        Width = 81
        Height = 25
        Caption = 'HEMMING'
        TabOrder = 0
        OnClick = btn5Click
      end
    end
  end
  object se1: TSpinEdit
    Left = 16
    Top = 224
    Width = 65
    Height = 47
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxValue = 29
    MinValue = 0
    ParentFont = False
    TabOrder = 3
    Value = 0
    OnChange = se1Change
  end
  object se2: TSpinEdit
    Left = 88
    Top = 224
    Width = 49
    Height = 47
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxValue = 7
    MinValue = 0
    ParentFont = False
    TabOrder = 4
    Value = 0
    OnChange = se1Change
  end
  object se3: TSpinEdit
    Left = 144
    Top = 224
    Width = 49
    Height = 47
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxValue = 5
    MinValue = 0
    ParentFont = False
    TabOrder = 5
    Value = 0
    OnChange = se1Change
  end
  object se4: TSpinEdit
    Left = 80
    Top = 288
    Width = 113
    Height = 39
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    MaxValue = 240
    MinValue = 10
    ParentFont = False
    TabOrder = 6
    Value = 100
    OnChange = se4Change
  end
  object cnfgTimer: TTimer
    Enabled = False
    OnTimer = cnfgTimerTimer
    Left = 256
    Top = 192
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 320
    Top = 192
  end
  object SvDlg: TSaveDialog
    DefaultExt = 'txt'
    Left = 288
    Top = 192
  end
  object opDlg: TOpenDialog
    Left = 224
    Top = 192
  end
end
