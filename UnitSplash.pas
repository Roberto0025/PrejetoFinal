unit UnitSplash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON;

type
  TFrmSplash = class(TForm)
    LayoutAtualilizacao: TLayout;
    LayoutAtualizar: TLayout;
    Layout2: TLayout;
    lbl_nova_versao: TLabel;
    Label2: TLabel;
    ImageFlecha: TImage;
    Rectangle1: TRectangle;
    lbl_atualizar: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbl_atualizarClick(Sender: TObject);
  private
    procedure OnFinishUpdate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    versao_app : string;
    versao_server : string;
  end;

var
  FrmSplash: TFrmSplash;

implementation

{$R *.fmx}

uses UnitLogin, UOpenURL;


procedure TFrmSplash.FormCreate(Sender: TObject);
begin
  versao_app := '1.0';
  versao_server := '0.0';
end;

procedure TFrmSplash.OnFinishUpdate(Sender: TObject);
begin
  if Assigned(TThread(Sender).FatalException) then
  begin
    ShowMessage(Exception(TThread(Sender).FatalException).Message);
    Exit;
  end;

  if versao_app < versao_server then
  begin
    // Exibe o painel de update
    LayoutAtualilizacao.Visible := true;
    ImageFlecha.Position.Y := 0;
    ImageFlecha.Position.X := 0.5;
    ImageFlecha.Opacity := 0;
    lbl_nova_versao.Opacity := 0;

    LayoutAtualilizacao.BringToFront;
    LayoutAtualilizacao.AnimateFloat('Margin.Top', 0, 0.8, TAnimationType.InOut,
     TInterpolationType.Circular);

    ImageFlecha.AnimateFloatDelay('Position.Y', 50, 0.5, 1, TAnimationType.Out,
     TInterpolationType.Back);
    ImageFlecha.AnimateFloatDelay('Opacity', 1, 0.4, 0.9);

    lbl_nova_versao.AnimateFloatDelay('Opaciy', 1, 0.7, 1.3);

  end;

end;

procedure TFrmSplash.FormShow(Sender: TObject);
var
  t: TThread;
begin
  t := TThread.CreateAnonymousThread(
    procedure
    var
      JsonObj: TJSONObject;
    begin
      sleep(2000);
      try
        RESTRequest1.Execute;
      except
        on ex: Exception do
        begin
          raise Exception.Create('Erro ao acessar o servidor' + ex.Message);
          Exit;
        end;
      end;
      try
        JsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(
          RESTRequest1.Response.JSONValue.ToString), 0) as TJSONObject;

          versao_server := TJSONObject(JsonObj).GetValue('versao').Value;
      finally
        JsonObj.DisposeOf;
      end;
    end);

    t.OnTerminate := OnFinishUpdate;
    t.Start;
end;

procedure TFrmSplash.lbl_atualizarClick(Sender: TObject);
var
  url: string;
begin
  {$IFDEF ANDROID}
  url := '';
  {$ELSE}
  url:= '';
  {$ENDIF}
  OpenURL(url, false);
  Application.Terminate;
end;

end.
