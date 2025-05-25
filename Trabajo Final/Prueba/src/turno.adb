with ada;
with ada.Exceptions;
with Ada.Strings.Fixed;

package body turno is

   function ajustarString (texto : String; longitud : Positive) return String
   is
   begin
      return texto & (1 .. longitud - texto'Length => ' ');
   end;

   function Crear
     (fecha        : Calendar.Time;
      patente      : in String;
      dni_cliente  : in Integer;
      dni_mecanico : in Integer;
      motivo       : in String) return TipoTurno
   is
      turno : TipoTurno;
   begin

      turno.fecha := fecha;
      if patente'Length <= turno.patente'Length then
         turno.patente := ajustarString (patente, turno.patente'Length);
      else
         raise DatoIncorrecto;
      end if;

      turno.dni_cliente := dni_cliente;

      turno.dni_mecanico := dni_mecanico;

      if motivo'Length <= turno.motivo'Length then
         turno.motivo := ajustarString (motivo, turno.motivo'Length);
      else
         raise DatoIncorrecto;
      end if;
      return turno;
   end;

   function getMotivo (T : TipoTurno) return String is
   begin
      return Ada.Strings.Fixed.Trim (T.motivo, Ada.Strings.Right);
   end getMotivo;

   function getMecanico (T : TipoTurno) return Integer is
   begin
      return t.dni_mecanico;
   end getMecanico;

   function getPatente (T : TipoTurno) return String is
   begin
      return T.patente;
   end getPatente;

   function getFecha (T : TipoTurno) return Calendar.Time is
   begin
      return T.fecha;
   end getFecha;

   function getCliente (T : TipoTurno) return integer is
   begin
      return t.dni_cliente;
   end getCliente;

   function cambiarMecanico
     (T : in out TipoTurno; dniMecanico : Integer) return TipoTurno is
   begin
      t.dni_mecanico := dniMecanico;
      return t;
   end;

   function cambiarFecha
     (T : in out TipoTurno; fechaNueva : Calendar.time) return TipoTurno is
   begin
      T.fecha := fechaNueva;
      return t;
   end cambiarFecha;

   function cambiarMotivo
     (T : in out TipoTurno; motivoNuevo : String) return TipoTurno is
   begin
      if motivoNuevo'Length <= t.motivo'Length then
         t.motivo := ajustarString (motivoNuevo, t.motivo'Length);
      else
         raise DatoIncorrecto;
      end if;
      return t;
   end cambiarMotivo;

   function compararDniCliente (T : TipoTurno; DNI : Integer) return Boolean is
   begin
      return t.dni_cliente = DNI;
   end compararDniCliente;

end turno;
