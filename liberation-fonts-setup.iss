[Setup]
AppName=Liberation Fonts
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
DisableReadyPage=yes
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
  FontPackageVersion: String;
  LicensePage: TOutputMsgMemoWizardPage;
  AcceptFontsCheckbox: TNewCheckBox;
  AcceptInstallerCheckbox: TNewCheckBox;
  FontPage: TInputOptionWizardPage;
  SelectAllCheckbox: TNewCheckBox;
  ConfirmPage: TOutputMsgMemoWizardPage;

procedure LicenseCheckboxesClick(Sender: TObject);
begin
  WizardForm.NextButton.Enabled := AcceptFontsCheckbox.Checked and AcceptInstallerCheckbox.Checked;
end;

procedure SelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to FontPage.CheckListBox.Items.Count - 1 do
  begin
    FontPage.Values[i] := SelectAllCheckbox.Checked;
  end;
end;

function GetFontStatusLabel(FontName, FileName, FontDir: String): String;
begin
  if FileExists(FontDir + FileName) then
    Result := FontName + ' [Already Installed]'
  else
    Result := FontName + ' [Not Installed]';
end;

procedure InitializeWizard;
var
  FontDir: String;
begin
  InstallerScriptVersion := '1.0';
  FontPackageVersion := '2.1.5';
  FontDir := ExpandConstant('{autofonts}\');

  { 1. Custom License Page with Two Checkboxes }
  LicensePage := CreateOutputMsgMemoPage(wpWelcome,
    'License Agreements',
    'Please read the following important information before continuing.',
    'Review the licensing terms for both the Liberation Fonts (v. ' + FontPackageVersion + ') and this installer script (v. ' + InstallerScriptVersion + ').',
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
    'Which Liberation Fonts (v. ' + FontPackageVersion + ') do you want to install or update?',
    'Fonts not currently installed on your system have been selected automatically. ' +
    'You can manually select existing fonts to force an update or overwrite.',
    False, False);

  FontPage.Add(GetFontStatusLabel('Liberation Sans Regular', 'LiberationSans-Regular.ttf', FontDir));
  FontPage.Add(GetFontStatusLabel('Liberation Sans Bold', 'LiberationSans-Bold.ttf', FontDir));
  FontPage.Add(GetFontStatusLabel('Liberation Sans Italic', 'LiberationSans-Italic.ttf', FontDir));
  FontPage.Add(GetFontStatusLabel('Liberation Sans Bold Italic', 'LiberationSans-BoldItalic.ttf', FontDir));
  FontPage.Add(GetFontStatusLabel('Liberation Serif Regular', 'LiberationSerif-Regular.ttf', FontDir));
  FontPage.Add(GetFontStatusLabel('Liberation Serif Bold', 'LiberationSerif-Bold.ttf', FontDir));
  FontPage.Add(GetFontStatusLabel('Liberation Serif Italic', 'LiberationSerif-Italic.ttf', FontDir));
  FontPage.Add(GetFontStatusLabel('Liberation Serif Bold Italic', 'LiberationSerif-BoldItalic.ttf', FontDir));
  FontPage.Add(GetFontStatusLabel('Liberation Mono Regular', 'LiberationMono-Regular.ttf', FontDir));
  FontPage.Add(GetFontStatusLabel('Liberation Mono Bold', 'LiberationMono-Bold.ttf', FontDir));
  FontPage.Add(GetFontStatusLabel('Liberation Mono Italic', 'LiberationMono-Italic.ttf', FontDir));
  FontPage.Add(GetFontStatusLabel('Liberation Mono Bold Italic', 'LiberationMono-BoldItalic.ttf', FontDir));

  { Check items by default ONLY if they do not exist }
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

  { Add Select All Checkbox }
  SelectAllCheckbox := TNewCheckBox.Create(FontPage);
  SelectAllCheckbox.Parent := FontPage.Surface;
  SelectAllCheckbox.Caption := 'Select / Deselect All';
  SelectAllCheckbox.Left := FontPage.CheckListBox.Left;
  SelectAllCheckbox.Top := FontPage.SurfaceHeight - SelectAllCheckbox.Height;
  SelectAllCheckbox.Width := FontPage.SurfaceWidth;
  SelectAllCheckbox.OnClick := @SelectAllClick;
  
  FontPage.CheckListBox.Height := FontPage.CheckListBox.Height - SelectAllCheckbox.Height - 8;

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
  CleanFontName: String;
  FontDir: String;
begin
  { Handle Next Button text dynamically based on the current page }
  if CurPageID = ConfirmPage.ID then
    WizardForm.NextButton.Caption := 'Install'
  else if CurPageID = wpFinished then
    WizardForm.NextButton.Caption := SetupMessage(msgButtonFinish)
  else
    WizardForm.NextButton.Caption := SetupMessage(msgButtonNext);

  if CurPageID = LicensePage.ID then
  begin
    WizardForm.NextButton.Enabled := AcceptFontsCheckbox.Checked and AcceptInstallerCheckbox.Checked;
    LicensePage.RichEditViewer.Text := 
      '--- LIBERATION FONTS (v. ' + FontPackageVersion + ') LICENSE ---' + #13#10 +
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
          0: begin FileNameStr := 'LiberationSans-Regular.ttf'; CleanFontName := 'Liberation Sans Regular'; end;
          1: begin FileNameStr := 'LiberationSans-Bold.ttf'; CleanFontName := 'Liberation Sans Bold'; end;
          2: begin FileNameStr := 'LiberationSans-Italic.ttf'; CleanFontName := 'Liberation Sans Italic'; end;
          3: begin FileNameStr := 'LiberationSans-BoldItalic.ttf'; CleanFontName := 'Liberation Sans Bold Italic'; end;
          4: begin FileNameStr := 'LiberationSerif-Regular.ttf'; CleanFontName := 'Liberation Serif Regular'; end;
          5: begin FileNameStr := 'LiberationSerif-Bold.ttf'; CleanFontName := 'Liberation Serif Bold'; end;
          6: begin FileNameStr := 'LiberationSerif-Italic.ttf'; CleanFontName := 'Liberation Serif Italic'; end;
          7: begin FileNameStr := 'LiberationSerif-BoldItalic.ttf'; CleanFontName := 'Liberation Serif Bold Italic'; end;
          8: begin FileNameStr := 'LiberationMono-Regular.ttf'; CleanFontName := 'Liberation Mono Regular'; end;
          9: begin FileNameStr := 'LiberationMono-Bold.ttf'; CleanFontName := 'Liberation Mono Bold'; end;
          10: begin FileNameStr := 'LiberationMono-Italic.ttf'; CleanFontName := 'Liberation Mono Italic'; end;
          11: begin FileNameStr := 'LiberationMono-BoldItalic.ttf'; CleanFontName := 'Liberation Mono Bold Italic'; end;
        end;

        if FileExists(FontDir + FileNameStr) then
          ExistingFiles := ExistingFiles + '  [OVERWRITE] ' + CleanFontName + #13#10
        else
          NewFiles := NewFiles + '  [INSTALL] ' + CleanFontName + #13#10;
      end;
    end;

    Summary := 'SUMMARY OF OPERATIONS (Installing Fonts v. ' + FontPackageVersion + '):' + #13#10#13#10;
    
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