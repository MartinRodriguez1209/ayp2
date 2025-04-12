package body vector is
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

   procedure Busqueda
     (vec        : in vecgeneric;
      A          : in Tipodato;
      encontrado : out boolean;
      posi       : out integer) is
   begin

      Encontrado := False;
      for I in Vec'range loop
         if Vec (I) = A then
            Encontrado := True;
            Posi := integer (i);
         end if;
      end loop;
   end Busqueda;

   procedure Ordenamiento (Vec : in out Vecgeneric) is
      Aux : Tipodato;
   begin
      for I in indice'range loop
         for J in indice'first .. indice'pred (indice'last) loop

            if vec (j) > vec (indice'succ (j)) then
               Aux := Vec (J);
               Vec (J) := Vec (indice'succ (j));
               Vec (indice'succ (j)) := Aux;
            end if;

         end loop;
      end loop;
   end Ordenamiento;

   procedure Comparacion (Vec1, Vec2 : in VecGeneric; Compa : out Boolean) is
   begin
      Compa := True;
      for I in Indice'Range loop
         if Vec1 (I) /= Vec2 (I) then
            Compa := False;
            exit;
         end if;
      end loop;
   end Comparacion;

   procedure mayor (vec : in VecGeneric; posicion : out Integer) is
      aux : Tipodato;
   begin
      aux := vec (vec'First);
      posicion := Integer (vec'First);
      for j in vec'First + 1 .. vec'Last loop
         if vec (j) > aux then
            aux := vec (j);
            posicion := Integer (j);
         end if;
      end loop;
   end mayor;

end vector;
