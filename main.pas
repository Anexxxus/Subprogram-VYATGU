unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList;

type
  CompInfo=record
    index,top,left,width,height,fontsize:integer;
  end;
  complist=array of CompInfo;

  { TfMain }

  TfMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    DefWidth,defHeight:integer;
    clist:complist;
    procedure MyPrivat;
    procedure MyDouble;
  public

  end;

var
  fMain: TfMain;
  MyNum: real;

implementation
uses math;

{$R *.lfm}

{ TfMain }

procedure TfMain.Label1Click(Sender: TObject);
begin

end;

procedure TfMain.FormResize(Sender: TObject);
var i:integer;
begin
  if width >1000 then width:=800;
  if width<150   then width:=250;
  if height>800 then height:=800;
  if height<150 then height:=250;
  For i:=0 to length(clist)-1 do begin
    (components[clist[i].index] as tcontrol).Top:=round(clist[i].top*height/defheight);
    (components[clist[i].index] as tcontrol).height:=round(clist[i].height*height/defheight);
    (components[clist[i].index] as tcontrol).left:=round(clist[i].left*width/defwidth);
    (components[clist[i].index] as tcontrol).width:=round(clist[i].width*width/defwidth);
    (components[clist[i].index] as tcontrol).font.Size:=round(clist[i].fontsize*min(width/defwidth,height/defheight));
  end;
end;

procedure TfMain.MyPrivat;
var
  r: real;
begin
  //преобразуем в число то, что ввел пользователь:
    r:= StrToFloat(Edit1.Text);
    //теперь удвоим его:
    r:= r * 2;
    //теперь выведем результат в сообщении:
    ShowMessage(FloatToStr(r));
end;

procedure TfMain.MyDouble;
begin
  //удвоим глобальную переменную:
  MyNum:= MyNum * 2;
end;

procedure Udvoenie(st: string);
var
  r: real;
begin
  r:= StrToFloat(st);
  r:= r * 2;
  ShowMessage(FloatToStr(r));
end;

procedure TfMain.Button1Click(Sender: TObject);
begin
  Udvoenie(Edit1.Text);
end;

function FuncUdvoenie(st: string): string;
var
  r: real;
begin
   //полученную строку сначала преобразуем в число:
   r:= StrToFloat(st);
   //теперь удвоим его:
   r:= r * 2;
   //теперь вернем результат в виде строки:
   Result:= FloatToStr(r);
end;

procedure TfMain.Button2Click(Sender: TObject);
begin
  ShowMessage(FuncUdvoenie(Edit1.Text));
end;

procedure UdvoeniePoSsilke(var r: real);
begin
  r:= r * 2;
end;

procedure TfMain.Button3Click(Sender: TObject);
var
   myReal: real;
begin
    myReal:= StrToFloat(Edit1.Text);
    UdvoeniePoSsilke(myReal);
    ShowMessage(FloatToStr(myReal));
end;

procedure TfMain.Button4Click(Sender: TObject);
begin
  MyPrivat;
end;

procedure TfMain.Button5Click(Sender: TObject);
begin
  MyNum:= StrToFloat(Edit1.Text);
  //теперь удвоим его:
  MyDouble;
  //выводим результат на экран:
  ShowMessage(FloatToStr(MyNum));
end;

procedure TfMain.Edit1KeyPress(Sender: TObject; var Key: char);
begin
// проверяем нажатую клавишу
case Key of
// цифры разрешаем
'0'..'9': key:=key;
// разрешаем десятичный разделитель (только точку)
'.', ',': key:=','; // если ставить точку, то выдает ошибку > ставим запятую
// разрешаем BackSpace
#8: key:=key;
// все прочие клавиши "гасим"
else key:=#0;
end;
end;

procedure TfMain.FormCreate(Sender: TObject);
var i:integer;
begin
  defwidth:=width;
  defheight:=height;
  for i:= 0 to ComponentCount-1 do
    if (Components[i].Classname = 'TRadioButton')
    or (Components[i].Classname ='TCheckBox')
    or (Components[i].Classname ='TButton')
    or (Components[i].Classname ='TBitBtn')
    or (Components[i].Classname ='TSpeedButton')
    or (Components[i].Classname ='TEdit')
    or (Components[i].Classname ='TRadioGroup')
    or (Components[i].Classname ='TCheckGroup')
    or (Components[i].Classname ='TListBox')
    or (Components[i].Classname ='TComboBox')
    or (Components[i].Classname ='TEdit')
    or (Components[i].Classname ='TSpinEdit')
    or (Components[i].Classname ='TLabel') then begin
      setlength(clist,Length(clist)+1);
      clist[Length(clist)-1].top:=(Components[i] as tcontrol).top;
      clist[Length(clist)-1].left:=(Components[i]as tcontrol).left;
      clist[Length(clist)-1].width:=(Components[i] as tcontrol).width;
      clist[Length(clist)-1].height:=(Components[i]as tcontrol).height;
      clist[Length(clist)-1].fontsize:=(Components[i]as tcontrol).font.Size;
      clist[Length(clist)-1].index:=i;
    end;
end;

end.

