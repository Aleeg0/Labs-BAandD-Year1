object uVCLDelete: TuVCLDelete
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1059#1076#1072#1083#1077#1085#1080#1077
  ClientHeight = 230
  ClientWidth = 453
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
    Left = 136
    Top = 24
    Width = 214
    Height = 26
    Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1074#1077#1088#1096#1080#1085#1099
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
    Width = 174
    Height = 23
    Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1074#1077#1088#1096#1080#1085#1099':'
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
    Width = 102
    Height = 23
    Caption = #1059' '#1074#1077#1088#1096#1080#1085#1077':'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
  end
  object EdPairNode: TEdit
    Left = 232
    Top = 131
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
    Left = 160
    Top = 75
    Width = 33
    Height = 23
    MaxLength = 2
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TextHint = '0'
    OnChange = EdMainNodeChange
  end
  object BtnDelete: TButton
    Left = 192
    Top = 184
    Width = 115
    Height = 33
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = BtnDeleteClick
  end
end
