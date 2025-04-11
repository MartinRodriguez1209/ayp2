with Ada.Integer_Text_Io, Ada.Text_Io, ada.Float_Text_IO, Arreglo_grupo3;
use ada.Integer_Text_IO, ada.Text_IO, ada.Float_Text_IO;

procedure Pco2_Ej4_Grupo3 is

   subtype Fila is Integer range 1 .. 3;
   subtype columna is integer range 1 .. 3;
   procedure Putelement (A : in Integer) is
   begin
      Put (A);
   end Putelement;

   procedure Getelement (A : out Integer) is
   begin
      Get (A);
   end Getelement;

   package packageGeneric is new
     Arreglo_grupo3
       (Integer,
        fila,
        columna,
        "+",
        "*",
        "-",
        ">",
        "<",
        Putelement,
        Getelement);
   use packageGeneric;

   --VARIABLES
   Mat        : Matgeneric;
   Mat2       : Matgeneric;
   Mattras    : Mattranspuesta;
   porcentaje : float;
   buscar     : integer;
   Encontrado : Boolean;
   Notstring  : exception;
   Mayor1     : exception;
   Posi_Fila  : Integer;
   posi_col   : integer;
begin
   loop
      begin
         Put_Line ("Inicio de programa");
         Put ("Ingrese 9 valores enteros para la matriz: ");
         Leer (Mat);
         imprimir (Mat);
         exit;
      exception
         when Data_Error =>
            begin
               Put_Line ("Debe ingresar numero enteros!");
               Skip_Line;
            end;
      end;
   end loop;

   New_Line;

   loop
      begin
         Put_Line ("Ingrese el elemento a buscar");
         Get (Buscar);
         Busqueda (Mat, Buscar, Encontrado, posi_fila, posi_col);

         if Encontrado then
            Put_Line
              ("La posicion del elemento dentro de la matriz es en la fila: "
               & Integer'Image (Posi_fila)
               & " y en la columna: "
               & integer'image (posi_col));
         else
            Put_Line
              ("El elemento buscado no se encuentra dentro del arreglo");
         end if;

         exit when Encontrado;
      exception
         when Data_Error =>
            begin
               Put_line ("Se debe ingresar un numero entero positivo");
               Skip_Line;
            end;
      end;
   end loop;

   Put_Line ("ORDENAMIENTO");
   Ordenamiento (Mat);
   Imprimir (Mat);

   loop
      begin
         Put_Line ("COMPARACION");
         Put_Line ("Igrese los valores de la segunda matriz");
         Leer (Mat2);

         exit;
      exception
         when Data_Error =>
            begin
               Put_line ("Se debe ingresar un numero entero positivo");
               Skip_Line;
            end;
      end;

   end loop;

   loop
      begin
         Put_Line
           ("Ingrese un numero entre 0 y 1 para la realizar la comparacion de matrices");
         Get (Porcentaje);
         if Porcentaje < 0.00 or Porcentaje > 1.00 then
            raise Mayor1;
         end if;
         Comparacion (Mat, Mat2, Porcentaje);
         exit;
      exception
         when Mayor1 =>
            begin
               Put_Line
                 ("Debe ser un numero comprendido entre 0 y 1, intetalo de nuevo!");
               Skip_Line;
            end;
         when Data_Error =>
            begin
               Put_line ("Se debe ingresar un numero entero positivo");
               Skip_Line;
            end;

      end;

   end loop;

   New_Line;

   Put_Line ("Trasposicion");
   Put_Line ("ANTES");
   Imprimir (Mat);

   Trasposicion (Mat, Mattras);
   Put_Line ("DESPUES");
   Imprimirtras (Mattras);

end;
