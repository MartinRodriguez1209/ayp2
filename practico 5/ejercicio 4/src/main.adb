with abb, cola, ada.Text_IO;
use ada.Text_IO;

procedure main is
   arbolVacio : exception;
   procedure put (x : in Integer) is
   begin
      null;
   end put;

   package arbolInt is new abb (integer, "<", ">", "=", put);
   package colaArbol is new cola (arbolInt.Tipoarbol);

   arbolPrincipal : arbolInt.Tipoarbol;
   colaAux        : colaArbol.TipoCola;

   procedure llenarArbol (arbol : in out arbolInt.Tipoarbol) is
   begin
      arbolInt.Insertar (arbol, 20);
      arbolInt.Insertar (arbol, 4);
      arbolInt.Insertar (arbol, 3);
      arbolInt.Insertar (arbol, 9);
      arbolInt.Insertar (arbol, 15);
      arbolInt.Insertar (arbol, 2);
      arbolInt.Insertar (arbol, 21);
      arbolInt.Insertar (arbol, 7);
      arbolInt.Insertar (arbol, 13);
      arbolInt.Insertar (arbol, 42);
      arbolInt.Insertar (arbol, 50);
      arbolInt.Insertar (arbol, 1);
   end;

   procedure imprimirArbol (arbol : in arbolInt.Tipoarbol) is
      arbolAux       : arbolInt.Tipoarbol;
      intAux         : integer;
      nivelActual    : integer;
      nivelSiguiente : integer := 0;
   begin
      colaArbol.Inscola (colaAux, arbol);
      nivelActual := 1;
      while not colaArbol.Vacia (colaAux) loop
         colaArbol.Supcola (colaAux, arbolAux);
         if not arbolInt.Vacio (arbolAux) then
            intAux := arbolInt.Info (arbolAux);
            if not arbolInt.Vacio (arbolInt.Izq (arbolAux)) then
               colaArbol.Inscola (colaAux, arbolInt.Izq (arbolAux));
               nivelSiguiente := nivelSiguiente + 1;
            end if;
            if not arbolInt.Vacio (arbolInt.Der (arbolAux)) then
               colaArbol.Inscola (colaAux, arbolInt.Der (arbolAux));
               nivelSiguiente := nivelSiguiente + 1;
            end if;

            Put (integer'Image (intAux));
            nivelActual := nivelActual - 1;
            if nivelActual = 0 then
               New_Line;
               nivelActual := nivelSiguiente;
               nivelSiguiente := 0;
            end if;
         end if;
      end loop;
   end;
begin

   llenarArbol (arbolPrincipal);
   imprimirArbol (arbolPrincipal);
end main;
