object uVCLDeleter: TuVCLDeleter
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1056#1072#1073#1086#1095#1077#1075#1086
  ClientHeight = 130
  ClientWidth = 325
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
  object lbDeleterInfo: TLabel
    Left = 8
    Top = 16
    Width = 305
    Height = 49
    AutoSize = False
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1085#1086#1084#1077#1088' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103', '#1082#1086#1090#1086#1088#1086#1075#1086' '#1093#1086#1090#1080#1090#1077' '#1091#1076#1072#1083#1080#1090#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object eNumberOfWorker: TEdit
    Left = 125
    Top = 40
    Width = 121
    Height = 23
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TextHint = 'A'
    OnChange = eNumberOfWorkerChange
    OnKeyDown = eNumberOfWorkerKeyDown
  end
  object BitbtDelete: TBitBtn
    Left = 125
    Top = 83
    Width = 177
    Height = 34
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = BitbtDeleteClick
  end
end
