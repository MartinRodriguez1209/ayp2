with cola, vectorSimple, listaOrdenada, ada.Text_IO;
use ada.Text_IO;

--  2.	Programar un procedimiento Analizar que dada la estructura E consistente en un vector de colas de listas
--   ordenadas de números enteros, muestre todos los números pares de las listas correspondientes
--   a la cola ubicada en la primera posición del vector.
--  Nota: Conservar la estructura E (no debe quedar alterada) e instanciar los TADs correspondientes

procedure main is

   package listaEnteros is new listaOrdenada (integer, "<", ">");
   package colaListas is new cola (listaEnteros.TipoLista);
   subtype rangovec is integer range 0 .. 5;
   procedure put (a : in colaListas.TipoCola) is
   begin
      null;
   end put;
   procedure get (a : out colaListas.TipoCola) is
   begin
      null;
   end get;
   package vectorColas is new
     vectorSimple (colaListas.TipoCola, rangovec, put, get);

   colaAux  : colaListas.TipoCola;
   listaAux : listaEnteros.TipoLista;
   colaAux2 : colaListas.TipoCola;

   procedure analisis (E : in out vectorColas.VecGeneric) is
      ptrLista : listaEnteros.TipoLista;
   begin

      for j in E'Range loop
         colaAux := E (j);
         colaListas.Crear (colaAux2);
         while not colaListas.vacia (colaAux) loop
            colaListas.Supcola (colaAux, listaAux);
            ptrLista := listaAux;
            colaAux2.Inscola (listaAux);
            if J = E'First then
               while not listaEnteros.Vacia (ptrLista) loop
                  if listaEnteros.Info (ptrLista) mod 2 = 0 then
                     Put (listaEnteros.Info (ptrLista));
                     New_Line;
                  end if;
                  ptrLista := listaEnteros.Sig (ptrLista);
               end loop;
            end if;
         end loop;
         E (J) := colaAux2;
      end loop;

   end analisis;

   E : vectorColas.VecGeneric;

begin
   analisis (E);
end;
