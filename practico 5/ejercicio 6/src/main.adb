with Ada.Text_IO, Ada.Integer_Text_IO, ABB;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure main is
   procedure put (X : in Integer) is
   begin
      Ada.Integer_Text_IO.Put (X);
   end put;

   package arbolEnteros is new ABB (Integer, "<", ">", "=", put);
   use arbolEnteros;

   arbol    : arbolEnteros.Tipoarbol;
   arbolAux : arbolEnteros.Tipoarbol;

   procedure llenarArbol (arbol : out arbolEnteros.Tipoarbol) is
   begin
      arbolEnteros.Insertar (arbol, 15);
      arbolEnteros.Insertar (arbol, 18);
      arbolEnteros.Insertar (arbol, 17);
      arbolEnteros.Insertar (arbol, 13);
      arbolEnteros.Insertar (arbol, 4);
      arbolEnteros.Insertar (arbol, 52);
      arbolEnteros.Insertar (arbol, 3);
   end llenarArbol;

   function buscarMinimo (arbol : in arbolEnteros.Tipoarbol) return Integer is
      minimo : Integer;
   begin
      arbolAux := arbol;
      while not arbolEnteros.Vacio (arbolAux) loop
         minimo := arbolEnteros.Info (arbolAux);
         arbolAux := arbolEnteros.Izq (arbolAux);
      end loop;
      return minimo;
   end buscarMinimo;

   function buscarMaximo (arbol : in arbolEnteros.Tipoarbol) return Integer is
      maximo : Integer;
   begin
      arbolAux := arbol;
      while not arbolEnteros.Vacio (arbolAux) loop
         maximo := arbolEnteros.Info (arbolAux);
         arbolAux := arbolEnteros.Der (arbolAux);
      end loop;
      return maximo;
   end buscarMaximo;
   minimo : Integer;
begin

   llenarArbol (arbol);
   arbolEnteros.Inorden (arbol);
   minimo := buscarMinimo (arbol);
   New_Line;
   Ada.Integer_Text_IO.Put (buscarMinimo (arbol) + buscarMaximo (arbol));
   New_Line;

end main;
