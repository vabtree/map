object TForm: TTForm
  Left = 265
  Top = 155
  BorderStyle = bsSingle
  Caption = 'Multiple Applications'
  ClientHeight = 54
  ClientWidth = 309
  Color = 11856874
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object lbcbbox: TLabel
    Left = 8
    Top = 3
    Width = 195
    Height = 16
    Caption = 'Please select application from list:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnRun: TBitBtn
    Left = 242
    Top = 23
    Width = 57
    Height = 23
    Caption = '&Run'
    TabOrder = 0
    OnClick = btnRunClick
  end
  object cbVersionSelect: TComboBox
    Left = 7
    Top = 25
    Width = 226
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    Color = clInfoBk
    ItemHeight = 13
    TabOrder = 1
    OnChange = cbVersionSelectChange
  end
  object cbOnTop: TCheckBox
    Left = 216
    Top = 3
    Width = 96
    Height = 20
    BiDiMode = bdLeftToRight
    Caption = 'Stay on top'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 2
    OnClick = cbOnTopClick
  end
end
