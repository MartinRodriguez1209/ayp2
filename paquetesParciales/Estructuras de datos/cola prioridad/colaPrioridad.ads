

generic
type TipoElemento is private;
with function ">" (Izq, Der: in Tipoelemento) return Boolean;

   package ColaPrioridad is
   type TipoColaP (Max: Positive) is private;
   OVERFLOW: exception;
   UNDERFLOW: exception;
   procedure Inicializar(ColaP: in out TipoColaP);
   procedure Insertar(ColaP: in out TipoColaP; Elem: in TipoElemento);
   procedure Suprimir(ColaP: in out TipoColaP; Elem: out TipoElemento);
   function Llena(ColaP: in TipoColaP) return Boolean;
   function Vacia(Colap: in Tipocolap) return Boolean;
   
private
type VecCola is array (Positive range <>) of TipoElemento;
type TipoColaP (Max: Positive) is record
Final: Natural:= 0;
Elementos: VecCola (1..Max);
end record;
end ColaPrioridad;