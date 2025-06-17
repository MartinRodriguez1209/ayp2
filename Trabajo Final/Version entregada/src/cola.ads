--ESTUDIANTE: ZAHN MATIAS SEBASTIAN


generic
   type TipoElem is private;
package Cola is
   type TipoCola is private;
   colaVacia: exception;
   
   procedure Crear (cola:in out TipoCola );
   function Vacia (Cola: in TipoCola) return Boolean;
   procedure Limpiar (Cola : in out TipoCola);
   procedure insertar(Cola:in out TipoCola; Elemento: in TipoElem);
   procedure suprimir(Cola:in out TipoCola; Elemento: out TipoElem);
   
   
private
type TipoNodo;
type TipoPun is access TipoNodo;
type TipoNodo is
record
Info: TipoElem;
Sig: TipoPun;
end record;
type TipoCola is
record
Frente, Final: TipoPun;
end record;
   

end Cola;
