with Ada.Text_IO;
with System.Win32;
with packageCola, packagePila, Vector;
use Ada.Text_IO;


  procedure main
is

   MAX      : Integer := 20;  --maximo de las estructuras
   LONGITUD :
     Integer;     --para saber la longitud del texto que ingresa el usuario
   subtype rango_vector is Integer range 1 .. MAX;

   procedure putelement (A : in Character) is
   begin
      Put (A);
   end putelement;

   procedure getelement (A : out Character) is
   begin
      Get (A);
   end getelement;

   procedure Raiz is
   begin
      null;
   end Raiz;

   --estructuras de datos
   package cola_package_char is new packageCola (Character);
   package pila_package_char is new packagePila (Character);
   package vector_package_char is new
     Vector (Character, rango_vector, ' ', ">", putelement, getelement);


   --cargo la cola con los characters que tiene mi vector, ingresados por el usuario
   procedure cargarCola
     (vector : in vector_package_char.vecgeneric;
      cola   : in out cola_package_char.TipoCola) is
   begin
      for J in vector'First .. LONGITUD loop
         cola_package_char.Insertar (cola, vector (j));
      end loop;
   end cargarCola;

   --pido la cadena de texto y la guardo en un vector
   procedure pedirDatos (vector : in out vector_package_char.VecGeneric) is
      cadena            : String (1 .. MAX);
      longitud_correcta : Boolean;
   begin
      -- TODO falta verificar que la cadena que ingresa es impar
      loop
         Put_Line ("ingresa tu cadena de letras");
         Get_Line (cadena, LONGITUD);
         if LONGITUD mod 2 = 0 then
            longitud_correcta := False;
            Put_Line
              ("para revisar si es palindromo debe ser de longitud impar");
         else
            longitud_correcta := True;
         end if;
         exit when longitud_correcta = True;
      end loop;

      for J in 1 .. LONGITUD loop
         vector (j) := cadena (j);
      end loop;

   end pedirDatos;

   procedure obtenerWyWr
     (cola             : in out cola_package_char.TipoCola;
      vector1, vector2 : in out vector_package_char.VecGeneric)
   is
      temp      : Character;
      pila_char : pila_package_char.TipoPila (MAX);
   begin
      --saco la primera parte de la cadena de la cola y lo guardo en vector1
      for J in 1 .. (LONGITUD / 2) loop
         cola_package_char.Suprimir (cola, temp);
         vector1 (J) := temp;
      end loop;

      --con esto saco el elemento del medio que no lo necesito
      cola_package_char.Suprimir (cola, temp);

      --ahora saco el resto de la cola y lo guardo en mi pila para luego invertir
      for J in 1 .. (LONGITUD / 2) loop
         cola_package_char.Suprimir (cola, temp);
         pila_package_char.Meter (pila_char, temp);
      end loop;

      --vacio la pila para que quede vector2 listo
      for J in 1 .. (LONGITUD / 2) loop
         pila_package_char.Sacar (pila_char, temp);
         vector2 (J) := temp;
      end loop;
   end obtenerWyWr;

   --uso un metodo nuevo para comparar porque el del paquete de vectores no funciona si comparas vectores no llenos, porque la parte no llena tiene basura 
   procedure compararVectores
     (vector1, vector2 : vector_package_char.VecGeneric;
      compa            : in out Boolean) is
   begin
      compa := true;
      for j in 1 .. (LONGITUD / 2) loop
         if vector1 (j) /= vector2 (j) then
            compa := false;
            exit;
         end if;
      end loop;

   end compararVectores;

   cola_char   : cola_package_char.TipoCola (MAX);
   vector_char : vector_package_char.VecGeneric;
   vector1     : vector_package_char.VecGeneric;
   vector2     : vector_package_char.VecGeneric;
   comparacion : Boolean;
begin

   pedirDatos (vector_char);
   cargarCola (vector_char, cola_char);
   obtenerWyWr (cola_char, vector1, vector2);
   compararVectores (vector1, vector2, comparacion);

   if comparacion then
      Put_Line ("Es un palindromo!");
   else
      Put_Line ("No es un palindromo");
   end if;


end main;
