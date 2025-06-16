with ada.Calendar;

package body Reparacion is

   --------------------------
   ------Altareparacion------
   --------------------------

   -- Crea una nueva reparacion con los datos recibidos y la deja activa (Estado := True).
   procedure Altareparacion
     (R            : out Tiporeparacion;
      Patente      : in String;
      dniMecanico  : in Natural;
      Cosas        : in String;
      Partes       : in String;
      Fechaingreso : in Calendar.Time;
      Horas        : in Float;
      Precio       : in Float) is
   begin
      -- Carga la patente
      R.Patente := (others => ' ');
      R.Patente (1 .. Patente'Length) := Patente;
      R.Long_Pat := Patente'Length;

      -- Asigna el mecanico
      R.dniMecanico := dniMecanico;

      -- Carga descricion de cosas reparadas
      R.CosasReparadas := (others => ' ');
      R.CosasReparadas (1 .. Cosas'Length) := Cosas;

      -- Carga partes reemplazadas
      R.PartesReemplazadas := (others => ' ');
      R.PartesReemplazadas (1 .. Partes'Length) := Partes;

      -- Carga fecha de ingreso
      R.FechaIngreso := FechaIngreso;

      -- Asigna horas trabajadas
      R.Horastrabajo := Horas;

      -- Asigna precio
      R.Precio := Precio;

      --- Marca la reparacion como verdadwro
      R.Estado := True;
   end AltaReparacion;
   -------------------------------------------------------------------------------------------------------
   procedure BajaReparacion (R : in out TipoReparacion) is
   begin
      R.Estado := False;
   end BajaReparacion;
   --------------------------
   --ModificacionReparacion--
   --------------------------
   -- Modifica un campo especifico de una reparacion segun el nombre del campo y su nuevo vslor en texto.
   procedure ModificacionReparacion
     (R : in out TipoReparacion; Campo : in String; NuevoValor : in String) is
   begin
      -- Modifica la patente
      if Campo = "patente" then
         R.Patente := (others => ' ');
         R.Patente (1 .. NuevoValor'Length) := NuevoValor;
         R.Long_Pat := NuevoValor'Length;

      -- Modifica las cosas reparadas
      elsif Campo = "cosas" then
         R.CosasReparadas := (others => ' ');
         R.CosasReparadas (1 .. NuevoValor'Length) := NuevoValor;

      -- Modifica las partes reemplazadas
      elsif Campo = "partes" then
         R.PartesReemplazadas := (others => ' ');
         R.PartesReemplazadas (1 .. NuevoValor'Length) := NuevoValor;

      -- Modifica el precio (conversion de string a float)
      elsif Campo = "precio" then
         R.Precio := Float'Value (NuevoValor);

      -- Modifica las horas trabajadas (tambien convierte string a float)
      elsif Campo = "horas" then
         R.HorasTrabajo := Float'Value (NuevoValor);
      end if;
   end ModificacionReparacion;

   function BuscarReparacion
     (R : in TipoReparacion; patente : ClaveCadena) return Boolean is
   begin
      return R.Patente = patente;
   end BuscarReparacion;

   procedure modificarFecha
     (R : in out TipoReparacion; nuevaFecha : in Calendar.Time) is
   begin
      r.FechaIngreso := nuevaFecha;
   end modificarFecha;

   function getPatente (R : TipoReparacion) return String is
   begin
      return R.Patente;
   end getPatente;

   function getDniMecanico (R : TipoReparacion) return Natural is
   begin
      return R.dniMecanico;
   end getDniMecanico;

   function getCosasReparadas (R : TipoReparacion) return String is
   begin
      return R.CosasReparadas;
   end getCosasReparadas;

   function getPartesReemp (R : TipoReparacion) return String is
   begin
      return R.PartesReemplazadas;
   end getPartesReemp;

   function getFecha (R : TipoReparacion) return Calendar.Time is
   begin
      return R.FechaIngreso;
   end getFecha;

   function getHoras (R : TipoReparacion) return Float is
   begin
      return R.HorasTrabajo;
   end getHoras;

   function getPrecio (R : TipoReparacion) return Float is
   begin
      return R.Precio;
   end getPrecio;

   function getEstado (R : TipoReparacion) return Boolean is
   begin
      return R.Estado;
   end getEstado;
   ------------------------------------------------------------------------------------------
end Reparacion;
