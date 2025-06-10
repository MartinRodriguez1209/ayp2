with Ada.Text_Io;
use Ada.Text_Io;
package body Mergesort is
  
procedure Leer (Datos: out Tipovec) is
begin
   for I in Indice'range loop
      Put("posicion "&Indice'image(I) &" del vector");
      new_line;
	 Get(Datos(I));
  end loop;
end Leer;

procedure Imprimir (Datos: in Tipovec) is
begin
   for I in Indice'range loop
      Put("posicion "&Indice'image(I) &" del vector");
      new_line;
	Put (Datos(I));
  end loop;
end Imprimir;
	  
   procedure Ordmezcla (Datos: in out Tipovec; Primero, Ultimo: in Indice) is
      Mitad: indice;
   begin
      if Primero<Ultimo then 
         Mitad := Indice'Val((Indice'Pos(Primero)+Indice'Pos(Ultimo))/2);
         Ordmezcla(Datos, Primero, Mitad);
         Ordmezcla(Datos, Indice'Succ(Mitad),Ultimo);
         Mezclar(Datos, Primero, Mitad, Indice'Succ(Mitad),Ultimo);
      end if;
   end Ordmezcla;
      
   procedure Mezclar (Datos: in out Tipovec; IzqPrim,IzqUlt, DerPrim,DerUlt: in Indice) is   --generico
      Temp:Tipovec;
      i:integer;
      Izqactual,Deractual: integer;
   begin
      Izqactual:= indice'pos(Izqprim);
      DerActual:=indice'pos(DerPrim);
      i:= indice'pos(Izqprim);
      while Izqactual <= indice'pos(Izqult) and Deractual <= indice'pos(Derult) loop
         if Datos(indice'val(Izqactual)) < Datos(indice'val(Deractual)) then
            Temp(indice'val(i)) := Datos(indice'val(Izqactual));
            Izqactual:=Izqactual+1;
         else
            Temp(indice'val(i)):= Datos(indice'val(Deractual));
            Deractual:= Deractual+1;
         end if;
         i:= i+1;
      end loop;
      while Izqactual<=indice'pos(Izqult) loop
         Temp(indice'val(i)):= Datos(indice'val(Izqactual));
         Izqactual:=Izqactual+1;
         I:= I+1;
      end loop;
      while Deractual <= indice'pos(Derult) loop
         Temp(indice'val(i)):= Datos(indice'val(Deractual));
         Deractual:=Deractual+1;
         I:= I+1;
      end loop;
      for I in indice'pos(Izqprim)..indice'pos(Derult) loop
         Datos(indice'val(I)):= Temp(indice'val(i));
      end loop;
	  --for I in indice'pos(Izqprim)..indice'pos(Derult) loop
		--Datos(indice'val(I)):= Temp(indice'val(I));
	  --end loop;
   end Mezclar;
   
end mergesort;
   
