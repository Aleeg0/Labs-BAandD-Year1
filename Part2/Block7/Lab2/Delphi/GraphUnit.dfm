object uVCLGraph: TuVCLGraph
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1043#1088#1072#1092
  ClientHeight = 438
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object PaintBox: TPaintBox
    Left = 0
    Top = 0
    Width = 571
    Height = 438
    Align = alClient
    OnPaint = PaintBoxPaint
    ExplicitWidth = 628
    ExplicitHeight = 465
  end
end
