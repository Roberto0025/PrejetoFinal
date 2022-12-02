program ProjectFinal;

uses
  System.StartUpCopy,
  FMX.Forms,
  UnitLogin in 'UnitLogin.pas' {FrmLogin},
  u99Permissions in 'Units\u99Permissions.pas',
  UnitSplash in 'UnitSplash.pas' {FrmSplash},
  UOpenURL in 'UOpenURL.pas',
  UnitGPS in 'UnitGPS.pas' {FrmGPS},
  UnitDistancia in 'UnitDistancia.pas' {FrmDistancia};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmGPS, FrmGPS);
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmDistancia, FrmDistancia);
  Application.Run;
end.
