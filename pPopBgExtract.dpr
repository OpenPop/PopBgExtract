program pPopBgExtract;

uses
  Forms,
  uPopBgExtract in 'uPopBgExtract.pas' {PopBgExtract};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Populous Background Extractor';
  Application.CreateForm(TPopBgExtract, PopBgExtract);
  Application.Run;
end.
