object uVCLMatrix: TuVCLMatrix
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1084#1072#1090#1088#1080#1094#1072
  ClientHeight = 316
  ClientWidth = 338
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 350
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnShow = FormShow
  TextHeight = 15
  object LbFormInfo: TLabel
    AlignWithMargins = True
    Left = 0
    Top = 30
    Width = 338
    Height = 24
    Margins.Left = 0
    Margins.Top = 30
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alTop
    Alignment = taCenter
    Caption = #1052#1072#1090#1088#1080#1094#1072' '#1089#1084#1077#1078#1085#1086#1089#1090#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitLeft = -5
  end
  object StrGrMatrix: TStringGrid
    AlignWithMargins = True
    Left = 30
    Top = 109
    Width = 278
    Height = 197
    Margins.Left = 30
    Margins.Top = 55
    Margins.Right = 30
    Margins.Bottom = 10
    Align = alClient
    ColCount = 3
    DefaultColWidth = 45
    DefaultColAlignment = taCenter
    DefaultRowHeight = 45
    RowCount = 3
    TabOrder = 0
    ExplicitLeft = 45
    ExplicitTop = 156
    ExplicitWidth = 248
    ExplicitHeight = 150
  end
end
