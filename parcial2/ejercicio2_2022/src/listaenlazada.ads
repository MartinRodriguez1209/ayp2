generic -- especificación del paquete de lista enlazada no ordenada
type TipoElem is private;
package ListaEnlazada is
type TipoLista is private;
function Vacia (Lista: TipoLista) return Boolean;
function Esta (Lista: TipoLista; Elem: TipoElem) return Boolean;
procedure Insertar (Lista: in out TipoLista; Elemento: in TipoElem);
procedure Suprimir (Lista: in out TipoLista; Elemento: in TipoElem);
procedure Limpiar (Lista: in out TipoLista);
function Info (Lista: in TipoLista) return TipoElem;
function Sig (Lista: in TipoLista) return TipoLista;


ListaVacia: Exception;

private 

type tiponodo;
type TipoLista is access TipoNodo;

type TipoNodo is record
Info: TipoElem;
Sig: TipoLista;
end record;


end ListaEnlazada;