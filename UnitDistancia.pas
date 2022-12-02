unit UnitDistancia;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Edit,
  FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts, REST.Types,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.JSON;

type
  TFrmDistancia = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    lbl_titulo: TLabel;
    Image1: TImage;
    Layout2: TLayout;
    Layout3: TLayout;
    lbl_origem: TLabel;
    edit_origem: TEdit;
    Layout4: TLayout;
    lbl_destino: TLabel;
    edit_destino: TEdit;
    lbl_distancia: TLabel;
    lbl_tempo: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    btn_calcular: TButton;
    procedure btn_calcularClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDistancia: TFrmDistancia;

implementation

{$R *.fmx}


procedure TFrmDistancia.btn_calcularClick(Sender: TObject);
var
  retorno: TJSONObject;
  prows: TJSONPair;
  arrayr: TJSONArray;
  orows: TJSONObject;
  arraye: TJSONArray;
  oelementos: TJSONObject;
  oduracao, odistancia: TJSONObject;

  distancia_str, duracao_str: string;
  distancia_int, duracao_int: integer;
begin
  RESTRequest1.Resource := '';
  RESTRequest1.Params.AddUrlSegment('origem', edit_origem.Text);
  RESTRequest1.Params.AddUrlSegment('destino', edit_destino.Text);
  RESTRequest1.Execute;

  retorno := RESTRequest1.Response.JSONValue as TJSONObject;

  if retorno.GetValue('status').Value <> 'OK' then
  begin
    ShowMessage('Ocorreu um erro ao calcular a viagem.');
    Exit;
  end;

  prows := retorno.Get('rows');
  arrayr := prows.JsonValue as TJSONArray;
  orows := arrayr.Items[0] as TJSONObject;
  arraye := orows.GetValue('elements') as TJSONArray;
  oelementos := arraye.Items[0] as TJSONObject;

  odistancia := oelementos.GetValue('distance') as TJSONObject;
  oduracao := oelementos.GetValue('duration') as TJSONObject;

  distancia_str := odistancia.GetValue('text').Value;
  distancia_int := odistancia.GetValue('value').Value.ToInteger;

  duracao_str := oduracao.GetValue('text').Value;
  duracao_int := oduracao.GetValue('value').Value.ToInteger;

  lbl_distancia.Text := 'Distância: ' + distancia_str;
  lbl_tempo.Text := 'Tempo: ' + duracao_str;
end;

end.
