with ada.Calendar;
with Calendar;

package turno is

   type TipoTurno is private;

   function Crear
     (fecha        : Calendar.Time;
      patente      : in String;
      dni_cliente  : in Integer;
      dni_mecanico : in integer;
      motivo       : in String) return TipoTurno;

   function getMotivo (T : TipoTurno) return String;
   function getMecanico (T : TipoTurno) return Integer;
   function getCliente (T : TipoTurno) return integer;
   function getPatente (T : TipoTurno) return String;
   function getFecha (T : TipoTurno) return Calendar.Time;

   function cambiarMecanico
     (T : in out TipoTurno; dniMecanico : Integer) return TipoTurno;

   function cambiarFecha
     (T : in out TipoTurno; fechaNueva : Calendar.time) return TipoTurno;

   function cambiarMotivo
     (T : in out TipoTurno; motivoNuevo : String) return TipoTurno;

   function compararDniCliente (T : TipoTurno; DNI : Integer) return Boolean;

   DatoIncorrecto : exception;
private

   Max_Long_Patente : constant := 7;
   Max_Long_Motivo  : constant := 250;

   type TipoTurno is record
      fecha        : Calendar.Time;
      patente      : String (1 .. Max_Long_Patente);
      dni_cliente  : Integer;
      motivo       : String (1 .. Max_Long_Motivo);
      dni_mecanico : integer;
   end record;

end turno;
