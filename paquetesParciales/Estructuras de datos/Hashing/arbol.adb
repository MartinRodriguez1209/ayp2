with Ada.Unchecked_Deallocation;

package body Arbol is

procedure Free is new
Ada.Unchecked_Deallocation(TipoNodo, TipoArbol);


function Vacio (Raiz: TipoArbol) return Boolean is
begin
return Raiz = null;
end Vacio;



procedure Limpiar (Ptr: in out TipoArbol) is
begin
if not Vacio (Ptr) then
Limpiar (Ptr.Izq);
Limpiar (Ptr.Der);
Free (Ptr);
end if;
end Limpiar;


procedure Insertar (Raiz: in out TipoArbol; Elemento:in TipoElem) is
begin
if Raiz = null then Raiz:= new TipoNodo'(Elemento,
null, null);
elsif Elemento < Raiz.Info then Insertar (Raiz.Izq,
Elemento);
else Insertar (Raiz.Der, Elemento);
end if;
end Insertar;

procedure Suprimir (Raiz: in out TipoArbol) is 
Anterior: TipoArbol;
Temp: TipoArbol:= Raiz;
begin
if Raiz.Der = null
then Raiz:= Raiz.Izq;
else if Raiz.Izq = null 
then Raiz:= Raiz.Der; 
else 
Temp:= Raiz.Izq;
Anterior:= Raiz;
while Temp.Der /= null loop 
Anterior:= Temp;
Temp:= Temp.Der;
end loop;
Raiz.info:= Temp.Info;
if Anterior = Raiz then Anterior.Izq:= Temp.Izq;
else Anterior.Der:= Temp.Izq;
end if; end if; end if;
Free (Temp);
end Suprimir;



procedure buscarMax (arbol: in out tipoarbol; maxPtr: out tipoarbol)
is ---procedimiento recursivo
begin
if arbol.der = null then MaxPtr:= arbol;
arbol:= arbol.izq;
else buscarMax (arbol.der, maxPtr);
end if;
end buscarMax;





procedure suprimirnodo (arbol : in out tipoarbol) is
temp: tipoarbol;
suc: tipoarbol;
begin
if arbol.izq = null and arbol.der = null then free(arbol); --es hojaelsif arbol.izq = null then temp:= arbol; --tiene un hijo derechoarbol:= arbol.der ;
Free (temp);
elsif arbol.der = null then temp := arbol; --tiene un hijo izquierdoarbol:= arbol.izq;
Free (temp);
else buscarMax (arbol.izq,suc); --tiene dos hijos
arbol.Info := suc.Info;
Free (suc);
end if;
end suprimirnodo;



procedure suprimirElemBuscado (arbol: in out tipoarbol; valsup: in tipoelem) is
Begin 
if arbol = null then raise arbolVacio;
elsif valsup = arbol.Info then suprimirnodo(arbol); --libera el nodoelsif valsup < arbol.Info then suprimir(arbol.izq, valsup);
else suprimirElemBuscado(arbol.der, valsup);
end if;
end suprimirElemBuscado;





function Esta (Raiz: in TipoArbol; Buscado: in TipoElem) return Boolean is 
Ptr: TipoArbol:= Raiz;
ValorEnArbol: Boolean:= False;
begin
while Ptr /= null and not ValorEnArbol loop
if Ptr.Info = Buscado then ValorEnArbol:= True;
else if Ptr.Info > Buscado then Ptr:= Ptr.Izq;
else Ptr:= Ptr.Der;
end if;
end if;
end loop;
return ValorEnArbol;
end Esta;


function Izq (ptr: TipoArbol) return TipoArbol is
begin
if Vacio(ptr) then raise ArbolVacio;
else return ptr.izq;
end if;
end izq;


function Der (ptr: TipoArbol) return TipoArbol is
begin
if Vacio(ptr) then raise ArbolVacio;
else return ptr.der;
end if;
end der;


function Info (ptr: TipoArbol) return TipoElem is 
begin
if Vacio(ptr) then raise ArbolVacio;
else return ptr.info;
end if;
end Info;

End Arbol;
