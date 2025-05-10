generic
   type TipoElem is private;
   with function "<" (X, Y : TipoElem) return Boolean;
   with function ">" (X, Y : TipoElem) return Boolean;
package Lista is
   type TipoLista is private;
   procedure Crear (Lista : out TipoLista);
   function Vacia (Lista : TipoLista) return Boolean;
   function Esta (Lista : TipoLista; Elemento : TipoElem) return Boolean;
   procedure Insertar (Lista : in out TipoLista; Elemento : in TipoElem);
   procedure Suprimir (Lista : in out TipoLista; Elemento : in TipoElem);
   procedure Limpiar (Lista : in out TipoLista);
   function Info (Lista : in TipoLista) return TipoElem;
   function Sig (Lista : in TipoLista) return TipoLista;
   ListaVacia : exception;
private
   type TipoNodo;
   type TipoLista is access TipoNodo;
   type TipoNodo is record
      Info : TipoElem;
      Sig  : TipoLista;
   end record;
end lista;
