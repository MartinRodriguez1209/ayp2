with Ada.Strings.Unbounded.Text_IO;
with Ada.Wide_Text_IO;
with Ada.Integer_Text_IO, Ada.Text_IO, Ada.Float_Text_IO, Cola;
use Ada.Integer_Text_IO, Ada.Text_IO;

procedure usacola is
   Msg : constant String := "Hello Woooooorld!";
   package ColaEnteros is new Cola (Integer);
   use ColaEnteros;
   package ColaReales is new Cola (Float);
   use ColaReales;
   max      : Integer := 21;  -- hace que la cola sea de 20
   UnaColaE : ColaEnteros.TipoCola (max);
   elemento : Integer;

begin

   for J in 1 .. 20 loop   --lleno la cola con numeros del 1 al 20
      ColaEnteros.Insertar (UnaColaE, J);
      Put (J);
      New_Line;
   end loop;

   for J in 1 .. max - 1 loop  --elimino los numeros impares
      ColaEnteros.Suprimir (UnaColaE, elemento);
      if elemento mod 2 = 0 then
         ColaEnteros.Insertar (UnaColaE, elemento);
      end if;
   end loop;

   for J in 1 .. max loop --imprimo la cola
      ColaEnteros.Suprimir (UnaColaE, elemento);
      Put (elemento);
      if Vacia (UnaColaE) then --para no excederme de la cola
         exit;
      end if;
   end loop;
end usacola;
