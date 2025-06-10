with Ada.Unchecked_Deallocation;

package body Pila is
   procedure Free is new Ada.Unchecked_Deallocation (TipoNodo, TipoPila);
   procedure Crear (Pila : out TipoPila) is
   begin
      Pila := null;
   end Crear;

   function Vacia (Pila : in TipoPila) return Boolean is
   begin
      return Pila = null;
   end Vacia;

   procedure Meter (Pila : in out TipoPila; Elemento : in TipoElem) is
      NuevoNodo : TipoPila := new TipoNodo'(Elemento, Pila);
   begin
      Pila := NuevoNodo;
   end Meter;
   procedure Sacar (Pila : in out TipoPila; Elemento : out TipoElem) is
      Temp : TipoPila := Pila;
   begin
      if Vacia (Pila) then
         raise PilaVacia;
      else
         Elemento := Pila.Info;
         Pila := Pila.Sig;
         Free (Temp);
      end if;
   end Sacar;
   procedure Limpiar (Pila : in out TipoPila) is
      Temp : TipoPila := Pila;
   begin
      while not Vacia (Pila) loop
         Pila := Pila.Sig;
         Free (Temp);
         Temp := Pila;
      end loop;
   end Limpiar;

end Pila;
