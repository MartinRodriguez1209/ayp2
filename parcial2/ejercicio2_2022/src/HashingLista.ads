with listaenlazada;

generic

type Tipodato is private;
type indice is (<>);
with function ">" (x,b:tipodato) return boolean;
with function "<" (x,b:tipodato) return boolean;
with function Hash (Elem:tipodato) return indice;

package HashingLista is 

package Hashing_Lista is new ListaEnlazada (tipodato);
   use Hashing_lista;
   
type Tipovec is array (indice) of TipoLista;

procedure Insertar(vec: in out tipovec; Elem: in tipodato);
function Buscar (vec: tipovec; elem:tipodato) return boolean;
procedure Suprimir (vec: in out tipovec; elem: in tipodato);

end HashingLista;

