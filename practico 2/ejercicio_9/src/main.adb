with Ada.Text_IO;
with Ada.Integer_Text_IO, ada.Numerics.Elementary_Functions, ada.Characters.Handling;
with vector, packagePila, packageCola;
with Ada.Numerics.Discrete_Random;
use ada.Integer_Text_IO, ada.Numerics.Elementary_Functions, Ada.Text_IO,  ada.Characters.Handling;
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
      Gen : Generator;
   begin
      Reset (Gen); -- inicializa el generador 
      return Integer (Random (Gen)); -- devuelvo el numero aleatorio
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
   elemento: Integer;
   begin
      for j in rango_vector loop
         Put ("Inserte el valor del vector en la posicion" & Integer'Image(j) & " :" );
         get(elemento);
         Skip_Line;
         vector (j) := elemento;
      end loop;
      
      put("Se completo la insercion de elementos en el vector");
      New_Line;
   end llenarVector;



   procedure llenarPila (pila_vectores: out pilaType; vector: in  out VectorType) is
   
   contador: integer:= 0;
   rta: Character;
   begin

      loop
         llenarVector (vector);
         pila.Meter(pila_vectores, vector);
         contador := contador + 1;
         Put_Line("Desea seguir ingresando mas vectores a la pila? :");
         get(rta);
         rta:= To_Upper(rta);
         exit when rta /= 'S' or contador = max;
      end loop;

   end llenarPila;

   --procedimiento para llenar la cola con numeros aleatorios

   procedure llenarCola
     (cola_pila_vectores : out colaType;
      pila_vectores      : in out pilaType;
      vector             : in out VectorType) is

      rta: Character;
      contador: Integer:= 0;
   begin
      loop
         llenarPila (pila_vectores, vector);
         cola.Insertar (cola_pila_vectores, pila_vectores);
         pila.Limpiar (pila_vectores);
         contador:= contador + 1;
         Put_Line("Desea seguir ingresando mas pilas a la cola? :");
         get(rta);
         rta:= To_Upper(rta);
      exit when rta /= 'S' or contador = max-1;
      end loop;
   end llenarCola;



   --variables
   cola_pila_vectores : colaType;
   pila_vectores      : pilaType;
   vector             : VectorType;
   posicion           : Integer;
begin

   Put_Line ("PROGRAMA PRINCIPAL");

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
