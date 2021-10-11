object Form1: TForm1
  Left = 251
  Top = 130
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Peripherals'
  ClientHeight = 266
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  PixelsPerInch = 120
  TextHeight = 17
  object Button1: TButton
    Left = 400
    Top = 232
    Width = 105
    Height = 25
    Caption = 'Eject'
    TabOrder = 0
    OnClick = Button1Click
  end
  object CheckListBox1: TCheckListBox
    Left = 8
    Top = 8
    Width = 617
    Height = 217
    ItemHeight = 17
    TabOrder = 1
  end
  object Button2: TButton
    Left = 512
    Top = 232
    Width = 113
    Height = 25
    Caption = 'Refresh'
    TabOrder = 2
    OnClick = Button2Click
  end
end
