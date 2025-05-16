--  2.	Dada una cola de listas de vectores, escribe el procedimiento Promedio
--   que recibe dicha cola y calcula el promedio de los elementos del vector
--    situado al frente de la cola ubicada al principio de la lista.
--  Toda la estructura debe conservarse, es decir, permanecer intacta al
--   finalizar el subprograma.
--  Recuerda instanciar los TADs correspondientes.
with cola, lista, vectorSimple, ada.Text_IO;
use ada.Text_IO;

procedure main is

   subtype rangoVec is integer range 0 .. 5;
   procedure put (a : integer) is
   begin
      null;
   end put;

   procedure get (a : integer) is
   begin
      null;
   end get;

   package vectorEnteros is new vectorSimple (integer, rangoVec, put, get);
   package listaVec is new Lista (vectorEnteros.VecGeneric);
   package colaListas is new Cola (listaVec.TipoLista);

   colaPrincipal : colaListas.TipoCola;
   listaAux      : listaVec.TipoLista;
   vectorAux     : vectorEnteros.VecGeneric;
   colaAux       : colaListas.TipoCola;

   procedure promedio
     (cola : in out colaListas.TipoCola; promedio : out Integer) is

   begin

      -- saco el primer elemento y lo inserto en mi cola auxiliar
      colaListas.Supcola (cola, listaAux);
      colaListas.Crear (colaAux);
      colaListas.Inscola (colaAux, listaAux);

      -- busco el primer vector de mi cola
      vectorAux := listaVec.Info (listaAux);

      -- calculo el promedio
      promedio := 0;
      for j in vectorAux'Range loop
         promedio := promedio + vectorAux (j);
      end loop;
      promedio := promedio / vectorAux'Length;
      -- restablecer la estructura original

      while not colaListas.vacia (cola) loop
         colaListas.Supcola (cola, listaAux);
         colaListas.Inscola (colaAux, listaAux);
      end loop;

      while not colaListas.vacia (colaAux) loop
         colaListas.Supcola (colaAux, listaAux);
         colaListas.Inscola (cola, listaAux);
      end loop;

   end promedio;

begin
   null;
end;
