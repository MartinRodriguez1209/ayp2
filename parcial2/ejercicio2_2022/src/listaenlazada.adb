with ada.Unchecked_Deallocation;

package body listaenlazada is

procedure free is new ada.Unchecked_Deallocation(TipoNodo,Tipolista);

function Vacia (lista: tipolista) return boolean is 
begin 
return lista=null;
end vacia;


function Esta (lista: tipolista; Elem:Tipoelem) return boolean is
ptr:tipolista:=lista;
begin
if vacia(lista) then return false;
    else if ptr/=null and then ptr.info=elem  then return true;
       else return esta(lista.sig,elem);
    end if;
end if;
end Esta;


procedure Insertar (Lista: in out TipoLista; Elemento: in tipoelem) is 
NuevoNodo:tipolista:=new tiponodo'(elemento,null);
begin
if vacia(lista) then lista:=nuevonodo;
   else nuevonodo.sig:=lista;
   lista:=nuevonodo;
end if;
end Insertar;



procedure Suprimir (lista: in out TipoLista; Elemento: in tipoelem) is 
actual:tipolista:=lista;
ant:tipolista:=null;
begin
if Vacia(Lista) then raise ListaVacia;
else while actual /= null and then actual.Info /= Elemento loop
ant:= actual;
actual:= actual.Sig;
end loop;
if ant = null then Lista:= Lista.Sig; -- se elimina el primer elemento else; -- se elimina un elemento de otra posición
end if; 
ant.Sig:= actual.Sig;
Free (actual);
end if;
end Suprimir;



procedure Limpiar (Lista: in out TipoLista) is
Temp: TipoLista:= Lista;
begin
while Lista /= null
loop
Temp:= Lista;
Lista:= Lista.Sig;
Free (Temp);
end loop;
end Limpiar;



function Info (Lista: in TipoLista) return TipoElem is
begin
if Lista /= null then return Lista.Info;
else raise ListaVacia;
end if;
end Info;





function Sig (Lista: in TipoLista) return TipoLista is
begin
if Vacia(Lista) then raise ListaVacia;
else return Lista.Sig;
end if;
end Sig;


end listaenlazada;