with Monticulo;

package body Colaprioridad is 

package MonticuloP is new Monticulo (TipoElemento,veccola,">");
   use MonticuloP;
   
procedure Inicializar (ColaP: in out TipoColaP) Is 
begin
ColaP.final:=0;
end Inicializar;

procedure Insertar (ColaP: in out TipoColaP; Elem: in Tipoelemento) is
begin
if colaP.final=colaP.max then raise Overflow;
   else colaP.final:=colaP.final+1;
   ColaP.elementos(ColaP.final):=Elem;
   RestaurarArriba(ColaP.elementos(1..ColaP.final));
end if;
end Insertar;


procedure Suprimir (ColaP: in out TipoColaP; Elem: out TipoElemento) is 
begin
if ColaP.final=0 then raise Underflow;
   else Elem:=ColaP.elementos(1);
   ColaP.elementos(1):=ColaP.elementos(ColaP.final);
   ColaP.final:=ColaP.final+1;
   RestaurarAbajo(ColaP.elementos(1..Colap.final));
end if;
end Suprimir;


function Llena (ColaP: in TipoColaP) return boolean is 
begin
return Colap.Final=Colap.max;
end Llena;

function Vacia (ColaP: in TipoColap) return boolean is 
begin
return Colap.final=0;
end Vacia;

end ColaPrioridad;