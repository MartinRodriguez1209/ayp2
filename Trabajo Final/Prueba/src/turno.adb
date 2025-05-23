with turno, ada.Text_IO;
use ada.Text_IO;

package body Turno is

   function Crear
     (fecha       : in String;
      hora        : in String;
      patente     : in String;
      dni_cliente : in String;
      motivo      : in String) return TipoTurno
   is
      use turno;
      T : TipoTurno;
   begin

      T.fecha := fecha;
      T.hora := hora;
      T.patente := patente;
      T.dni_cliente := dni_cliente;
      T.motivo := motivo;
      return T;
   end Crear;

   function compararDni (T : TipoTurno; DNI : String) return Boolean is
   begin
      return turno.getDNI (T) = DNI;
   end compararDni;

   procedure putTurno (t : in TipoTurno) is
   begin
      Put_Line ("patente: " & t.patente);
      Put_Line ("dni:" & t.dni_cliente);
      Put_Line ("fecha: " & t.fecha);
   end;

   procedure setFecha (t : in out TipoTurno; fechaNueva : in String) is
   begin
      t.fecha := fechaNueva;
   end;

   function getDNI (T : TipoTurno) return String is
   begin
      return T.dni_cliente;
   end getDNI;

end Turno;
