package body Monticulo is
   procedure Intercambiar(Izq,Der: in out Tipo_Dato) is
      Aux: Tipo_Dato;
   begin
      Aux:= Izq;
      Izq:=Der;
      Der:=Aux;
   end Intercambiar;
   
   function Hijomayor (Vector: in Vector_Monticulo) return Positive is
      Hijoizq,Hijoder:Positive;
   begin
      Hijoizq:=Vector'First*2;
      Hijoder:=Vector'First*2 +1;
      if Hijoder > Vector'Last then return Hijoizq;
      else if Vector(Hijoizq) > Vector(Hijoder) then return Hijoizq;
         else return Hijoder;
         end if;
      end if;
      end Hijomayor;
         
      procedure Restaurar_Abajo(Vector: in out Vector_Monticulo) is
         Raiz,Mayor: Positive;
      begin
         Raiz:= Vector'First;
         if Raiz <= Vector'Last /2 then
            Mayor:= Hijomayor(Vector);
            if Vector(Mayor) > Vector(Raiz) then
               Intercambiar(Vector(Raiz),Vector(Mayor));
               Restaurar_Abajo(Vector(Mayor..Vector'Last));
            end if;
         end if;
      end Restaurar_abajo;
      
      procedure Restaurar_Arriba (Vector: in out Vector_Monticulo) is
         Ultimo,Padre:Positive;
      begin
         Ultimo:= Vector'Last;
         if Ultimo >Vector'First then Padre :=Ultimo/2;
            if Vector(Ultimo) > Vector(Padre) then
               Intercambiar(Vector(Padre),Vector(Ultimo));
               Restaurar_Arriba(Vector(Vector'First..Padre));
            end if;
         end if;
      end Restaurar_Arriba;
      end monticulo;
   

   
   
