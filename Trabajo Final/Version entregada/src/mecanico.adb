with turno;

package body Mecanico is

   function Crearmecanico
     (nombre, apellido, especialidad : string; dni : natural; estado : Boolean)
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
         raise Dni_Invalido;
      end if;

      M.Nombrelen := Calcularstring (Nombre);
      M.Apellidolen := Calcularstring (Apellido);
      m.especialidadlen := Calcularstring (especialidad);

      m.nombre (1 .. nombre'length) := nombre;
      m.apellido (1 .. apellido'length) := apellido;
      M.Especialidad (1 .. Especialidad'length) := Especialidad;
      m.dni := dni;
      m.estado := estado;

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

   function obtenerTareas (M : Tipomecanico) return TipoCola is
      aux   : TipoCola := m.Cantidadtarea;
      Cola2 : Tipocola;
      tarea : turno.Tipoturno;
   begin
      Crear (cola2);
      while not Vacia (aux) loop
         Suprimir (Aux, tarea);
         Insertar (cola2, tarea);
      end loop;
      return cola2;
   end obtenerTareas;

   function compararDniMecanico
     (M : Tipomecanico; dni : Natural) return Boolean is
   begin
      return M.Dni = dni;
   end compararDniMecanico;

   function obtenerEstado (M : Tipomecanico) return boolean is
   begin
      return M.estado;
   end obtenerEstado;
end Mecanico;
