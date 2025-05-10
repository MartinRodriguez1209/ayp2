with Ada.Unchecked_Deallocation; -- procedimiento genérico para liberar memoria
with Lista;

package body listaOrdenada is
   -- implementación del paquete Lista
   procedure Free is new Ada.Unchecked_Deallocation (TipoNodo, TipoLista);

   procedure Crear (Lista : out TipoLista) is
   begin
      Lista := null;
   end Crear;

   procedure Limpiar (Lista : in out TipoLista) is
      Temp : TipoLista := Lista;
   begin
      while Lista /= null loop
         Temp := Lista;
         Lista := Lista.Sig;
         Free (Temp);
      end loop;
   end Limpiar;

   function Vacia (Lista : in TipoLista) return Boolean is
   begin
      -- la lista está vacía si el puntero externo es nulo
      return Lista = null;
   end Vacia;

   function Info (Lista : in TipoLista) return TipoElem is
   begin
      if Lista /= null then
         return Lista.Info;
      else
         raise ListaVacia;
      end if;
   end Info;

   function Esta (Lista : TipoLista; Elemento : TipoElem) return Boolean is
      Ptr : TipoLista := Lista;
   begin
      -- recursivo
      if Vacia (Lista) then
         return false;
      else
         if Ptr /= null and then Ptr.Info = Elemento then
            return true;
         else
            return Esta (Lista.Sig, elemento);
         end if;
      end if;
   end Esta;

   --NO SE PUEDEN INSERTAR REPETIDOS
   procedure Insertar (lista : in out TipoLista; Elemento : in TipoElem) is
      NuevoNodo       : TipoLista := new TipoNodo'(Elemento, null);
      Ptr, ant        : TipoLista;
      LugarEncontrado : Boolean;
   begin
      if Vacia (Lista) then
         Lista := NuevoNodo;
      else
         -- inserta en una lista con valores y busca en que lugar se inserta para enlazar los nodos
         if Elemento < Lista.Info then
            NuevoNodo.Sig := Lista;
            Lista :=
              NuevoNodo; -- se insertó el valor al comienzoelse Ptr:= Lista;
            LugarEncontrado := false;
            while not LugarEncontrado and Ptr /= null loop
               if Elemento > Ptr.Info then
                  ant := Ptr;
                  Ptr := Ptr.Sig;
               else
                  LugarEncontrado :=
                    true; -- se inserta a continuación (antes que el nodo actual)
               end if;
            end loop;
            NuevoNodo.Sig := Ptr;
            ant.Sig := NuevoNodo;
         end if;
      end if;
   end Insertar;

   function Sig (Lista : in TipoLista) return TipoLista is
   begin
      if Vacia (Lista) then
         raise ListaVacia;
      else
         return Lista.Sig;
      end if;
   end Sig;

   procedure Suprimir (Lista : in out TipoLista; Elemento : in TipoElem) is
      actual : TipoLista := Lista;
      ant    : TipoLista := null;
   begin
      -- la lista no está vacia, elemento existe y es unico
      while actual /= null and then actual.Info < Elemento loop
         ant := actual;
         actual := actual.Sig;
      end loop;
      if ant = null then
         Lista := Lista.Sig; -- se elimina el primer elemento

      else
         ant.Sig :=
           actual.Sig; -- se elimina un elemento de cualquier otra posición
      end if;
      Free (actual);
   end Suprimir;
end listaOrdenada;
