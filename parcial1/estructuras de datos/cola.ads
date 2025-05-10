generic
   type tipoElem is private;
package cola is

   function Vacia (Cola : in TipoCola) return Boolean;
   procedure Crear (Cola : out TipoCola);
   procedure Inscola (Cola : in out TipoCola; Elemento : in TipoElem);
   procedure Supcola (Cola : in out TipoCola; Elemento : out TipoElem);
   procedure Limpiar (Cola : in out TipoCola);
   type TipoNodo;
   type TipoPun is access TipoNodo;
   type TipoNodo is record
      Info : TipoElem;
      Sig  : TipoPun;
   end record;
   type TipoCola is record
      Frente, Final : TipoPun;
   end record;
end cola;
