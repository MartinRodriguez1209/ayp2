
generic
   type Tipo_dato is private;
   with procedure Put (X: in Tipo_Dato);
   with procedure Get (X: out Tipo_Dato);
   with function ">" (A, B: in Tipo_Dato) return Boolean;
   package Heap_Sort is
      type tipo_vector_monticulo (Max:positive) is private;
      procedure Leer(Vector: out Tipo_Vector_monticulo);
      procedure Imprimir (Vector : in Tipo_Vector_monticulo);
      procedure Ordmonticulo (Vector: in out Tipo_Vector_monticulo); 
      private
      type tipo_vector is array (Positive range <>) of Tipo_Dato;   
      type Tipo_Vector_Monticulo (Max:Positive) is record
         Elementos:Tipo_Vector(1..Max);
      end record;
      
   end Heap_Sort;
   