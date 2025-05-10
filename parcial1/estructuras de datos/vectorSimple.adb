package body Crearpackage is
   procedure Leer (Vec : out Vecgeneric) is
   begin
      for I in Vec'range loop
         Get (Vec (I));
      end loop;
   end Leer;

   procedure Imprimir (vec : in vecgeneric) is
   begin
      for I in Vec'range loop
         Put (Vec (I));
      end loop;
   end Imprimir;

end Crearpackage;
