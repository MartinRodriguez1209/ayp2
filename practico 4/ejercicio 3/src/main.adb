with Ada.Wide_Text_IO;
with pila, Ada.Numerics.Float_Random, Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Numerics.Float_Random, Ada.Integer_Text_IO, Ada.Text_IO;

--   Dado un vector cuyos elementos son pilas (con implementación dinámica) de registros
--  compuestos por dos campos, uno de tipo entero y el otro de tipo carácter, programar un
--  procedimiento que permita obtener el promedio de los valores enteros contenidos en los registros
--  que están en el tope de cada pila. Se debe conservar la información almacenada en la
--  estructura. 

procedure main is

   MAXVECTOR : Integer := 5;

   type registro is record
      -- registro que tiene un entero y un char
      varEntero   : Integer;
      varCaracter : Character;
   end record;

   package pilaRecord is new Pila (registro); -- pila que almacena registros
   use pilaRecord;
   type vectorPila is array (1 .. 5) of pilaRecord.TipoPila; -- vector de pilas

   -- Genera un numero aleatorio entre min y max
   function Numero_Aleatorio (Min, Max : Integer) return Integer is

   begin
      declare
         Gen : Generator;
      begin
         Reset (Gen);
         return Min + Integer (Float (Max - Min + 1) * Random (Gen));
      end;
   end Numero_Aleatorio;

   -- Variables

   Vector       : vectorPila;
   registroAux  : registro;
   auxEnteroRan : Integer;
   pilaAux      : TipoPila;
   auxRegistro  : registro;
   Promedio     : Integer;

begin

   -- llenar una pila y guardarla en el vector
   for j in 1 .. MAXVECTOR loop
      auxEnteroRan := Numero_Aleatorio (1, 10);
      for i in 1 .. auxEnteroRan loop
         registroAux.varEntero := Numero_Aleatorio (1, 50);
         registroAux.varCaracter := 'a';
         pilaRecord.Meter (pilaAux, registroAux);

      end loop;
      Vector (j) := pilaAux;

      -- si vacio la pila pierdo todo lo que ya cargue, entonces creo una nueva
      pilaRecord.Crear (pilaAux);
   end loop;

   -- ahora recorro el vector y me fijo el valor de cada tope de la pila para calcular el promedio
   Promedio := 0;
   for j in 1 .. MAXVECTOR loop
      pilaAux := Vector (J);
      pilaRecord.Sacar (pilaAux, auxRegistro);
      Promedio := Promedio + auxRegistro.varEntero;

      -- Vuelvo a guardar el valor para mantener la pila
      pilaRecord.Meter (pilaAux, auxRegistro);
   end loop;
   -- Calculo el promedio
   Promedio := Promedio / MAXVECTOR;

   Put_Line ("El promedio es :" & Integer'Image (Promedio));
end;
