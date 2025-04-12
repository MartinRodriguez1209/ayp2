with Ada.Text_IO;
with Ada.Integer_Text_IO, ada.Numerics.Elementary_Functions;
with vector, packagePila, packageCola;
with Ada.Numerics.Discrete_Random;
use ada.Integer_Text_IO, ada.Numerics.Elementary_Functions, Ada.Text_IO;
--  9. Definir la estructura cola de pila de vectores (5 elementos) y escribir el programa que permita:
--  a) Obtener la posición (dentro del vector) del elemento mayor del vector que se encuentra
--  en la cabeza de la pila, que está en el frente de la cola. 

procedure Main is

   subtype rango_vector is Integer range 1 .. 5;
   MAX : Integer := 5;

   function Raiz (A : in Integer) return Float is
   begin
      return Sqrt (Float (A));
   end Raiz;

   procedure putelement (A : in Integer) is
   begin
      Put (A);
   end putelement;

   procedure getelement (A : out Integer) is
   begin
      Get (A);
   end getelement;

   function Random_Integer return Integer is
      subtype rango_aleatorio is Integer range 1 .. 20;
      package Random_Int is new Ada.Numerics.Discrete_Random (rango_aleatorio);
      use Random_Int;
      Gen   : Generator;
      Valor : rango_aleatorio;
   begin
      Reset (Gen); -- inicializa el generador 
      Valor := Random (Gen); -- genera número aleatorio
      return Integer (valor); -- devuelvo el numero aleatorio
   end Random_Integer;
   --instancio mi vectore de enteros

   package vectorInt is new
     Vector
       (Integer,
        rango_vector,
        0,
        "+",
        "*",
        "-",
        ">",
        Raiz,
        putelement,
        getelement);
   use vectorInt;
   subtype VectorType is vectorInt.VecGeneric;
   -- instancio una pila de tipo vector de enteros

   package pila is new packagePila (vectorInt.VecGeneric);
   use pila;

   -- instancio una cola de tipo pila de vectores de enteros
   -- la cola tiene un maximo de 5 elementos, cada uno de los cuales es una pila de 5 elementos

   subtype pilaType is pila.TipoPila (MAX);
   package cola is new packageCola (pilaType);
   use cola;
   subtype colaType is cola.TipoCola (MAX);

   --procedimiento que llena un vector de numeros aleatorios

   procedure llenarVector (vector : out VectorType) is
   begin
      for j in rango_vector loop
         vector (j) := Random_Integer;
      end loop;
   end llenarVector;

   --procedimiento para llenar la cola con numeros aleatorios

   procedure llenarCola
     (cola_pila_vectores : out colaType;
      pila_vectores      : in out pilaType;
      vector             : in out VectorType) is
   begin
      for i in 1 .. 4 loop
         for j in 1 .. 5 loop
            llenarVector (vector);
            pila.Meter (pila_vectores, vector);
         end loop;
         cola.Insertar (cola_pila_vectores, pila_vectores);
         pila.Limpiar (pila_vectores);
      end loop;
   end llenarCola;

   --variables
   cola_pila_vectores : colaType;
   pila_vectores      : pilaType;
   vector             : VectorType;
   posicion           : Integer;
begin
   --lleno la cola de pila de vectores
   llenarCola (cola_pila_vectores, pila_vectores, vector);

   --busco el elemento mayor del primer vector de la primera cola
   cola.Suprimir (cola_pila_vectores, pila_vectores);
   pila.Sacar (pila_vectores, vector);
   vectorInt.mayor (vector, posicion);
   Put_Line ("Vector:");
   vectorInt.Imprimir (vector);
   New_Line;
   put
     ("Posicion del elemento mayor del primer vector de la primera cola es: "
      & Integer'Image (posicion));
   New_Line;

end Main;
