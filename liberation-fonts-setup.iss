[Setup]
AppName=Liberation Fonts Installer
AppVersion=1.0
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
LanguageDetectionMethod=none
ShowLanguageDialog=no

[Files]
Source: "fonts\LiberationSans-Regular.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Sans"; Flags: uninsneveruninstall; Check: IsFontSelected(0)
Source: "fonts\LiberationSans-Bold.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Sans Bold"; Flags: uninsneveruninstall; Check: IsFontSelected(1)
Source: "fonts\LiberationSans-Italic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Sans Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(2)
Source: "fonts\LiberationSans-BoldItalic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Sans Bold Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(3)
Source: "fonts\LiberationSerif-Regular.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Serif"; Flags: uninsneveruninstall; Check: IsFontSelected(4)
Source: "fonts\LiberationSerif-Bold.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Serif Bold"; Flags: uninsneveruninstall; Check: IsFontSelected(5)
Source: "fonts\LiberationSerif-Italic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Serif Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(6)
Source: "fonts\LiberationSerif-BoldItalic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Serif Bold Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(7)
Source: "fonts\LiberationMono-Regular.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Mono"; Flags: uninsneveruninstall; Check: IsFontSelected(8)
Source: "fonts\LiberationMono-Bold.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Mono Bold"; Flags: uninsneveruninstall; Check: IsFontSelected(9)
Source: "fonts\LiberationMono-Italic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Mono Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(10)
Source: "fonts\LiberationMono-BoldItalic.ttf"; DestDir: "{autofonts}"; FontInstall: "Liberation Mono Bold Italic"; Flags: uninsneveruninstall; Check: IsFontSelected(11)

[Code]
var
  InstallerScriptVersion: String;
  LicensePage: TOutputMsgMemoWizardPage;
  AcceptFontsCheckbox: TNewCheckBox;
  AcceptInstallerCheckbox: TNewCheckBox;
  FontPage: TInputOptionWizardPage;
  ConfirmPage: TOutputMsgMemoWizardPage;

procedure LicenseCheckboxesClick(Sender: TObject);
begin
  WizardForm.NextButton.Enabled := AcceptFontsCheckbox.Checked and AcceptInstallerCheckbox.Checked;
end;

procedure InitializeWizard;
var
  FontDir: String;
