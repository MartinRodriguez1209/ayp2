with Ada.Calendar;
with Ada.Text_IO, ada.Integer_Text_IO;
use ada.Text_IO;
with Calendar;
with Clientes;
with Lista;
with Mecanico;
with Reparacion;
with turno;
with Ada.Strings.Unbounded;         use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with data;

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

      Ada.Calendar.Split (fecha, anio, mes, dia, segundos_dia);
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

   procedure pruebasTurno is
   begin

      Put_Line ("PRUEBAS DEL TAD TURNO");
      New_Line;
      -- creo una fecha de ejemplo
      tiempo := cargarFecha (31, 5, 2025, 16, 30);

      --creo varios turnos con dni distinto y los guardo en mi lista
      unTurno := turno.Crear (tiempo, "abc123", 39436870, 40000111, "chapa");
      listaTurnos.Insertar (unaLista, unTurno);
      unTurno := turno.Crear (tiempo, "abc123", 31242345, 40000111, "asdf");
      listaTurnos.Insertar (unaLista, unTurno);
      unTurno := turno.Crear (tiempo, "abc123", 12341435, 40000111, "asdf");
      listaTurnos.Insertar (unaLista, unTurno);
      unTurno := turno.Crear (tiempo, "abc123", 44342442, 40000111, "asdf");
      listaTurnos.Insertar (unaLista, unTurno);

      -- busco un turno especifico por dni
      unTurno := listaTurnos.Buscar (unaLista, 39436870);
      Put_Line
        ("Se crearon varios turnos, busco en la lista el turno con el dni 39436870");

      -- imprimo datos del turno
      Put_Line ("Motivo del turno: " & turno.getMotivo (unTurno));
      Put ("DNI del cliente");
      ada.Integer_Text_IO.put (turno.getCliente (unTurno));
      New_Line;
      Put ("Fecha del turno: ");
      imprimirFecha (turno.getFecha (unTurno));

      New_Line;

      -- cambio el motivo
      unTurno := turno.cambiarMotivo (unTurno, "pintura");
      Put_Line ("Se cambio el motivo del turno");
      -- imprimo el turno modificado
      Put_Line ("Nuevo motivo: " & turno.getMotivo (unTurno));
      New_Line;
      New_Line;
   end pruebasTurno;

   procedure pruebaMecanico is
      package listaMecanicos is new
        Lista (Mecanico.Tipomecanico, Natural, Mecanico.compararDniMecanico);
      unaLista   : listaMecanicos.TipoLista;
      unMecanico : mecanico.Tipomecanico;
   begin

      Put_Line ("PRUEBAS DEL TAD MECANICO");
      New_Line;

      -- creo varios mecanicos de ejemplo y los inserto a una lista
      unMecanico :=
        mecanico.Crearmecanico
          ("Martin", "Rodriguez", "Chapa", 39436870, TRUE);
      listaMecanicos.Insertar (unaLista, unMecanico);
      unMecanico :=
        mecanico.Crearmecanico ("Pepe", "Rodriguez", "Chapa", 40123123, TRUE);
      listaMecanicos.Insertar (unaLista, unMecanico);
      unMecanico :=
        mecanico.Crearmecanico ("Juan", "Rodriguez", "Chapa", 41111111, TRUE);
      listaMecanicos.Insertar (unaLista, unMecanico);

      -- realizo busqueda en la lista
      Put_Line ("Busco el mecanico con el dni 40123123 e imprimo sus datos");
      unMecanico := listaMecanicos.Buscar (unaLista, 40123123);
      Put_Line ("Nombre: " & mecanico.Obtenernombre (unMecanico));
      Put_Line ("Especialidad:" & Mecanico.Obtenerespecialidad (unMecanico));
      Put ("DNI: ");
      ada.Integer_Text_IO.Put (Mecanico.Obtenerdni (unMecanico));
      New_Line;
      New_Line;
      New_Line;

   end pruebaMecanico;

   -- La linea Get_Line (archivPrueba) esta dando problemas
   procedure leerArchivo is
      archivPrueba : File_Type;
      type arregloStrings is array (1 .. 9) of Unbounded_String;
      arreglo      : arregloStrings;
      unTurno      : turno.TipoTurno;
      fecha        : calendar.Time;
   begin
      Put_Line ("ejemplo de carga de un turno mediante archivo");
      New_Line;
      Open (archivPrueba, In_File, "data.txt");
      for j in 1 .. 9 loop
         arreglo (j) := To_Unbounded_String (Get_Line (archivPrueba));
      end loop;
      fecha :=
        cargarFecha
          (integer'Value (To_String (arreglo (4))),
           integer'Value (To_String (arreglo (5))),
           integer'Value (To_String (arreglo (6))),
           integer'Value (To_String (arreglo (7))),
           integer'Value (To_String (arreglo (8))));
      unTurno :=
        turno.Crear
          (fecha,
           To_String (arreglo (1)),
           integer'Value (to_string (arreglo (2))),
           integer'Value (to_string (arreglo (3))),
           To_String (arreglo (9)));
      Put_Line ("Se cargo un turno exitosamente");
      Put_Line ("Motivo del turno:" & turno.getMotivo (unTurno));
      Put_Line ("Fecha del turno:");
      imprimirFecha (turno.getFecha (unTurno));
   end leerArchivo;

   procedure pruebaTadData is

      listaClientes     : data.listaC.TipoLista;
      listaTurnos       : data.listaT.TipoLista;
      listaReparaciones : data.listaR.TipoLista;
      listaMecanicos    : data.listaM.TipoLista;
   begin

      data.cargarClientes (listaClientes);
      data.cargarMecanicos (listaMecanicos);
      data.cargarReparaciones (listaReparaciones);
      data.cargarTurnos (listaTurnos);
      data.guardarTurnos (listaTurnos);
      data.guardarMecanicos (listaMecanicos);
      data.guardarReparaciones (listaReparaciones);
      data.guardarClientes (listaClientes);

   end pruebaTadData;

begin
   pruebaTadData;
end Main;
