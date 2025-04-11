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

   procedure comparacion (vec1, vec2 : in vecgeneric; compa : out boolean) is
      Acum1, Acum2 : Tipodato := valorinicial;
      raiz1, raiz2 : float;
   begin

      for I in Indice'range loop
         Acum1 := Vec1 (I) * vec1 (i) + Acum1;
         Acum2 := Vec2 (I) * vec2 (i) + Acum2;
      end loop;

      raiz1 := Raiz (acum1);
      raiz2 := Raiz (acum2);

      if Raiz1 = Raiz2 then
         compa := true;
      else
         Compa := False;
      end if;

   end comparacion;

   procedure mayor (vec : in VecGeneric; posicion : out Integer) is
      aux : Tipodato;
   begin
      for j in vec'Range loop
         if j = 1 then
            aux := vec (j);
            posicion := Integer (j);
         else
            if vec (j) > aux then
               aux := vec (j);
               posicion := Integer (j);
            end if;
         end if;
      end loop;
   end mayor;

end vector;
