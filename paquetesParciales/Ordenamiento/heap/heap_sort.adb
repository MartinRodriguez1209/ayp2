with Monticulo,Ada.Text_Io;
use ada.Text_IO;
package body Heap_Sort is
   package Paquete_Monticulo_vector is new Monticulo(Tipo_Dato,tipo_vector,">");
   use Paquete_Monticulo_Vector;
   

   procedure Constmonticulo (Vector: in Out Tipo_Vector_monticulo) is 
   begin 
      for I in reverse Integer'Pos(Vector.elementos'First)..Integer'Pos(Vector.elementos'Last)/2 loop
         Restaurar_abajo(Vector.elementos(integer'val(I)..vector.elementos'Last));
      end loop;
   end Constmonticulo;
   
   procedure Ordmonticulo (Vector: in out Tipo_Vector_monticulo) is
   begin
      Constmonticulo(Vector);
      for I in reverse integer'pos(Integer'Succ(Vector.elementos'first))..integer'pos(Vector.elementos'Last) loop
         Intercambiar(Vector.elementos(vector.elementos'First),Vector.elementos(integer'val(I)));
         Restaurar_abajo(Vector.elementos(vector.elementos'First..Integer'pred(I)));
         end loop;
   end Ordmonticulo;
   
 Procedure Leer (Vector: out Tipo_Vector_monticulo) is 
   begin
      for I in integer'pos(vector.elementos'first)..integer'pos(vector.elementos'last) loop
         Put("Valor numero "&integer'image(i)&": ");
         Get(Vector.elementos(integer'val(I)));
         end loop;
      end Leer;
       
      procedure Imprimir (Vector: in Tipo_Vector_monticulo) is
      begin
      for I in integer'pos(vector.elementos'first)..integer'pos(vector.elementos'last) loop
            Put (Vector.elementos(integer'val(I)));
            if I /= Integer'pos(vector.elementos'last) then
               Put(",");
            else
               Put(".");
               end if;
            end loop;
      end Imprimir;     
   
   end Heap_Sort;
   
