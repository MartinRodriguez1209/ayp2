with Ada.Unchecked_Deallocation; -- procedimiento genérico para liberar memoria
with Lista;

package body lista is
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
         Temp  := Lista;
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
         return False;
      else
         if Ptr /= null and then Ptr.Info = Elemento then
            return True;
         else
            return Esta (Lista.Sig, Elemento);
         end if;
      end if;
   end Esta;

   -- Preguntar si se puede
   function Buscar (Lista : TipoLista; Clave : String) return TipoElem is
      Ptr : TipoLista := Lista;
   begin
      while Ptr /= null loop
         if Comparar (Ptr.Info, Clave) then
            return Ptr.Info;
         end if;
         Ptr := Ptr.Sig;
      end loop;
   end Buscar;

   procedure Insertar (lista : in out TipoLista; Elemento : in TipoElem) is
      NuevoNodo : TipoLista := new TipoNodo'(Elemento, null);
   begin
      -- se inserta al comienzo de una lista
      if Vacia (lista) then
         lista := NuevoNodo;
      else
         NuevoNodo.Sig := lista;
         lista         := NuevoNodo; -- se inserto el valor
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
      if Vacia (Lista) then
         raise ListaVacia;
      else
         while actual /= null and then actual.Info /= Elemento loop
            ant    := actual;
            actual := actual.Sig;
         end loop;
         if ant = null then
            Lista := Lista.Sig; -- se elimina el primer elemento

         else
            ant.Sig := actual.Sig; -- se elimina un elemento de otra posición
         end if;
         Free (actual);
      end if;
   end Suprimir;

end lista;
