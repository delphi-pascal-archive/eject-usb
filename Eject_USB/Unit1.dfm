object RetirerUSB: TRetirerUSB
  Left = 254
  Top = 133
  BorderStyle = bsDialog
  Caption = 'Eject USB'
  ClientHeight = 225
  ClientWidth = 226
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 120
  TextHeight = 17
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 103
    Height = 16
    Caption = 'Select volume:'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Eject: TButton
    Left = 8
    Top = 192
    Width = 209
    Height = 25
    Caption = 'Eject USB'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = EjectClick
  end
  object ListeUSB: TCheckListBox
    Left = 8
    Top = 32
    Width = 209
    Height = 153
    Color = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentFont = False
    TabOrder = 1
  end
end
