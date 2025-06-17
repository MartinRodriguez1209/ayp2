generic
type TipoElem is private;
with function "<" (X, Y: TipoElem) return Boolean;
with function ">" (X, Y: TipoElem) return Boolean;

package Arbol is
type TipoArbol is private;
function Vacio (Raiz: TipoArbol) return Boolean;
procedure Limpiar (Ptr: in out TipoArbol);
procedure Insertar (Raiz: in out TipoArbol; Elemento: in TipoElem);
procedure Suprimir (Raiz: in out TipoArbol);
procedure buscarMax (arbol: in out tipoarbol; maxPtr: out tipoarbol);
procedure suprimirnodo (arbol : in out tipoarbol);
procedure suprimirElemBuscado (arbol: in out tipoarbol; valsup: in tipoelem);
function Esta(Raiz:in TipoArbol;Buscado:in TipoElem)return Boolean;
function Izq (Ptr: TipoArbol) return TipoArbol;
function Der (Ptr: TipoArbol) return TipoArbol;
function Info (Ptr: TipoArbol) return TipoElem;
ArbolVacio: exception;
Private

type TipoNodo;
type TipoArbol is access TipoNodo;
type TipoNodo is
record
Info: TipoElem;
Izq, Der: TipoArbol;
end record;

end Arbol;