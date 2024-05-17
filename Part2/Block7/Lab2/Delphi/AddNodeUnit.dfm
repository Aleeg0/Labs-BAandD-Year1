object uVCLAddNode: TuVCLAddNode
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077
  ClientHeight = 269
  ClientWidth = 474
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
    Left = 128
    Top = 24
    Width = 205
    Height = 26
    Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1075#1086#1088#1086#1076#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LbPairNodeInfo: TLabel
    Left = 32
    Top = 128
    Width = 198
    Height = 23
    Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1074#1077#1088#1096#1080#1085#1099':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object LbMainNodeInfo: TLabel
    Left = 32
    Top = 72
    Width = 101
    Height = 23
    Caption = #1050' '#1074#1077#1088#1096#1080#1085#1077':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object LbWeightInfo: TLabel
    Left = 32
    Top = 184
    Width = 93
    Height = 23
    Caption = #1042#1077#1089' '#1088#1077#1073#1088#1072':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object EdPairNode: TEdit
    Left = 256
    Top = 131
    Width = 21
    Height = 23
    MaxLength = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TextHint = '0'
    OnChange = EdPairNodeChange
  end
  object EdMainNode: TEdit
    Left = 153
    Top = 75
    Width = 21
    Height = 23
    MaxLength = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = '0'
    OnChange = EdMainNodeChange
  end
  object BtnAdd: TButton
    Left = 190
    Top = 224
    Width = 115
    Height = 33
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = BtnAddClick
  end
  object EdWeight: TEdit
    Left = 144
    Top = 187
    Width = 30
    Height = 23
    MaxLength = 3
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TextHint = '0'
    OnChange = EdWeightChange
  end
end
