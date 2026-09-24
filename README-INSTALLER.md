Liberation Fonts Installer

Installer Version: 1.0

Target Fonts Version: 2.1.5

About

This repository contains a custom Windows installer script (written in Inno Setup) designed to easily deploy the Liberation font family to a Windows system. It automatically detects missing fonts, sets them to be installed by default, and provides a clear summary of which files will be overwritten or added.

Disclaimer

Please note: I am not affiliated, associated, authorized, endorsed by, or in any way officially connected with the Liberation fonts project or its developers. I am simply a huge user and a big fan of their work, and I created this installer to make deploying these fonts easier for everyone.

The Liberation Fonts are licensed under the SIL Open Font License 1.1. The official source code and repository for the fonts can be found on their GitHub page.

Project Structure

Before compiling, ensure your project directory looks like this:

/YourProjectFolder
  ├── liberation-fonts-setup.iss          (The Inno Setup script)
  └── /fonts              (Folder containing the .ttf files)
      ├── LiberationSans-Regular.ttf
      ├── LiberationSans-Bold.ttf
      └── ... (other font files)


How to Compile

To generate the final executable installer (.exe), you need to have Inno Setup installed on your machine.

You can open the .iss file in the Inno Setup IDE and click "Compile", or you can compile it directly from the command line using the Inno Setup Command Line Compiler (iscc).

Run the following command in your terminal:

iscc "liberation-fonts-setup.iss"


(Note: If iscc is not recognized, you may need to add it to your system's PATH or use the full path to the executable, typically "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" "liberation-fonts-setup.iss").