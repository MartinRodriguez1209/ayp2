package turno is

   type TipoTurno is private;

   function Crear
     (fecha       : in String; hora : in String; patente : in String;
      dni_cliente : in String; motivo : in String) return TipoTurno;
   function getDNI (T : TipoTurno) return String;
private

   Max_Long_Fecha   : constant := 5;
   Max_Long_Hora    : constant := 5;
   Max_Long_Patente : constant := 5;
   Max_Long_DNI     : constant := 5;
   Max_Long_Motivo  : constant := 5;

   type TipoTurno is record
      fecha       : String (1 .. Max_Long_Fecha);
      hora        : String (1 .. Max_Long_Hora);
      patente     : String (1 .. Max_Long_Patente);
      dni_cliente : String (1 .. Max_Long_DNI);
      motivo      : String (1 .. Max_Long_Motivo);
   end record;

end turno;
