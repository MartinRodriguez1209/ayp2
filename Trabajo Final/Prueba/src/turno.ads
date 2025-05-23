with ada.Calendar;
with Calendar;

package turno is

   type TipoTurno is private;

   function Crear
     (fecha       : Calendar.Time;
      patente     : in String;
      dni_cliente : in String;
      motivo      : in String) return TipoTurno;
   function getDNI (T : TipoTurno) return String;
   function getMotivo (T : TipoTurno) return String;
   function getMecanico (T : TipoTurno) return Integer;
   function getCliente (T : TipoTurno) return integer;
   function cambiarMecanico
     (T : TipoTurno; dniMecanico : Integer) return TipoTurno;
   function cambiarFecha
     (T : TipoTurno; fechaNueva : Calendar.time) return TipoTurno;
   function cambiarMotivo
     (T : TipoTurno; motivoNuevo : String) return TipoTurno;
   function compararDni (T : TipoTurno; DNI : String) return Boolean;
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
