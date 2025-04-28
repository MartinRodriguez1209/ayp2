with Ada.Wide_Text_IO;
with lista, Ada.Text_IO, Ada.Integer_Text_IO;
use ada.Wide_Text_IO;

procedure main is
   package ListaInt is new Lista (Integer);
   use ListaInt;
   unaLista : TipoLista;
   auxiliar : Boolean;

begin
   ListaInt.crear (unaLista);
   ListaInt.Insertar (unaLista, 7);
   ListaInt.Insertar (unaLista, 2);
   ListaInt.Insertar (unaLista, 4);
   ListaInt.Insertar (unaLista, 8);
   auxiliar := ListaInt.Esta (unaLista, 2);
   if auxiliar then
      Put_Line ("el numero si esta!");
   end if;

end main;
