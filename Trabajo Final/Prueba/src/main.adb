with Ada.Calendar;
with Ada.Text_IO, ada.Integer_Text_IO;
with Calendar;
with Lista;
with turno;

procedure Main is
   use Ada.Text_IO;

   tiempo       : Ada.Calendar.Time;
   anio         : Ada.Calendar.Year_Number;
   mes          : Ada.Calendar.Month_Number;
   dia          : Ada.Calendar.Day_Number;
   segundos_dia : Ada.Calendar.Day_Duration;

   procedure imprimirFecha (fecha : Calendar.Time) is
      horas   : Integer;
      minutos : Integer;
   begin

      Ada.Calendar.Split (tiempo, anio, mes, dia, segundos_dia);
      horas := Integer (segundos_dia) / 3600;
      minutos := (Integer (segundos_dia) mod 3600) / 60;

      Put_Line
        (Integer'Image (dia)
         & "/"
         & Integer'Image (mes)
         & "/"
         & Integer'Image (anio));
      Put_Line
        (" Hora " & Integer'Image (horas) & ":" & Integer'Image (minutos));
   end imprimirFecha;

   function cargarFecha
     (dia     : in Integer;
      mes     : in Integer;
      anio    : in integer;
      hora    : in Integer;
      minutos : in Integer) return Calendar.Time
   is
      segundos : Calendar.Day_Duration;
   begin
      segundos := calendar.Day_Duration ((hora * 3600) + (minutos * 60));
      return Calendar.Time_Of (anio, mes, dia, segundos);
   end cargarFecha;

   unTurno  : turno.TipoTurno;
   package listaTurnos is new
     Lista (turno.TipoTurno, Integer, turno.compararDniCliente);
   unaLista : listaTurnos.TipoLista;

begin

   tiempo := cargarFecha (31, 5, 2025, 16, 30);

   unTurno := turno.Crear (tiempo, "abc123", 39436870, 40000111, "chapa");
   listaTurnos.Insertar (unaLista, unTurno);
   unTurno := turno.Crear (tiempo, "abc123", 31242345, 40000111, "asdf");
   listaTurnos.Insertar (unaLista, unTurno);
   unTurno := turno.Crear (tiempo, "abc123", 12341435, 40000111, "asdf");
   listaTurnos.Insertar (unaLista, unTurno);
   unTurno := turno.Crear (tiempo, "abc123", 44342442, 40000111, "asdf");
   listaTurnos.Insertar (unaLista, unTurno);

   unTurno := listaTurnos.Buscar (unaLista, 39436870);
   Put_Line (turno.getMotivo (unTurno));
   ada.Integer_Text_IO.put (turno.getCliente (unTurno));
   New_Line;
   unTurno := turno.cambiarMotivo (unTurno, "nuevo motivo: pintura");
   Put_Line (turno.getMotivo (unTurno));
   imprimirFecha (turno.getFecha (unTurno));

end Main;
