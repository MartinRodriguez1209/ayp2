
with arbol;

generic

type Tipodato is private;
type indice is (<>);
with function ">" (x,b:tipodato) return boolean;
with function "<" (x,b:tipodato) return boolean;
with function Hash (Elem:tipodato) return indice;

package HashingArbol is 




package arbol2 is new Arbol (tipodato,"<",">");
   use arbol2;
   
type Tipovec is array (indice) of TipoArbol;


procedure Insertar(vec: in out tipovec; Elem: in tipodato);
function Buscar (vec: tipovec; elem:tipodato) return boolean;
procedure Suprimir (vec: in out tipovec; elem: in tipodato);


end HashingArbol;
