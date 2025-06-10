
package body HashingLista is

procedure Insertar (vec: in out tipovec; Elem: in tipodato) is
I:Indice;
begin 
I:=Hash(elem);
Insertar(vec(i),elem);
end Insertar;

Function Buscar (vec: tipovec; elem: tipodato) return boolean is
I:Indice;
begin
I:=Hash(elem);
if esta(vec(i),elem) then 
   return true;
   else return false;
end if;
end Buscar;

procedure Suprimir (vec: in out tipovec; elem: in tipodato) is
I:Indice;
begin
I:=Hash(elem);
Suprimir(vec(i),elem);
end Suprimir; 


End HashingLista;