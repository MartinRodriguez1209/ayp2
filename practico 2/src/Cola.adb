package body Cola is

   procedure Insertar (Cola : in out TipoCola; nuevoElemento : in TipoElemento)
   is
   begin
      if Llena (Cola) then
         raise OVERFLOW;
      else
         Cola.Final                  := Cola.Final rem Cola.Max + 1;
         Cola.Elementos (Cola.Final) := nuevoElemento;
      end if;
   end Insertar;

   procedure Suprimir
     (Cola : in out TipoCola; Elemsuprimido : out TipoElemento)
   is
   begin
      if Vacia (Cola) then
         raise UNDERFLOW;
      else
         Cola.Frente   := Cola.Frente rem Cola.Max + 1;
         Elemsuprimido := Cola.Elementos (Cola.Frente);
      end if;
   end Suprimir;

   function Llena (Cola : in TipoCola) return Boolean is
      siguiente : Positive;
   begin
      if Cola.Final = Cola.Max then
         siguiente := 1;
      else
         siguiente := Cola.Final + 1;
      end if;
      return siguiente = Cola.Frente;
   end Llena;

   function Vacia (Cola : in TipoCola) return Boolean is
   begin
      return Cola.Frente = Cola.Final;
   end Vacia;

   procedure Limpiar (Cola : in out TipoCola) is
   begin
      Cola.Frente := Cola.Max;
      Cola.Final  := Cola.Max;
   end Limpiar;

end Cola;
