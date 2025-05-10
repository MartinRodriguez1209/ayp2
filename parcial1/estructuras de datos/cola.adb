with Ada.Unchecked_Deallocation;

package body Cola is
   procedure Free is new Ada.Unchecked_Deallocation (TipoNodo, TipoPun);
   function Vacia (Cola : in TipoCola) return Boolean is
   begin
      -- la cola esta vacía si el valor de frente es nulo
      return Cola.Frente = null;
   end Vacia;
   procedure Crear (Cola : out TipoCola) is
   begin
      Cola := null;
   end Crear;

   procedure Inscola (Cola : in out TipoCola; Elemento : in TipoElem) is
      NuevoNodo : TipoPun := new TipoNodo'(Elemento, null);
   begin
      if Vacia (Cola) then
         Cola.Frente := NuevoNodo;
      else
         Cola.Final.Sig := NuevoNodo;
      end if;
      Cola.Final := NuevoNodo; --se actualiza el puntero externo
   end Inscola;
   procedure Supcola (Cola : in out TipoCola; Elemento : out TipoElem) is
      Temp : TipoPun := Cola.Frente;
   begin
      if Vacia (Cola) then
         raise ColaVacia;
      else
         Elemento := Cola.Frente.Info;
         Cola.Frente := Cola.Frente.Sig; --actualiza puntero externo
      end if;
      if Cola.Frente = null then
         Cola.Final := null; --evita puntero colgante

      end if;
      Free (Temp);
   end Supcola;

   procedure limpiar (cola : in out TipoCola) is
      temp : t_pun := cola.frente;
   begin
      while not vacia (cola) loop
         cola.frente := cola.frente.sig;
         if cola.frente = null then
            cola.final := null;
         end if;
         free (temp);
         temp := cola.frente;
      end loop;
   end limpiar;
end cola;
