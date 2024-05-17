object uVCLFindPath: TuVCLFindPath
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form2'
  ClientHeight = 270
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object LbFormInfo: TLabel
    Left = 112
    Top = 24
    Width = 276
    Height = 26
    Caption = #1055#1086#1080#1089#1082' '#1082#1088#1072#1090#1095#1072#1081#1096#1077#1075#1086' '#1087#1091#1090#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LbStartNodeInfo: TLabel
    Left = 32
    Top = 72
    Width = 178
    Height = 23
    Caption = #1057#1090#1072#1088#1090#1086#1074#1072#1103' '#1074#1077#1088#1096#1080#1085#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object LbEndNodeInfo: TLabel
    Left = 32
    Top = 128
    Width = 171
    Height = 23
    Caption = #1050#1086#1085#1077#1095#1085#1072#1103' '#1074#1077#1088#1096#1080#1085#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object LbMinPath: TLabel
    Left = 172
    Top = 186
    Width = 301
    Height = 76
    AutoSize = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object EdStartNode: TEdit
    Left = 240
    Top = 75
    Width = 21
    Height = 23
    MaxLength = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = '0'
    OnChange = EdStartNodeChange
  end
  object EdEndNode: TEdit
    Left = 240
    Top = 131
    Width = 21
    Height = 23
    MaxLength = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TextHint = '0'
    OnChange = EdEndNodeChange
  end
  object BtnFind: TButton
    Left = 32
    Top = 184
    Width = 115
    Height = 33
    Caption = #1053#1072#1081#1090#1080
    Enabled = False
    TabOrder = 2
    OnClick = BtnFindClick
  end
end
