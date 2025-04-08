generic -- archivo .ads, especificación del paquete genérico Cola.
   type TipoElemento is private;
package Cola is
   type TipoCola (Max : Positive) is private;
   OVERFLOW, UNDERFLOW : exception;
   procedure Limpiar (Cola : in out TipoCola);
   procedure Insertar
     (Cola : in out TipoCola; nuevoElemento : in TipoElemento);
   procedure Suprimir
     (Cola : in out TipoCola; ElemSuprimido : out TipoElemento);
   function Llena (Cola : in TipoCola) return Boolean;
   function Vacia (Cola : in TipoCola) return Boolean;

private
   type ArregloCola is array (Positive range <>) of TipoElemento;
   type TipoCola (Max : Positive)
   is --cuando instanciamos lo hacemos con Max + 1
   record
      Elementos : ArregloCola (1 .. Max);
      Frente    : Positive :=
        Max; --el frente debe indicar la posición que precede al primero
      Final     : Positive := Max;
   end record;
end Cola;
