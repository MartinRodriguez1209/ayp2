package body Pila is
   procedure Limpiar (Pila : in out TipoPila) is
   begin
      Pila.cabeza := 0;
   end Limpiar;
   function Vacia (Pila : in TipoPila) return Boolean is
   begin
      return Pila.cabeza = 0;
   end Vacia;
   function Llena (Pila : in TipoPila) return Boolean is
   begin
      return Pila.cabeza = Pila.Max;
   end Llena;
   procedure Meter (Pila : in out TipoPila; NuevoElemento : in TipoElemento) is
   begin
      if not Llena (Pila) then
         Pila.cabeza := Pila.cabeza + 1;
         Pila.Elementos (Pila.cabeza) := NuevoElemento;
      else
         raise OVERFLOW;
      end if;
   end Meter;
   procedure Sacar (Pila : in out Tipopila; Elementosacado : out Tipoelemento)
   is
   begin
      if not Vacia (Pila) then
         Elementosacado := Pila.Elementos (Pila.cabeza);
         Pila.cabeza := Pila.cabeza - 1;
      else
         raise UNDERFLOW;
      end if;
   end Sacar;
end Pila;
