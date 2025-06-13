with ada.Text_IO;         use ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Ada.Wide_Text_IO;
with Quicksort;
with vecgenerico;

procedure main is

   subtype indice is integer range 1 .. 10;  -- rango de mi vector

   type alumno is record
      --registro de alumnos
      apellido : string (1 .. 30);
      promedio : integer;
   end record;
   procedure put (x : in alumno) is
      -- imprime un alumno
   begin
      Put ("Apellido :");
      put (x.apellido);
      New_Line;
      put ("Promedio: ");
      put (x.promedio);
      New_Line;
      New_Line;
   end;
   procedure get (x : out alumno) is
   begin
      null;
   end;

   function mayor (A, B : alumno) return Boolean is
      -- compara promedio, si son iguales despues compara por apellido
   begin
      if A.promedio > B.promedio then
         return A.promedio > B.promedio;
      else
         return A.apellido > B.apellido;
      end if;

   end;

   function menorIgual (A, B : alumno) return boolean is
      -- menor igual
   begin
      return A.promedio <= B.promedio;
   end;

   package ordenar is new
     Quicksort
       (alumno,
        indice,
        put,
        get,
        mayor,
        menorIgual); -- mayor y menor estan invertidos para que ordene de mayor a menor

   procedure mejores_alumnos
     (vectorAlumnos   : in out ordenar.Arreglo.tipoVec;
      nombreMateria   : in String;
      cantidadMejores : in integer) is
   begin
      -- vectorAlumnos tiene que ser de tipo Arreglo que esta en quicksort o no funciona

      put ("mejores alumnos de: " & nombreMateria);
      New_Line;
      ordenar.Ordrapida
        (vectorAlumnos, indice'First, indice'last); --ordeno los alumnos
      for i in indice'First .. indice'First + cantidadMejores - 1 loop
         -- imprimo los n mejores
         put (vectorAlumnos (i));
      end loop;

   end mejores_alumnos;

   procedure prueba is
      -- crea un arreglo con 10 alumnos con sus promedios de 1 a 10, luego los ordena con mejores_alumnos
      alumnos : ordenar.Arreglo.tipoVec;
      aux     : alumno;
   begin
      for i in indice'Range loop
         -- Asignar un apellido de ejemplo
         aux.apellido := (others => ' ');
         aux.apellido (1 .. 4) :=
           "Alu" & Character'Val (48 + i); -- "Alu1", "Alu2", etc.

         -- Asignar promedio de ejemplo
         aux.promedio := 1 + i;  -- Promedios descendentes de 9 a 0

         -- Guardar en el vector
         alumnos (i) := aux;
      end loop;

      ordenar.Arreglo.imprimir (alumnos);

      mejores_alumnos (alumnos, "Lengua", 4);

   end prueba;

begin
   prueba;
end main;
