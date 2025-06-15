with Calendar;
with Mecanico;
with ada.Calendar;

package Reparacion is

   type TipoReparacion is private;
   ------------------------
   -----P.altareparacion-----
   ------------------------
   procedure Altareparacion
     (R            : out Tiporeparacion;
      Patente      : in String;
      dniMecanico  : in Natural;
      Cosas        : in String;
      Partes       : in String;
      FechaIngreso : in Calendar.Time;
      Horas        : in Float;
      Precio       : in Float);
   ------------------------
   -----P.bajareparacion-----
   ------------------------
   procedure Bajareparacion (R : in out Tiporeparacion);

   ------------------------
   -----P.bajareparacion---
   ------------------------

   procedure ModificacionReparacion
     (R : in out TipoReparacion; Campo : in String; NuevoValor : in String);

   procedure modificarFecha
     (R : in out TipoReparacion; nuevaFecha : in Calendar.Time);
   function BuscarReparacion
     (R : in TipoReparacion; patente : in String) return Boolean;

   function getPatente (R : TipoReparacion) return string;
   function getDniMecanico (R : TipoReparacion) return natural;
   function getCosasReparadas (R : TipoReparacion) return string;
   function getPartesReemp (R : TipoReparacion) return String;
   function getFecha (R : TipoReparacion) return Calendar.Time;
   function getHoras (R : TipoReparacion) return float;
   function getPrecio (R : TipoReparacion) return Float;
   function getEstado (R : TipoReparacion) return Boolean;

private
   subtype String50 is String (1 .. 50);

   type TipoReparacion is record
      Patente            : String (1 .. 10);
      Long_Pat           : Natural;
      dniMecanico        : Natural;
      CosasReparadas     : String50;
      PartesReemplazadas : String50;
      FechaIngreso       : Calendar.Time;
      HorasTrabajo       : Float;
      Precio             : Float;
      Estado             : Boolean := True;
   end record;

end Reparacion;
