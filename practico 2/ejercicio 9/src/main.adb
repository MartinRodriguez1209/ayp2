with Ada.Text_IO;
with Ada.Integer_Text_IO, ada.Numerics.Elementary_Functions;
with vector, packagePila, packageCola;
use ada.Integer_Text_IO, ada.Numerics.Elementary_Functions;
--  9. Definir la estructura cola de pila de vectores (5 elementos) y escribir el programa que permita:
--  a) Obtener la posición (dentro del vector) del elemento mayor del vector que se encuentra
--  en la cabeza de la pila, que está en el frente de la cola. 

procedure Main is

   subtype rango is Integer range 1 .. 5;
   MAX : Integer := 5;

   function Raiz (A : in Integer) return Float is
   begin
      return Sqrt (Float (A));
   end Raiz;

   procedure putelemet (A : in Integer) is
   begin
      Put (A);
   end putelemet;

   procedure getelemet (A : out Integer) is
   begin
      Get (A);
   end getelemet;

   --instancio mi vectore de enteros

   package vectorInt is new
     Vector
       (Integer,
        rango,
        0,
        "+",
        "*",
        "-",
        ">",
        Raiz,
        putelemet,
        getelemet);
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

   procedure llenarVector (vector : VectorType) is
   begin

   end llenarVector;;

   --variables
   cola_pila_vectores : colaType;
   pila_vectores      : pilaType;
   vector             : VectorType;

begin

end Main;
