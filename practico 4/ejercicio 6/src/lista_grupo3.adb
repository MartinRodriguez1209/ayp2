with Ada.Unchecked_Deallocation; -- procedimiento genérico para liberar memoria
   
package body Lista is-- implementación del paquete Lista
   
   procedure Free is new Ada.Unchecked_Deallocation(Tiponodo, Tipolista);
   
   procedure Crear (Lista: out Tipolista) is      
   begin
      Lista:= null;
   end Crear;
   
 procedure Limpiar (Lista: in out Tipolista) is 
    Temp: Tipolista:= Lista;
 begin
    while Lista /= null loop         
       Temp:= Lista;
       Lista:= Lista.Sig;
       Free (Temp);
    end loop;
 end Limpiar;
 
 function Vacia (Lista: in Tipolista) return Boolean is
 begin-- la lista está vacía si el puntero externo es nulo
    return Lista = null; 
 end Vacia;   
 
 function Info (Lista: in  Tipolista) return Tipoelem is
 begin
    if Lista /= null then return Lista.Info;
    else 
       raise Listavacia;
    end if;
 end Info;
 
 function Esta (Lista: Tipolista; Elem: Tipoelem) return Boolean is
    Ptr: Tipolista:= Lista;
 begin-- Iterativo
    if Vacia (Lista) then return False;
    else 
       while Ptr /= null loop
          if Ptr.Info = Elem then 
             return True;
          end if;
          Ptr:= Ptr.Sig;   
       end loop;
    end if;
    return False;
 end Esta;
 
 procedure Insertar (Lista: in out Tipolista; Elemento: in Tipoelem) is
    Nuevonodo: Tipolista:= new Tiponodo'(Elemento, null);
 begin-- se inserta al comienzo de una lista  
    if Vacia (Lista) then Lista:= Nuevonodo;
    else Nuevonodo.Sig := Lista;
       Lista:= Nuevonodo;-- se inserto el valor
    end if;
 end Insertar;
 

 function Sig (Lista: in Tipolista) return Tipolista is
 begin
    if Vacia(Lista) then 
       raise Listavacia;
    else 
       return Lista.Sig;
    end if; 
 end Sig;
 
    
 procedure Suprimir (Lista: in out Tipolista; Elemento: in Tipoelem) is
    Actual: Tipolista:= Lista;
    Ant: Tipolista:= null;
 begin
    if Vacia(Lista) then 
       raise Listavacia;
    else 
       while Actual /= null and then Actual.Info /= Elemento loop
          Ant:= Actual;
          Actual:= Actual.Sig;
       end loop;
       if Ant = null then Lista:= Lista.Sig;-- se elimina el primer elemento
       else Ant.Sig:= Actual.Sig; -- se elimina un elemento de otra posición
       end if; 
       Free (Actual);   
    end if;
 end Suprimir;
 
end Lista;


