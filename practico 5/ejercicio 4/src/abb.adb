with Ada.Unchecked_Deallocation;

package body ABB is

   procedure Free is new Ada.Unchecked_Deallocation (Tiponodo, Tipoarbol);

   procedure Crear (Raiz : out Tipoarbol) is--ok
   begin
      Raiz := null;
   end Crear;
   ----------------------------------------------------------------------
   function Vacio (Raiz : Tipoarbol) return Boolean is--ok
   begin
      return Raiz = null;
   end Vacio;
   ----------------------------------------------------------------------
   procedure Insertar (Raiz : in out Tipoarbol; Elemento : in Tipoelem) is
      Nuevonodo : Tipoarbol := new Tiponodo'(Elemento, null, null);
      Ptr       : Tipoarbol := Raiz;
      Anterior  : Tipoarbol := null;
   begin
      --el nodo creado contiene el elemento y se inserta en el lugar apropiado del ABB
      while Ptr /= null loop-- busca hasta que ptr caiga del arbol
         Anterior := Ptr;
         if Ptr.Info > Elemento then
            Ptr := Ptr.Izq;
         else
            Ptr := Ptr.Der;
         end if;
      end loop;
      --se encontro el lugar de insercion. Conectar punteros para enlazar Nuevonodo al arbol
      if Anterior = null then
         Raiz := Nuevonodo;
      else
         if Anterior.Info > Elemento then
            Anterior.Izq := Nuevonodo;
         else
            Anterior.Der := Nuevonodo;
         end if;
      end if;
   end Insertar;
   ------------------------------------------------------------------------
   procedure Buscarmax (Arbol : in out Tipoarbol; Maxptr : out Tipoarbol) is
   begin
      if Arbol.Der = null then
         Maxptr := Arbol;
         Arbol  :=
           Arbol
             .Izq;--se realiza el enganche con el hijo izquierdo del mayor de los menores
      else
         Buscarmax (Arbol.Der, Maxptr);
      end if;
   end Buscarmax;

   procedure Suprimirnodo (Arbol : in out Tipoarbol) is
      Temp : Tipoarbol;
      Max  : Tipoarbol;
   begin
      if Arbol.Izq = null and Arbol.Der = null then
         Free (Arbol);--es hoja
      elsif Arbol.Izq = null then
         Temp  := Arbol;--tiene un hijo derecho
         Arbol := Arbol.Der;
         Free (Temp);
      elsif Arbol.Der = null then
         Temp  := Arbol; --tiene un hijo izquierdo
         Arbol := Arbol.Izq;
         Free (Temp);
      else
         Buscarmax (Arbol.Izq, Max);--tiene dos hijos
         Arbol.Info := Max.Info;
         Free (Max);
      end if;
   end Suprimirnodo;

   procedure Suprimir (Arbol : in out Tipoarbol; Valsup : in Tipoelem) is
   begin
      if Arbol = null then
         raise Arbolvacio;
      elsif Valsup = Arbol.Info then
         Suprimirnodo (Arbol);--libera el nodo
      elsif Valsup < Arbol.Info then
         Suprimir (Arbol.Izq, Valsup);
      else
         Suprimir (Arbol.Der, Valsup);
      end if;
   end Suprimir;
   ----------------------------------------------------------------------------------
   function Esta (Raiz : Tipoarbol; Buscado : Tipoelem) return Boolean is
      Ptr          : Tipoarbol := Raiz;
      Valorenarbol : Boolean   := False;
   begin
      while Ptr /= null and not Valorenarbol loop
         if Ptr.Info = Buscado then
            Valorenarbol := True;
         else
            if Ptr.Info > Buscado then
               Ptr := Ptr.Izq;
            else
               Ptr := Ptr.Der;
            end if;
         end if;
      end loop;
      return Valorenarbol;
   end Esta;
   --------------------------------------------------------------------------------
   procedure Limpiar (Ptr : in out Tipoarbol) is
   begin
      if not Vacio (Ptr) then
         Limpiar (Ptr.Izq);
         Limpiar (Ptr.Der);
         Free (Ptr);
      end if;
   end Limpiar;
   --------------------------------------------------------------------------
   function Izq (Ptr : Tipoarbol) return Tipoarbol is
   begin
      if Vacio (Ptr) then
         raise Arbolvacio;
      else
         return Ptr.Izq;
      end if;
   end Izq;
   --------------------------------------------------------------------------
   function Der (Ptr : Tipoarbol) return Tipoarbol is
   begin
      if Vacio (Ptr) then
         raise Arbolvacio;
      else
         return Ptr.Der;
      end if;
   end Der;
   --------------------------------------------------------------------------
   function Info (Ptr : Tipoarbol) return Tipoelem is
   begin
      if Vacio (Ptr) then
         raise Arbolvacio;
      else
         return Ptr.Info;
      end if;
   end Info;
   --------------------------------------------------------------------------

   procedure Inorden (Ptr : in Tipoarbol) is
   begin --inorden recursivo
      if not Vacio (Ptr) then
         Inorden (Izq (Ptr));
         Put (Info (Ptr));
         Inorden (Der (Ptr));
      end if;
   end Inorden;

   --------------------------------------------------------------------------

   procedure Preorden (Ptr : in Tipoarbol) is
   begin --preorden recursivo
      if not Vacio (Ptr) then
         Put (Info (Ptr));
         Preorden (Izq (Ptr));
         Preorden (Der (Ptr));
      end if;
   end Preorden;
   --------------------------------------------------------------------------

   procedure Posorden (Ptr : in Tipoarbol) is
   begin --posorden recursivo
      if not Vacio (Ptr) then
         Posorden (Izq (Ptr));
         Posorden (Der (Ptr));
         Put (Info (Ptr));
      end if;
   end Posorden;
end ABB;
