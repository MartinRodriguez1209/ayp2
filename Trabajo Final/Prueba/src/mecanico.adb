package body Mecanico is

   function Crearmecanico
     (nombre, apellido, especialidad : string; dni : natural)
      return Tipomecanico
   is
      M : Tipomecanico;

      function Calcularstring (Palabra : String) return Natural is
         Len : Natural := 0;
      begin
         for I in Palabra'range loop
            if palabra (I) /= ' ' then
               Len := Len + 1;
            end if;
         end loop;
         return len;
      end calcularstring;

   begin

      if not (Dni in 10_000_000 .. 99_999_999) then
         raise Dni_Invalido with "El dni debe contener exctamente 8 digitos. ";
      end if;

      M.Nombrelen := Calcularstring (Nombre);
      M.Apellidolen := Calcularstring (Apellido);
      m.especialidadlen := Calcularstring (especialidad);

      m.nombre (1 .. nombre'length) := nombre;
      m.apellido (1 .. apellido'length) := apellido;
      M.Especialidad (1 .. Especialidad'length) := Especialidad;
      m.dni := dni;

      return M;
   end Crearmecanico;

   --En el programa principal se debera elegir la rta y despues rellenar una nueva variable "NUEVOSDATOS" donde esten los campos a cambiar
   procedure Modificarmecanico
     (M : in out Tipomecanico; nuevoValor : String; rta : integer) is
   begin
      if Rta = 1 then
         --MODIFICAR NOMBRE
         M.Nombre (1 .. nuevoValor'Length) := nuevoValor;
         m.nombrelen := nuevoValor'Length;
      else
         M.apellido (1 .. nuevoValor'Length) := nuevoValor;
         m.apellidolen := nuevoValor'Length;
      end if;

   end Modificarmecanico;

   procedure Bajamecanico (M : in out Tipomecanico) is
   begin
      M.Estado := False;
   end Bajamecanico;

   function Obtenernombre (M : Tipomecanico) return String is
   begin
      return M.Nombre (1 .. M.Nombrelen);
   end Obtenernombre;

   function Obtenerapellido (M : Tipomecanico) return String is
   begin
      return M.Apellido (1 .. M.Apellidolen);
   end Obtenerapellido;

   function Obtenerespecialidad (M : Tipomecanico) return String is
   begin
      return M.Especialidad (1 .. M.Especialidadlen);
   end Obtenerespecialidad;

   function Obtenerdni (M : Tipomecanico) return Natural is
   begin

      return M.Dni;
   end Obtenerdni;

end Mecanico;
