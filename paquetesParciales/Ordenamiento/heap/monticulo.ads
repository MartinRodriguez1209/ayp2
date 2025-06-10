generic 
   type Tipo_Dato is private;
   type Vector_Monticulo is array (positive range <>) of Tipo_Dato;
   with function ">" (X,Y: in Tipo_Dato) return Boolean;
   package Monticulo is 
      procedure Restaurar_Abajo (vector: in out Vector_Monticulo);
      procedure Restaurar_Arriba (Vector: in out Vector_Monticulo);
      procedure Intercambiar(Izq,Der: in out Tipo_Dato);
   end Monticulo;
   
