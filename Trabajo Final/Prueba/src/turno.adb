with turno;

package body Turno is

   function Crear
     (fecha       : in String; hora : in String; patente : in String;
      dni_cliente : in String; motivo : in String) return TipoTurno
   is
      use turno;
      T : TipoTurno;
   begin

      T.fecha       := fecha;
      T.hora        := hora;
      T.patente     := patente;
      T.dni_cliente := dni_cliente;
      T.motivo      := motivo;
      return T;
   end Crear;

   function getDNI (T : TipoTurno) return String is
   begin
      return T.dni_cliente;
   end getDNI;

end Turno;
