with Turno;

package body Turno is

   procedure Crear
     (T           : out TipoTurno;
      fecha       : in String;
      hora        : in String;
      patente     : in String;
      dni_cliente : in String;
      motivo      : in String) is
   begin
      T.fecha := fecha;
      T.hora := hora;
      T.patente := patente;
      T.dni_cliente := dni_cliente;
      T.motivo := motivo;
   end Crear;

end Turno;
