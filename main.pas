{
MAP - Multiple APplications
}
unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, inifiles, Buttons;

type
  TTForm = class(TForm)
    btnRun: TBitBtn;
    cbVersionSelect: TComboBox;
    lbcbbox: TLabel;
    cbOnTop: TCheckBox;
    function OpenIniFileInstance(AppName: string): TCustomIniFile;
    function CreateIniFile(AppName:string): Integer;
    procedure FormCreate(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure cbVersionSelectChange(Sender: TObject);
    procedure cbOnTopClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function RunProcess(FileName: string; ShowCmd: DWORD; wait: Boolean; ProcID:  PDWORD): Longword;
  public
    { Public declarations }

  end;

const
  APP :  string = 'MAP';
  CONFIG : string = 'CONFIG';
  PROGRAMPATHS  : string = 'PROGRAMPATHS';

var
  TForm: TTForm;
  AppName : string;



implementation

{$R *.dfm}

function TTForm.OpenIniFileInstance(AppName:string): TCustomIniFile;
begin
  Result := TIniFile.Create(AppName);
end;

function TTForm.CreateIniFile(AppName:string): Integer;
begin
  Result := FileCreate(AppName);
end;

procedure TTForm.btnRunClick(Sender: TObject);
var
  SettingsFile : TCustomIniFile;
  processrun : string;
  ProcID: Cardinal;
begin
  ProcID := 0;
  SettingsFile := OpenIniFileInstance(AppName);

  try
    processrun := SettingsFile.ReadString(PROGRAMPATHS, cbVersionSelect.Items[cbVersionSelect.ItemIndex], '');
    RunProcess(processrun, SW_SHOW, false, @ProcID) ;
  finally
    SettingsFile.Free;
  end;
end;

procedure TTForm.cbVersionSelectChange(Sender: TObject);
begin
     btnRun.Enabled := true;
end;


function TTForm.RunProcess(FileName: string; ShowCmd: DWORD; wait: Boolean; ProcID:  PDWORD): Longword;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
  StartupInfo.wShowWindow := ShowCmd;
  if not CreateProcess(nil,
    @Filename[1],
    nil,
    nil,
    False,
    CREATE_NEW_CONSOLE or
    NORMAL_PRIORITY_CLASS,
    nil,
    nil,
    StartupInfo,
    ProcessInfo)
    then
    begin
     Result := WAIT_FAILED ;
     MessageDlg('Unable to Run application.'+ #13#10 +'Please check .ini file is configured correctly.',
                mtWarning ,[mbOK], 0);
    end
  else
  begin
    if wait = FALSE then
    begin
      if ProcID <> nil then
        ProcID^ := ProcessInfo.dwProcessId;
      result := WAIT_FAILED;
      exit;
    end;
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
  end;
  if ProcessInfo.hProcess <> 0 then
    CloseHandle(ProcessInfo.hProcess);
  if ProcessInfo.hThread <> 0 then
    CloseHandle(ProcessInfo.hThread);
end;


procedure TTForm.FormCreate(Sender: TObject);
var
  sval : TStringList;
  FileHandle: Integer;
  F1 : TextFile;
  OnTop : string;
  SettingsFile : TCustomIniFile;

begin
  AppName :=  ChangeFileExt(Application.ExeName, '.ini');
                                               // check and create a .ini file if does not exist
    if  not FileExists(AppName) then
    begin
        FileHandle := CreateIniFile(AppName);  // create .ini file with default sections
        if FileHandle > 0 then
        try
            CloseHandle(FileHandle);
            AssignFile(F1, AppName);
            ReWrite(F1);
            writeln(F1, '[', APP, ']');
            writeln(F1, '[',CONFIG,']');
            writeln(F1, '[',PROGRAMPATHS,']');
         finally
            CloseFile(F1);
         end;
    end;

  SettingsFile := OpenIniFileInstance(AppName);
  sval := TStringList.Create;                      // create here or Exception
  try
    OnTop := SettingsFile.ReadString(CONFIG, 'OnTop' , 'true');

    if StrToBool(OnTop) = true then
    begin
       TForm.FormStyle :=  fsStayOnTop;
       cbOnTop.Checked := true;
    end
       else
       begin
       TForm.FormStyle :=  fsNormal;
       cbOnTop.Checked := false;
       end ;

    SettingsFile.ReadSection(PROGRAMPATHS, sval);
    cbVersionSelect.Items := sval;
    if cbVersionSelect.ItemIndex = -1 then
    begin
        btnRun.Enabled := false;
    end;
  finally
    SettingsFile.Free;
  end;

end;

procedure TTForm.cbOnTopClick(Sender: TObject);
var
  SettingsFile : TCustomIniFile;
begin
SettingsFile := OpenIniFileInstance(AppName);

     if cbOnTop.Checked = true then
     begin
          SettingsFile.WriteString(CONFIG,'OnTop', 'true');
          TForm.FormStyle :=  fsStayOnTop
      end
      else
      begin
          SettingsFile.WriteString(CONFIG, 'OnTop', 'false');
          TForm.FormStyle :=  fsNormal;
      end;
        SettingsFile.Free;
end;

procedure TTForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if key = #27 then
       Close;
end;

end.