begin
  InstallerScriptVersion := '1.0';
  FontDir := ExpandConstant('{autofonts}\');

  { 1. Custom License Page with Two Checkboxes }
  LicensePage := CreateOutputMsgMemoPage(wpWelcome,
    'License Agreements',
    'Please read the following important information before continuing.',
    'Review the licensing terms for both the Liberation Fonts and this installer script.',
    '');

  AcceptInstallerCheckbox := TNewCheckBox.Create(LicensePage);
  AcceptInstallerCheckbox.Parent := LicensePage.Surface;
  AcceptInstallerCheckbox.Caption := 'I accept the MIT License for the Installer Script';
  AcceptInstallerCheckbox.Left := 0;
  AcceptInstallerCheckbox.Width := LicensePage.SurfaceWidth;
  AcceptInstallerCheckbox.Top := LicensePage.SurfaceHeight - AcceptInstallerCheckbox.Height;
  AcceptInstallerCheckbox.OnClick := @LicenseCheckboxesClick;

  AcceptFontsCheckbox := TNewCheckBox.Create(LicensePage);
  AcceptFontsCheckbox.Parent := LicensePage.Surface;
  AcceptFontsCheckbox.Caption := 'I accept the SIL Open Font License 1.1 for Liberation Fonts';
  AcceptFontsCheckbox.Left := 0;
  AcceptFontsCheckbox.Width := LicensePage.SurfaceWidth;
  AcceptFontsCheckbox.Top := AcceptInstallerCheckbox.Top - AcceptFontsCheckbox.Height - 4;
  AcceptFontsCheckbox.OnClick := @LicenseCheckboxesClick;
  
  LicensePage.RichEditViewer.Height := AcceptFontsCheckbox.Top - LicensePage.RichEditViewer.Top - 8;

  { 2. Dynamic Font Selection Page }
  FontPage := CreateInputOptionPage(LicensePage.ID,
    'Font Selection',
    'Which fonts do you want to install or update?',
    'Fonts not currently installed on your system have been selected automatically. ' +
    'You can manually select existing fonts to force an update or overwrite.',
    False, False);

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

  { 3. Confirmation Page }
  ConfirmPage := CreateOutputMsgMemoPage(FontPage.ID,
    'Installation Summary',
    'Review the actions that will be performed.',
    'Please confirm the installation and overwrite operations before proceeding.',
    '');
end;

procedure CurPageChanged(CurPageID: Integer);
var
  Summary: String;
  i: Integer;
  AnySelected: Boolean;
  ExistingFiles: String;
  NewFiles: String;
  FileNameStr: String;
  FontDir: String;
begin
  if CurPageID = LicensePage.ID then
  begin
    WizardForm.NextButton.Enabled := AcceptFontsCheckbox.Checked and AcceptInstallerCheckbox.Checked;
    LicensePage.RichEditViewer.Text := 
      '--- LIBERATION FONTS LICENSE ---' + #13#10 +
      'The Liberation Fonts are distributed under the SIL Open Font License 1.1.' + #13#10 +
      'The source code and official repository are hosted on GitHub at:' + #13#10 +
      'https://github.com/liberationfonts/liberation-fonts' + #13#10#13#10 +
      'PLEASE NOTE: This installation package is in no way affiliated, ' +
      'sponsored, or supported by the original Liberation Fonts developers.' + #13#10#13#10 +
      '--- INSTALLER SCRIPT LICENSE ---' + #13#10 +
      'Installer Script Version: ' + InstallerScriptVersion + #13#10 +
      'Author: Daniele Lolli (UncleDan)' + #13#10 +
      'MIT License' + #13#10#13#10 +
      'Copyright (c) 2026 Daniele Lolli (UncleDan)' + #13#10#13#10 +
      'Permission is hereby granted, free of charge, to any person obtaining a copy ' +
      'of this software and associated documentation files (the "Software"), to deal ' +
      'in the Software without restriction, including without limitation the rights ' +
      'to use, copy, modify, merge, publish, distribute, sublicense, and/or sell ' +
      'copies of the Software, and to permit persons to whom the Software is ' +
      'furnished to do so, subject to the following conditions:' + #13#10#13#10 +
      'The above copyright notice and this permission notice shall be included in all ' +
      'copies or substantial portions of the Software.';
  end;

  if CurPageID = ConfirmPage.ID then
  begin
    FontDir := ExpandConstant('{autofonts}\');
    AnySelected := False;
    NewFiles := '';
    ExistingFiles := '';

    for i := 0 to (FontPage.CheckListBox.Items.Count - 1) do
    begin
      if FontPage.Values[i] then
      begin
        AnySelected := True;
        case i of
          0: FileNameStr := 'LiberationSans-Regular.ttf';
          1: FileNameStr := 'LiberationSans-Bold.ttf';
          2: FileNameStr := 'LiberationSans-Italic.ttf';
          3: FileNameStr := 'LiberationSans-BoldItalic.ttf';
          4: FileNameStr := 'LiberationSerif-Regular.ttf';
          5: FileNameStr := 'LiberationSerif-Bold.ttf';
          6: FileNameStr := 'LiberationSerif-Italic.ttf';
          7: FileNameStr := 'LiberationSerif-BoldItalic.ttf';
          8: FileNameStr := 'LiberationMono-Regular.ttf';
          9: FileNameStr := 'LiberationMono-Bold.ttf';
          10: FileNameStr := 'LiberationMono-Italic.ttf';
          11: FileNameStr := 'LiberationMono-BoldItalic.ttf';
        end;

        if FileExists(FontDir + FileNameStr) then
          ExistingFiles := ExistingFiles + '  [OVERWRITE] ' + FontPage.CheckListBox.Items[i] + #13#10
        else
          NewFiles := NewFiles + '  [INSTALL] ' + FontPage.CheckListBox.Items[i] + #13#10;
      end;
    end;

    Summary := 'SUMMARY OF OPERATIONS:' + #13#10#13#10;
    
    if not AnySelected then
    begin
      Summary := Summary + '(No fonts selected. The installer will not modify any files.)' + #13#10;
    end
    else
    begin
      if NewFiles <> '' then
        Summary := Summary + 'NEW FONTS TO INSTALL:' + #13#10 + NewFiles + #13#10;
        
      if ExistingFiles <> '' then
        Summary := Summary + 'WARNING - THE FOLLOWING EXISTING FONTS WILL BE OVERWRITTEN:' + #13#10 + ExistingFiles + #13#10;
    end;

    Summary := Summary + #13#10 + 'Click "Install" to execute these actions.';
    ConfirmPage.RichEditViewer.Text := Summary;
  end;
end;

function IsFontSelected(Index: Integer): Boolean;
begin
  Result := FontPage.Values[Index];
end;