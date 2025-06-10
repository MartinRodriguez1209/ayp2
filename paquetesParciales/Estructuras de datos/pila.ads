generic
   type TipoElem is private;
package pila is
   type TipoPila is private;
   procedure Crear (Pila : out TipoPila);
   function Vacia (Pila : in TipoPila) return Boolean;
   procedure Meter (Pila : in out TipoPila; Elemento : in TipoElem);
   procedure Sacar (Pila : in out TipoPila; Elemento : out TipoElem);
   procedure Limpiar (Pila : in out TipoPila);
   PilaVacia : exception;
private
   type TipoNodo;
   type TipoPila is access TipoNodo;
   type TipoNodo is record
      Info : TipoElem;
      Sig  : TipoPila;
   end record;
end pila;
