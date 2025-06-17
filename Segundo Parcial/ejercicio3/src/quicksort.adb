with Ada.Text_Io;
use Ada.Text_Io;
package body Quicksort is

   procedure Intercambiar(Izq, Der: in out Tipoelem) is
      Temp: Tipoelem;
   begin
      Temp:= Izq;
      Izq:= Der;
      Der:= Temp;
   end Intercambiar;

   procedure Ordrapida (Datos: in out Tipovec; Primero, Ultimo: in Indice) is
      Puntodivision: Indice;
      
   begin
      if Primero < Ultimo then
         Dividir(Datos, Primero, Ultimo, Puntodivision);
         if puntodivision>indice'first then
            Ordrapida(Datos, Primero, Indice'Pred(Puntodivision));
         end if;
         if puntodivision<indice'last then
            Ordrapida(Datos, Indice'Succ(Puntodivision), Ultimo);
            end if;
      end if;
   end Ordrapida; 

   procedure Dividir (Datos: in out TipoVec; Primero, Ultimo: in Indice; Puntodivision: in out Indice) is
      Derecha, Izquierda : integer;
      V: Tipoelem;
      
   begin
      V:= Datos(Primero);
      Derecha := indice'pos(indice'succ(Primero));
      Izquierda := indice'pos(Ultimo);
      loop
         while Derecha < Izquierda and Datos(indice'val(Derecha)) <= V loop
            Derecha := Derecha+1;
         end loop;
         if Derecha = Izquierda and Datos(indice'val(Derecha)) <= V then 
            Derecha := Derecha+1;
         end if;
         while Derecha <= Izquierda and Datos(indice'val(Izquierda)) > V loop
            Izquierda := Izquierda-1;
         end loop;
         if Derecha < Izquierda then 
            Intercambiar(Datos(indice'val(Derecha)), Datos(indice'val(Izquierda)));
            Derecha := Derecha+1;
            Izquierda := Izquierda-1;
         end if;
         exit when Derecha > Izquierda;
      end loop;
      Intercambiar(Datos(Primero), Datos(indice'val(Izquierda)));
      Puntodivision:= indice'val(Izquierda);
   end Dividir;

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
	  
end Quicksort;
