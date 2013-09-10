object PopBgExtract: TPopBgExtract
  Left = 192
  Top = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Populous Background Extractor'
  ClientHeight = 168
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object image: TImage
    Left = 8
    Top = 8
    Width = 160
    Height = 120
  end
  object image_full: TImage
    Left = 24
    Top = 24
    Width = 49
    Height = 41
    Visible = False
  end
  object About: TLabel
    Left = 8
    Top = 144
    Width = 119
    Height = 13
    Caption = 'http://www.alacn.cjb.net'
  end
  object btnImg1: TButton
    Left = 176
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Image 1'
    TabOrder = 0
    OnClick = btnImg1Click
  end
  object btnImg2: TButton
    Left = 176
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Image 2'
    TabOrder = 1
    OnClick = btnImg2Click
  end
  object btnImg3: TButton
    Left = 176
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Image3'
    TabOrder = 2
    OnClick = btnImg3Click
  end
  object btnImg4: TButton
    Left = 176
    Top = 104
    Width = 75
    Height = 25
    Caption = 'Secret'
    TabOrder = 3
    OnClick = btnImg4Click
  end
  object btnSave: TButton
    Left = 176
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Save'
    Enabled = False
    TabOrder = 4
    OnClick = btnSaveClick
  end
end
