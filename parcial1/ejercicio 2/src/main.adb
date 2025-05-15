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
   listaFinal      : listaEnteros.TipoLista;

   procedure cargarLista (lista : in out listaEnteros.TipoLista) is
      aux : Integer := 0;
   begin

      listaEnteros.Crear (lista);
      listaEnteros.Insertar (lista, 5);
      listaEnteros.Insertar (lista, 2);
      listaEnteros.Insertar (lista, 1);
      listaEnteros.Insertar (lista, 6);
      pilaListas.Crear (pilaAux);
      pilaListas.Meter (pilaAux, lista);
      vectorPrincipal (0) := pilaAux;
      listaEnteros.Crear (lista);
      listaEnteros.Insertar (lista, 7);
      listaEnteros.Insertar (lista, 10);
      listaEnteros.Insertar (lista, 18);
      listaEnteros.Insertar (lista, 65);
      pilaListas.Crear (pilaAux);
      pilaListas.Meter (pilaAux, lista);
      vectorPrincipal (1) := pilaAux;
      listaEnteros.Crear (lista);
      listaEnteros.Insertar (lista, 54);
      listaEnteros.Insertar (lista, 23);
      listaEnteros.Insertar (lista, 15);
      listaEnteros.Insertar (lista, 64);
      pilaListas.Crear (pilaAux);
      pilaListas.Meter (pilaAux, lista);
      vectorPrincipal (2) := pilaAux;
      listaEnteros.Crear (lista);
      listaEnteros.Insertar (lista, 555);
      listaEnteros.Insertar (lista, 25);
      listaEnteros.Insertar (lista, 13);
      listaEnteros.Insertar (lista, 64);
      pilaListas.Crear (pilaAux);
      pilaListas.Meter (pilaAux, lista);
      vectorPrincipal (3) := pilaAux;

   end cargarLista;

   procedure crearListaFinal (vector : vectorPilas.VecGeneric) is
      aux          : integer;
      punteroLista : listaEnteros.TipoLista;
   begin

      for j in vector'Range loop
         pilaAux := vector (j);
         pilaListas.Sacar (pilaAux, listaAux);
         punteroLista := listaaux;
         aux := listaEnteros.Info (punteroLista);
         while not listaEnteros.Vacia (punteroLista) loop
            if listaEnteros.Info (punteroLista) > aux then
               aux := listaEnteros.Info (punteroLista);
            end if;
            punteroLista := listaEnteros.Sig (punteroLista);
         end loop;
         listaEnteros.Insertar (listaFinal, aux);
         pilaListas.Meter (pilaAux, listaAux);
      end loop;

   end crearListaFinal;

begin
   cargarLista (listaAux);
   crearListaFinal (vectorPrincipal);

end main;
