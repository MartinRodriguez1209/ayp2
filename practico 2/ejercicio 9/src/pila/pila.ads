generic
   -- archivo .ads, especificación del paquete genérico Pila.
   type TipoElemento is private; -- se definirá como parámetro en la instanciación del paquete
package Pila is
   type TipoPila (Max : Positive) is private; --parte visible
   UNDERFLOW, OVERFLOW : exception;
   procedure Limpiar (Pila : in out TipoPila);
   function Vacia (Pila : in TipoPila) return Boolean;
   function Llena (Pila : in TipoPila) return Boolean;
   procedure Meter (Pila : in out TipoPila; NuevoElemento : in TipoElemento);
   procedure Sacar (Pila : in out TipoPila; ElementoSacado : out TipoElemento);
private
   --parte oculta/privada del paquete, me permite construir la estructura con su funcionamientotype ArregloPila is array (Positive range <>) of TipoElemento;
   type TipoPila (Max : Positive) is record
      cabeza    : Natural := 0;
      Elementos : ArregloPila (1 .. Max);
   end record;
end Pila;
