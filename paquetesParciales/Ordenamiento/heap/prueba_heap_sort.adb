with Ada.Integer_Text_Io,heap_sort;
use Ada.Integer_Text_Io;
procedure prueba_heap_sort is
   procedure Putinteger (X: in integer) is 
   begin
      Put (X);
   end Putinteger;
   procedure Getinteger (X: out integer) is
   begin
      Get(X);
   end Getinteger;
   package paquete_heap_sort is new Heap_Sort(Integer,PutInteger,GetInteger,">");
   use Paquete_Heap_Sort;
   
   Vector: tipo_Vector_Monticulo(4);
begin
   Leer(Vector);
   Ordmonticulo(Vector);
   Imprimir(Vector);

   end prueba_heap_sort;
