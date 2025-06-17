with HashingArbol;

procedure main is

   subtype indice is integer range 0 .. 10;

   function hash (numero : integer) return indice is
   begin
      return (numero mod 10);
   end;

   package hashArbol is new HashingArbol (integer, indice, ">", "<", hash);

begin

end;
