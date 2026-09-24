[Setup]
AppName=Liberation Fonts Installer
AppVersion=1.0b1
AppPublisher=Daniele Lolli (UncleDan)
DefaultDirName={autopf}\LiberationFonts
DefaultGroupName=Liberation Fonts
OutputBaseFilename=Install_LiberationFonts_2.1.5
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin
WizardStyle=modern
DisableDirPage=yes
DisableProgramGroupPage=yes

[Files]
; Assicurati di avere la sottocartella "fonts" vicino a questo script con i relativi file TTF
Source: "liberation-fonts-ttf-2.1.5\LiberationSans-Regular.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Sans"; Flags: uninsneveruninstall; Check: IsFontSelected(0)
Source: "liberation-fonts-ttf-2.1.5\LiberationSans-Bold.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Sans Bold"; Flags: uninsneveruninstall; Check: IsFontSelected(1)
Source: "liberation-fonts-ttf-2.1.5\LiberationSans-Italic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Sans Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(2)
Source: "liberation-fonts-ttf-2.1.5\LiberationSans-BoldItalic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Sans Bold Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(3)
Source: "liberation-fonts-ttf-2.1.5\LiberationSerif-Regular.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Serif"; Flags: uninsneveruninstall; Check: IsFontSelected(4)
Source: "liberation-fonts-ttf-2.1.5\LiberationSerif-Bold.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Serif Bold"; Flags: uninsneveruninstall; Check: IsFontSelected(5)
Source: "liberation-fonts-ttf-2.1.5\LiberationSerif-Italic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Serif Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(6)
Source: "liberation-fonts-ttf-2.1.5\LiberationSerif-BoldItalic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Serif Bold Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(7)
Source: "liberation-fonts-ttf-2.1.5\LiberationMono-Regular.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Mono"; Flags: uninsneveruninstall; Check: IsFontSelected(8)
Source: "liberation-fonts-ttf-2.1.5\LiberationMono-Bold.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Mono Bold"; Flags: uninsneveruninstall; Check: IsFontSelected(9)
Source: "liberation-fonts-ttf-2.1.5\LiberationMono-Italic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Mono Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(10)
Source: "liberation-fonts-ttf-2.1.5\LiberationMono-BoldItalic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Mono Bold Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(11)

[Code]
var
  FontPage: TInputOptionWizardPage;
  DisclaimerPage: TOutputMsgWizardPage;

procedure InitializeWizard;
var
  FontDir: String;
begin
  FontDir := ExpandConstant('{autofonts}\');

  { 1. Pagina di selezione dinamica dei Font }
  FontPage := CreateInputOptionPage(wpWelcome,
    'Selezione Font Liberation',
    'Quali font desideri installare o aggiornare?',
    'I font non presenti nel sistema sono stati selezionati automaticamente. ' +
    'Puoi selezionare manualmente quelli già esistenti per forzarne la sovrascrittura o l''aggiornamento.',
    False, False);

  { Aggiunta dei font alla checklist. L'indice (0-11) deve corrispondere a IsFontSelected }
  FontPage.Add('Liberation Sans Regular');
  FontPage.Add('Liberation Sans Bold');
  FontPage.Add('Liberation Sans Italic');
  FontPage.Add('Liberation Sans Bold Italic');
  FontPage.Add('Liberation Serif Regular');
  FontPage.Add('Liberation Serif Bold');
  FontPage.Add('Liberation Serif Italic');
  FontPage.Add('Liberation Serif Bold Italic');
  FontPage.Add('Liberation Mono Regular');
  FontPage.Add('Liberation Mono Bold');
  FontPage.Add('Liberation Mono Italic');
  FontPage.Add('Liberation Mono Bold Italic');

  { Controllo di esistenza file: spunta solo quelli NON presenti }
  FontPage.Values[0] := not FileExists(FontDir + 'LiberationSans-Regular.ttf');
  FontPage.Values[1] := not FileExists(FontDir + 'LiberationSans-Bold.ttf');
  FontPage.Values[2] := not FileExists(FontDir + 'LiberationSans-Italic.ttf');
  FontPage.Values[3] := not FileExists(FontDir + 'LiberationSans-BoldItalic.ttf');
  FontPage.Values[4] := not FileExists(FontDir + 'LiberationSerif-Regular.ttf');
  FontPage.Values[5] := not FileExists(FontDir + 'LiberationSerif-Bold.ttf');
  FontPage.Values[6] := not FileExists(FontDir + 'LiberationSerif-Italic.ttf');
  FontPage.Values[7] := not FileExists(FontDir + 'LiberationSerif-BoldItalic.ttf');
  FontPage.Values[8] := not FileExists(FontDir + 'LiberationMono-Regular.ttf');
  FontPage.Values[9] := not FileExists(FontDir + 'LiberationMono-Bold.ttf');
  FontPage.Values[10] := not FileExists(FontDir + 'LiberationMono-Italic.ttf');
  FontPage.Values[11] := not FileExists(FontDir + 'LiberationMono-BoldItalic.ttf');

  { 2. Pagina Disclaimer e riepilogo Sovrascrittura prima dell'installazione }
  DisclaimerPage := CreateOutputMsgPage(FontPage.ID,
    'Licenza e Riepilogo Operazioni',
    'Informazioni legali e dettaglio dei file da sovrascrivere',
    '');
end;

procedure CurPageChanged(CurPageID: Integer);
var
  Summary: String;
  i: Integer;
  AnySelected: Boolean;
begin
  if CurPageID = DisclaimerPage.ID then
  begin
    Summary := 'LICENZA E INFORMAZIONI:' + #13#10 +
               '- I font della famiglia Liberation sono distribuiti sotto licenza SIL Open Font License 1.1.' + #13#10 +
               '- Il codice sorgente e il repository ufficiale sono ospitati su GitHub.' + #13#10 +
               '- ATTENZIONE: Questo pacchetto di installazione non è in alcun modo affiliato, ' +
               'sponsorizzato o supportato dagli sviluppatori originali.' + #13#10#13#10 +
               'RIEPILOGO INSTALLAZIONE / SOVRASCRITTURE:' + #13#10;

    AnySelected := False;
    for i := 0 to (FontPage.CheckListBox.Items.Count - 1) do
    begin
      if FontPage.Values[i] then
      begin
        Summary := Summary + '  [+] ' + FontPage.CheckListBox.Items[i] + #13#10;
        AnySelected := True;
      end;
    end;

    if not AnySelected then
      Summary := Summary + '  (Nessun font selezionato. L''installazione non modificherà alcun file.)' + #13#10;

    Summary := Summary + #13#10 + 'Procedendo, confermi di accettare la licenza e l''installazione dei file elencati.';
    
    DisclaimerPage.Msg := Summary;
  end;
end;

function IsFontSelected(Index: Integer): Boolean;
begin
  Result := FontPage.Values[Index];
end;
