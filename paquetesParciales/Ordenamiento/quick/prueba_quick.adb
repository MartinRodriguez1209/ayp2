with Ada.Integer_Text_Io,quicksort;
use Ada.Integer_Text_Io;
procedure Prueba_quick is
   subtype indice is integer range 1..3;
   procedure Putinteger (X: in integer) is 
   begin
      Put (X);
   end Putinteger;
   procedure Getinteger (X: out integer) is
   begin
      Get(X);
   end Getinteger;
   package paq_mergesort is new quicksort(Integer,indice,PutInteger,GetInteger,"<=","<");
   use paq_mergesort;   
vector:arreglo.Tipovec;
begin
   Leer(Vector);
   Ordrapida(Vector,1,3);
   Imprimir(Vector);

   end prueba_quick;
