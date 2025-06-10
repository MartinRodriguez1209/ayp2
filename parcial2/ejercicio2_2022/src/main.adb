with ada.Text_IO; use ada.Text_IO;
with Ada.Wide_Text_IO;
with HashingLista;

procedure main is

   subtype rango is integer range 0 .. 9;

   function hash (numero : integer) return rango is
   begin
      return rango (numero mod 10);
   end hash;

   package hashlista is new HashingLista (integer, rango, "<", ">", hash);

   unHash : hashlista.Tipovec;

   procedure insertar is
   begin

      hashlista.Insertar (unHash, 4371);
      hashlista.Insertar (unHash, 1323);
      hashlista.Insertar (unHash, 6173);
      hashlista.Insertar (unHash, 4199);
      hashlista.Insertar (unHash, 4344);
      hashlista.Insertar (unHash, 9679);
      hashlista.Insertar (unHash, 1989);
   end insertar;

begin
   insertar;
   if hashlista.Buscar (unHash, 6173) then
      Put_Line ("exito");
   end if;
end main;
