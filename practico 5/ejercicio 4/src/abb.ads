generic
   type Tipoelem is private;
   with function "<" (X, Y : Tipoelem) return Boolean;
   with function ">" (X, Y : Tipoelem) return Boolean;
   with function "=" (X, Y : Tipoelem) return Boolean;
   with procedure Put (X : in Tipoelem);

package ABB is
   type Tipoarbol is private;
   procedure Crear (Raiz : out Tipoarbol);
   function Vacio (Raiz : Tipoarbol) return Boolean;
   procedure Insertar (Raiz : in out Tipoarbol; Elemento : in Tipoelem);
   procedure Suprimir (Arbol : in out Tipoarbol; Valsup : in Tipoelem);
   function Esta (Raiz : Tipoarbol; Buscado : Tipoelem) return Boolean;
   procedure Limpiar (Ptr : in out Tipoarbol);
   function Izq (Ptr : Tipoarbol) return Tipoarbol;
   function Der (Ptr : Tipoarbol) return Tipoarbol;
   function Info (Ptr : Tipoarbol) return Tipoelem;
   --recorridos
   procedure Inorden (Ptr : in Tipoarbol);
   procedure Preorden (Ptr : in Tipoarbol);
   procedure Posorden (Ptr : in Tipoarbol);
   Arbolvacio : exception;

private
   type Tiponodo;
   type Tipoarbol is access Tiponodo;
   type Tiponodo is record
      Info     : Tipoelem;
      Izq, Der : Tipoarbol;
   end record;

end ABB;
