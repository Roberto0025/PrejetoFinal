unit UnitLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts, FMX.StdCtrls,
  FMX.TabControl, System.Actions, FMX.ActnList, u99Permissions,
  FMX.MediaLibrary.Actions, FMX.StdActns; //,FMX.VirtualKeyboard, fmx.Platform;

type
  TFrmLogin = class(TForm)
    Layout1: TLayout;
    img_login_user: TImage;
    Layout2: TLayout;
    RoundRect1: TRoundRect;
    edit_email_login: TEdit;
    StyleBook1: TStyleBook;
    Layout3: TLayout;
    RoundRect2: TRoundRect;
    edit_senha_login: TEdit;
    Layout5: TLayout;
    RoundRect4: TRoundRect;
    Label1: TLabel;
    TabControl1: TTabControl;
    TabLogin: TTabItem;
    TabConta: TTabItem;
    Layout6: TLayout;
    Image1: TImage;
    Layout7: TLayout;
    RoundRect3: TRoundRect;
    edit_nome_conta: TEdit;
    Layout8: TLayout;
    RoundRect5: TRoundRect;
    edit_email_conta: TEdit;
    Layout9: TLayout;
    RoundRect7: TRoundRect;
    edit_senha_conta: TEdit;
    Layout10: TLayout;
    RoundRect6: TRoundRect;
    Label2: TLabel;
    TabFoto: TTabItem;
    Layout11: TLayout;
    Layout12: TLayout;
    RoundRect8: TRoundRect;
    Label3: TLabel;
    Layout13: TLayout;
    foto_editar: TCircle;
    TabEscolher: TTabItem;
    Layout14: TLayout;
    Label5: TLabel;
    Layout15: TLayout;
    img_foto: TImage;
    img_library: TImage;
    Layout16: TLayout;
    img_Escolher_voltar: TImage;
    Layout17: TLayout;
    img_foto_voltar: TImage;
    Layout18: TLayout;
    img_conta_voltar: TImage;
    Layout19: TLayout;
    Layout20: TLayout;
    lbl_login_tab: TLabel;
    lbl_login_conta: TLabel;
    Rectangle1: TRectangle;
    Layout21: TLayout;
    Layout22: TLayout;
    Label4: TLabel;
    Label6: TLabel;
    Rectangle4: TRectangle;
    ActionList1: TActionList;
    Action1: TAction;
    ActionConta: TChangeTabAction;
    ActionEscolher: TChangeTabAction;
    ActionFoto: TChangeTabAction;
    ActionLogin: TChangeTabAction;
    Layout4: TLayout;
    ActionLibrary: TTakePhotoFromLibraryAction;
    ActionCamera: TTakePhotoFromCameraAction;
    procedure lbl_login_contaClick(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure RoundRect6Click(Sender: TObject);
    procedure img_conta_voltarClick(Sender: TObject);
    procedure img_foto_voltarClick(Sender: TObject);
    procedure img_Escolher_voltarClick(Sender: TObject);
    procedure foto_editarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure img_fotoClick(Sender: TObject);
    procedure img_libraryClick(Sender: TObject);
    procedure ActionLibraryDidFinishTaking(Image: TBitmap);
    procedure ActionCameraDidFinishTaking(Image: TBitmap);
  private
    { Private declarations }
    permissao: T99Permissions;
    procedure TrataErroPermissao(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.fmx}

// captura a foto, carrega e volta a tela anterior
procedure TFrmLogin.ActionCameraDidFinishTaking(Image: TBitmap);
begin
  foto_editar.Fill.Bitmap.Bitmap := Image;
  ActionFoto.Execute;
end;

// pega a foto da galeria, carrega a foto e volta a tela anterior
procedure TFrmLogin.ActionLibraryDidFinishTaking(Image: TBitmap);
begin
  foto_editar.Fill.Bitmap.Bitmap := Image;
  ActionFoto.Execute;
end;

// inicia a variavel de "permissão" que foi criada
procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  permissao := T99Permissions.Create;
end;

procedure TFrmLogin.FormDestroy(Sender: TObject);
begin
  permissao.DisposeOf;
end;


procedure TFrmLogin.foto_editarClick(Sender: TObject);
begin ActionEscolher.Execute; end;

procedure TFrmLogin.img_conta_voltarClick(Sender: TObject);
begin ActionLogin.Execute; end;

procedure TFrmLogin.img_Escolher_voltarClick(Sender: TObject);
begin ActionFoto.Execute; end;

// procedure para tratar erro "perssao" a camera
procedure TFrmLogin.TrataErroPermissao(Sender: TObject);
begin ShowMessage('Você não tem permissão para acessar este recurso.'); end;

// executa 'permissao" para acessar camera
procedure TFrmLogin.img_fotoClick(Sender: TObject);
begin permissao.Camera(ActionCamera, TrataErroPermissao); end;

procedure TFrmLogin.img_foto_voltarClick(Sender: TObject);
begin ActionConta.Execute; end;

procedure TFrmLogin.img_libraryClick(Sender: TObject);
begin permissao.PhotoLibrary(ActionLibrary, TrataErroPermissao) end;

procedure TFrmLogin.Label4Click(Sender: TObject);
begin ActionLogin.Execute; end;

procedure TFrmLogin.lbl_login_contaClick(Sender: TObject);
begin ActionConta.Execute; end;

procedure TFrmLogin.RoundRect6Click(Sender: TObject);
begin ActionFoto.Execute; end;

// gira a foto
// foto.Bitmap.Rotate(90);

end.
