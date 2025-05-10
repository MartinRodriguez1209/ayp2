with Ada.Text_Io; use Ada.Text_Io;

package body Arreglo_Grupo3 is
   procedure Leer (Mat : out Matgeneric) is
   begin
      for I in Fila'range loop
         for J in Columna'range loop
            Get (Mat (I, j));
         end loop;
      end loop;
   end Leer;

   procedure Imprimir (Mat : in Matgeneric) is
   begin
      for I in Fila'range loop
         for J in Columna'range loop
            Put (Mat (I, J));
            put (" ");
         end loop;
         New_Line;
      end loop;
   end Imprimir;

   procedure Imprimirtras (Mat : Mattranspuesta) is
   begin
      for J in Columna'range loop
         for I in Fila'range loop
            Put (Mat (j, i));
            Put (" ");
         end loop;
         New_Line;
      end loop;
   end Imprimirtras;

   procedure Busqueda
     (Mat                 : in Matgeneric;
      A                   : in Tipodato;
      encontrado          : out boolean;
      posi_fila, posi_col : out integer) is
   begin
      Encontrado := False;
      for I in Mat'range loop
         for j in columna'range loop
            if Mat (I, j) = A then
               Encontrado := True;
               Posi_Fila := Integer (I);
               Posi_Col := Integer (J);
            end if;
         end loop;

      end loop;
   end Busqueda;

   procedure Ordenamiento (Mat : in out Matgeneric) is
      Aux : Tipodato;
   begin
      for i in fila'range loop
         for j in Fila'First .. fila'pred (fila'last) loop
            if Mat (J, 2) > Mat (fila'succ (j), 2) then
               for k in Columna'Range loop
                  Aux := Mat (J, K);
                  Mat (J, K) := Mat (Fila'Succ (J), K);
                  Mat (fila'succ (j), k) := aux;
               end loop;
            end if;
         end loop;
      end loop;
   end Ordenamiento;

   procedure Comparacion (Mat1, mat2 : in Matgeneric; porcentaje : in Float) is

      total     : integer := 0;
      Acum      : Integer := 0;
      Indiceent : Integer;
      Mayores   : Integer;

   begin

      for I in Fila'range loop
         for J in Columna'range loop
            total := total + 1;
            if Mat1 (I, J) > mat2 (I, J) then

               Acum := Acum + 1;
            else
               if Mat1 (I, J) < Mat2 (I, J) then
                  Acum := Acum - 1;
               end if;
            end if;
         end loop;
      end loop;

      indiceEnt := integer (porcentaje * float (1000));
      mayores := Integer ((Acum / Total) * 100);

      if acum = 0 then
         Put ("Los arreglos son iguales");
      else
         if mayores > indiceent then
            New_Line;
            Put ("El arreglo A es mayor a B");
         else
            Put ("El arreglo B es mayor A");
         end if;
      end if;
   end Comparacion;

   procedure Trasposicion
     (Mat : in out Matgeneric; mataux : out Mattranspuesta) is

   begin
      for i in Fila'range loop
         for J in Columna'range loop
            mataux (J, i) := mat (i, j);

         end loop;
      end loop;
   end Trasposicion;

end Arreglo_grupo3;
