with Mecanico;

package Reparacion is

   type TipoReparacion is private;
   ------------------------
   -----P.altareparacion-----
   ------------------------
   procedure Altareparacion
     (R            : out Tiporeparacion;
      Patente      : in String;
      M            : in Mecanico.Tipomecanico;
      Cosas        : in String;
      Partes       : in String;
      FechaIngreso : in String;
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

   function BuscarReparacion
     (R : in TipoReparacion; patente : in String) return Boolean;

private
   subtype String50 is String (1 .. 50);

   type TipoReparacion is record
      Patente            : String (1 .. 10);
      Long_Pat           : Natural;
      M                  : Mecanico.Tipomecanico;
      CosasReparadas     : String50;
      PartesReemplazadas : String50;
      FechaIngreso       : String (1 .. 10); -- 22/03/2022
      HorasTrabajo       : Float;
      Precio             : Float;
      Estado             : Boolean := True;
   end record;

end Reparacion;
