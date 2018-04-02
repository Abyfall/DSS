##!include "MUI2.nsh"

!define DSS_ICON           "..\DeepSkyStacker\Icon\DSS.ico"

!define DSS_HELP_FR        "Aide DeepSkyStacker.chm"
!define DSS_HELP_ES        "Ayuda DeepSkyStacker.chm"
!define DSS_HELP_EN        "DeepSkyStacker Help.chm"
!define DSS_HELP_DE        "DeepSkyStacker Hilfe.chm"
!define DSS_HELP_PT        "DeepSkyStacker Ajuda.chm"

!define DSS_RUNTIME_MFC    "mfc140.dll"
!define DSS_RUNTIME_CPP    "msvcp140.dll"
!define DSS_RUNTIME_C      "vcruntime140.dll"


!define DSS_PRODUCT        "DeepSkyStacker"                         # For start menu

!define DSS_NAME           "DeepSkyStacker (32 bit)"
!define DSS_FILE           "DeepSkyStacker"

!define DSSCL_NAME         "DeepSkyStacker Command Line (32 bit)"
!define DSSCL_FILE         "DeepSkyStackerCL"

!define DSSLIVE_NAME       "DeepSkyStacker Live (32 bit)"
!define DSSLIVE_FILE       "DeepSkyStackerLive"


!define DSS_UNINSTALL_NAME "DeepSkyStacker Uninstaller (32 bit)"
!define DSS_UNINSTALL_FILE "DeepSkyStackerUninstaller"

CRCCheck On


# define installer name

OutFile "DeepSkyStackerInstaller.exe"
 
# set the install directory - the programs are 32 bit versions

InstallDir "$PROGRAMFILES32\${DSS_PRODUCT}"

# ** (Do we need this?) **

RequestExecutionLevel admin

# Enable/disable UI features we do/dont want

ShowInstDetails       nevershow
ShowUninstDetails     nevershow

Name                  "${DSS_NAME}"
Icon                  "${DSS_ICON}"
UninstallIcon         "${DSS_ICON}"


# default installer section start

Section

  # Modify UI behaviours
  
  ##SetDetailsPrint     none

  # define output path

  SetOutPath $INSTDIR
 
  # Uninstall the previous (4.x.x) version (including blind uninstall attempts of legacy 3.3.2 based versions)
  
  ExecWait '"$INSTDIR\${DSS_UNINSTALL_FILE}.exe" _?=$INSTDIR'
  ExecWait '"MsiExec.exe /x{18435829-4E75-4CD1-9796-A62DBBAE2ED7} /quiet" _?=$INSTDIR' # en, es
  ExecWait '"MsiExec.exe /x{DCEC4A35-DA2B-4CA6-89A3-206F9A568ACD} /quiet" _?=$INSTDIR' # fr
  ExecWait '"MsiExec.exe /x{350E3960-DE20-4FE6-9E6B-26B464AD27FD} /quiet" _?=$INSTDIR' # de
  ExecWait '"MsiExec.exe /x{497EAFB5-BF53-41E0-A397-33289E5B679D} /quiet" _?=$INSTDIR' # pt

  # specify the files that go in the output path

  File "..\x86\Release\${DSS_FILE}.exe"
  File "..\x86\Release\${DSSCL_FILE}.exe"
  File "..\x86\Release\${DSSLIVE_FILE}.exe"
  File "..\Help\${DSS_HELP_FR}"
  File "..\Help\${DSS_HELP_ES}"
  File "..\Help\${DSS_HELP_EN}"
  File "..\Help\${DSS_HELP_DE}"
  File "..\Help\${DSS_HELP_PT}"
  File "RunTime32\${DSS_RUNTIME_MFC}"
  File "RunTime32\${DSS_RUNTIME_CPP}"
  File "RunTime32\${DSS_RUNTIME_C}"
 
  # define uninstaller name

  WriteUninstaller "$INSTDIR\${DSS_UNINSTALL_FILE}.exe"
  

  # create desktop shortcut for the apps with UIs

  CreateShortCut "$DESKTOP\${DSS_NAME}.lnk"     "$INSTDIR\${DSS_FILE}.exe" ""
  CreateShortCut "$DESKTOP\${DSSLIVE_NAME}.lnk" "$INSTDIR\${DSSLIVE_FILE}.exe" ""
 
  # create start-menu items 


  CreateDirectory "$SMPROGRAMS\${DSS_PRODUCT}"
  CreateShortCut  "$SMPROGRAMS\${DSS_PRODUCT}\${DSS_NAME}.lnk"     "$INSTDIR\${DSS_FILE}.exe"     "" "$INSTDIR\${DSS_FILE}.exe" 0 
  CreateShortCut  "$SMPROGRAMS\${DSS_PRODUCT}\${DSSLIVE_NAME}.lnk" "$INSTDIR\${DSSLIVE_FILE}.exe" "" "$INSTDIR\${DSSLIVE_FILE}.exe" 0 

  CreateShortCut  "$SMPROGRAMS\${DSS_PRODUCT}\${DSS_UNINSTALL_NAME}.lnk" "$INSTDIR\${DSS_UNINSTALL_FILE}.exe" "" "$INSTDIR\${DSS_UNINSTALL_FILE}.exe" 0

  # write uninstall information to the registry
 
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${DSS_PRODUCT}32" "DisplayName" "${DSS_PRODUCT}32 (remove only)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${DSS_PRODUCT}32" "UninstallString" "$INSTDIR\${DSS_UNINSTALL_FILE}.exe"

  # Create the uninstaller program
  
  WriteUninstaller "$INSTDIR\${DSS_UNINSTALL_FILE}.exe"

  # default section end

SectionEnd


 
# create a section to define what the uninstaller does.
# the section will always be named "Uninstall"

Section "Uninstall"
 
  # Modify UI behaviours
  
  ##SetDetailsPrint     none


  # Always delete uninstaller first

  Delete "$INSTDIR\${DSS_UNINSTALL_FILE}.exe" 

  # now delete installed files

  Delete "$INSTDIR\${DSS_FILE}.exe"
  Delete "$INSTDIR\${DSSCL_FILE}.exe"
  Delete "$INSTDIR\${DSSLIVE_FILE}.exe"
  Delete "$INSTDIR\${DSS_HELP_FR}"
  Delete "$INSTDIR\${DSS_HELP_ES}"
  Delete "$INSTDIR\${DSS_HELP_EN}"
  Delete "$INSTDIR\${DSS_HELP_DE}"
  Delete "$INSTDIR\${DSS_HELP_PT}"
  Delete "$INSTDIR\${DSS_RUNTIME_MFC}"
  Delete "$INSTDIR\${DSS_RUNTIME_CPP}"
  Delete "$INSTDIR\${DSS_RUNTIME_C}"

  RmDir  "$INSTDIR"
 
  # Delete Start Menu Shortcuts and Desktop shortcuts
   
  Delete "$DESKTOP\${DSS_NAME}.lnk"
  Delete "$DESKTOP\${DSSLIVE_NAME}.lnk"

  Delete "$SMPROGRAMS\${DSS_PRODUCT}\${DSS_NAME}.lnk"
  Delete "$SMPROGRAMS\${DSS_PRODUCT}\${DSSLIVE_NAME}.lnk"
  Delete "$SMPROGRAMS\${DSS_PRODUCT}\${DSS_UNINSTALL_NAME}.lnk"
  RmDir  "$SMPROGRAMS\${DSS_PRODUCT}"
  
  # Delete Product And Uninstall Registry Entries
  
  DeleteRegKey HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\${DSS_PRODUCT}32" 
  

SectionEnd
