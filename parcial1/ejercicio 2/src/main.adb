with ada.Text_IO, ada.Integer_Text_IO, lista, pila, vectorSimple;
use ada.Text_IO, ada.Integer_Text_IO;

procedure main is

   MAXVECTOR : integer := 3;
   subtype rangoVec is Integer range 0 .. MAXVECTOR;

   package listaEnteros is new Lista (integer);
   use listaEnteros;
   package pilaListas is new pila (listaEnteros.TipoLista);
   use pilaListas;
   procedure put (a : in pilaListas.TipoPila) is
   begin
      null;
   end put;

   procedure get (a : out pilaListas.TipoPila) is
   begin
      null;
   end get;
   package vectorPilas is new
     vectorSimple (pilaListas.TipoPila, rangoVec, put, get);

   listaAux        : listaEnteros.TipoLista;
   pilaAux         : pilaListas.TipoPila;
   vectorPrincipal : vectorPilas.VecGeneric;

   procedure cargarLista (lista : in out listaEnteros.TipoLista) is
      aux : Integer := 0;
   begin
      for j in 0 .. 5 loop
         Put_Line ("ingrese un numero");
         get (aux);
         listaEnteros.Insertar (lista, aux);

      end loop;
   end cargarLista;

begin
   cargarLista (listaAux);
   pilaListas.Meter (pilaAux, listaAux);
   listaEnteros.Crear (listaAux);
end main;
