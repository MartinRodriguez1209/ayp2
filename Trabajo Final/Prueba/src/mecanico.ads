package Mecanico is
   type Tipomecanico is private;
   Dni_Invalido : exception;

   function Crearmecanico
     (nombre, apellido, especialidad : string; dni : natural)
      return Tipomecanico;
   procedure Modificarmecanico
     (M : in out Tipomecanico; nuevoValor : string; rta : integer);
   procedure Bajamecanico (M : in out Tipomecanico);

   --FUNCIONES PARA OBTENER LOS DATOS DEL MECANICO
   function Obtenernombre (M : Tipomecanico) return String;
   function Obtenerapellido (M : Tipomecanico) return String;
   function Obtenerespecialidad (M : Tipomecanico) return String;
   function Obtenerdni (M : Tipomecanico) return Natural;

   function compararDniMecanico
     (M : Tipomecanico; dni : Natural) return Boolean;

private
   subtype String50 is String (1 .. 50);
   type Tipomecanico is record
      Nombre          : String50;
      apellido        : String50;
      Especialidad    : String50;
      Nombrelen       : natural;
      Apellidolen     : Natural;
      Especialidadlen : Natural;
      Dni             : Natural;
      estado          : boolean;
   end record;
end Mecanico;
