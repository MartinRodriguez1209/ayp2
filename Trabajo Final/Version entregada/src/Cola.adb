--ESTUDIANTE: ZAHN MATIAS SEBASTIAN

with Ada.Unchecked_Deallocation;


package body Cola is
   
   procedure Free is new Ada.Unchecked_Deallocation(Tiponodo, Tipopun);
   

   procedure Crear(cola: in out tipocola) is
   begin
      Cola.Frente:= null;
      cola.final:= null;
   end Crear;

   function Vacia (Cola: in Tipocola) return Boolean is
   begin -- la cola esta vacía si el valor de frente es nulo
      return Cola.Frente = null;
   end Vacia;
   
   procedure Insertar(Cola:in out Tipocola; Elemento: in Tipoelem) is
      Nuevonodo: Tipopun:= new Tiponodo'(Elemento, null);
   begin
      if Vacia (Cola) then Cola.Frente:= Nuevonodo;
      else Cola.Final.Sig:= Nuevonodo;
      end if;
      Cola.Final:= Nuevonodo; --se actualiza el puntero externo      
   end Insertar;
   
   procedure Suprimir(Cola:in out Tipocola; Elemento: out Tipoelem)is
      Temp: Tipopun:= Cola.Frente;
   begin
      if Vacia (Cola) then raise Colavacia;
      else Elemento:= Cola.Frente.Info;
         Cola.Frente:= Cola.Frente.Sig; --actualiza puntero externo
      end if;
      if Cola.Frente = null then Cola.Final:= null; --evita puntero colgante
      end if;
      Free (Temp);   
   end Suprimir;
   
   procedure Limpiar (Cola: in out Tipocola) is
      Temp:Tipopun:=Cola.Frente;
   begin
      while not Vacia(Cola) loop
         Cola.Frente:=Cola.Frente.Sig;
         if Cola.Frente = null then Cola.Final:=null;
         end if;
         Free(Temp);
         Temp:=Cola.Frente;         
      end loop;
   end Limpiar;
   
   
end Cola;

