program map;
//{$APPTYPE CONSOLE}

uses
  Forms,
  main in 'main.pas' {TForm};

{$R *.res}

begin
  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
  Application.Title := 'Map';
  Application.CreateForm(TTForm, TForm);
  Application.Run;
end.
