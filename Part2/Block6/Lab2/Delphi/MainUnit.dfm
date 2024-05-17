object uVCLMain: TuVCLMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1045#1075#1086#1088#1086#1074' '#1040'.'#1057'. 351005 Lab6.2'
  ClientHeight = 865
  ClientWidth = 915
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 15
  object LbInfo: TLabel
    Left = 160
    Top = 8
    Width = 425
    Height = 25
    AutoSize = False
    Caption = #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1089#1090#1088#1086#1080#1090' '#1084#1072#1075#1080#1095#1077#1089#1082#1080#1081' '#1082#1074#1072#1076#1088#1072#1090' '#1085#1077#1095#1105#1090#1085#1086#1081' '#1089#1090#1077#1087#1077#1085#1080'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object LbSizeInfo: TLabel
    Left = 160
    Top = 55
    Width = 241
    Height = 25
    AutoSize = False
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1085#1077#1095#1077#1090#1085#1086#1077' '#1095#1080#1089#1083#1086' '#1086#1090' 3 '#1076#1086' 9'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object ESize: TEdit
    Left = 416
    Top = 56
    Width = 113
    Height = 23
    MaxLength = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = #1062#1080#1092#1088#1072
    OnChange = ESizeChange
    OnKeyPress = ESizeKeyPress
  end
  object StrGrSquare: TStringGrid
    Left = 384
    Top = 400
    Width = 129
    Height = 129
    BiDiMode = bdLeftToRight
    Color = clWhite
    DefaultColWidth = 40
    DefaultColAlignment = taCenter
    DefaultRowHeight = 40
    Enabled = False
    FixedColor = clWindow
    FixedCols = 0
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goFixedRowDefAlign]
    ParentBiDiMode = False
    ScrollBars = ssNone
    TabOrder = 1
    Visible = False
  end
  object BitBtnAccept: TBitBtn
    Left = 552
    Top = 55
    Width = 153
    Height = 25
    Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
    TabOrder = 2
    OnClick = BitBtnAcceptClick
  end
  object BitBtnNext: TBitBtn
    Left = 384
    Top = 823
    Width = 153
    Height = 34
    Caption = #1057#1083#1077#1076#1091#1102#1097#1080#1081' '#1096#1072#1075
    Enabled = False
    TabOrder = 3
    Visible = False
    OnClick = BitBtnNextClick
  end
  object MainMenu1: TMainMenu
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    Left = 848
    Top = 24
    object btFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object btOpenFile: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = btOpenFileClick
      end
      object btSaveFile: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        Enabled = False
        ShortCut = 16467
        OnClick = btSaveFileClick
      end
    end
    object btInstruction: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      OnClick = btInstructionClick
    end
    object btAboutTheDeveloper: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = btAboutTheDeveloperClick
    end
  end
  object SaveDialog1: TSaveDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' (*.txt)|*txt'
    Left = 848
    Top = 88
  end
  object OpenDialog1: TOpenDialog
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' (.txt)|*txt'
    Left = 848
    Top = 144
  end
end
