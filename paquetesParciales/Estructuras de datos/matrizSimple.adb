with Ada.Text_Io; use Ada.Text_Io;

package body matrizSimple is
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

end matrizSimple;
