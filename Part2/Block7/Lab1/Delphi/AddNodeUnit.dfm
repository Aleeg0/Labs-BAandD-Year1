object uVCLAddNode: TuVCLAddNode
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077
  ClientHeight = 240
  ClientWidth = 461
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
    Width = 242
    Height = 26
    Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1074#1077#1088#1096#1080#1085#1099
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LbPairNodeInfo: TLabel
    Left = 32
    Top = 80
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
    Top = 136
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
  object EdPairNode: TEdit
    Left = 272
    Top = 83
    Width = 33
    Height = 23
    MaxLength = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = '0'
    OnChange = EdPairNodeChange
  end
  object EdMainNode: TEdit
    Left = 168
    Top = 139
    Width = 33
    Height = 23
    MaxLength = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TextHint = '0'
    OnChange = EdMainNodeChange
  end
  object BtnAdd: TButton
    Left = 184
    Top = 184
    Width = 115
    Height = 33
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = BtnAddClick
  end
end
