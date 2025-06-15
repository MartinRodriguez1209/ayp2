with ada.Text_IO;                   use ada.Text_IO;
with ada.Strings.Unbounded;         use ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Calendar;
with data;
with turno;
with Clientes;
with Mecanico;
with Reparacion;
with ada.Float_Text_IO;
with ada.Strings.Fixed;

package body data is

   function toBoolean (S : String) return Boolean is
   begin
      if S = "true" or else S = "TRUE" then
         return True;
      elsif S = "false" or else S = "FALSE" then
         return False;
      else
         raise Constraint_Error with "Valor booleano inválido: " & S;
      end if;
   end toBoolean;

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

   procedure cargarTurnos (listaFinal : out listaT.TipoLista) is

      archivo  : File_Type;
      linea    : String (1 .. 250);
      longitud : Natural;
      type arregloStrings is array (1 .. 9) of Unbounded_String;
      arreglo  : arregloStrings;
      unTurno  : turno.TipoTurno;
      fecha    : calendar.Time;
   begin
      open (archivo, In_File, "turnos.txt");

      while not End_Of_File (archivo) loop
         -- recorro todo el archivo

         for j in 1 .. 9 loop
            -- leo 9 lineas que son las que contienen un turno completo
            Get_Line (archivo, linea, longitud);
            arreglo (j) := To_Unbounded_String (linea (1 .. longitud));
         end loop;

         -- genero la fecha
         fecha :=
           cargarFecha
             (integer'Value (To_String (arreglo (4))),
              integer'Value (To_String (arreglo (5))),
              integer'Value (To_String (arreglo (6))),
              integer'Value (To_String (arreglo (7))),
              integer'Value (To_String (arreglo (8))));

         -- creo el turno
         unTurno :=
           turno.Crear
             (fecha,
              To_String (arreglo (1)),
              integer'Value (to_string (arreglo (2))),
              integer'Value (to_string (arreglo (3))),
              To_String (arreglo (9)));
         -- guardo el turno en la lista
         listaT.Insertar (listaFinal, unTurno);
         if not End_Of_File (archivo) then
            Get_Line
              (archivo, linea, longitud);  -- linea vacia que separa turnos

         end if;
      end loop;
      close (archivo);
   end cargarTurnos;

   procedure cargarClientes (listaFinal : out listaC.TipoLista) is

      archivo   : File_Type;
      linea     : String (1 .. 40);
      longitud  : Natural;
      type arregloStrings is array (1 .. 5) of Unbounded_String;
      arreglo   : arregloStrings;
      uncliente : Clientes.Tipocliente;
   begin

      open (archivo, In_File, "clientes.txt");

      while not End_Of_File (archivo) loop
         -- recorro todo el archivo

         for j in 1 .. 5 loop
            -- leo 5 lineas que son las que contienen un cliente completo
            Get_Line (archivo, linea, longitud);
            arreglo (j) := To_Unbounded_String (linea (1 .. longitud));
         end loop;

         -- creo el cliente
         uncliente :=
           clientes.Crear
             (To_String (arreglo (1)), --nombre
              to_string (arreglo (2)), -- apellido
              integer'Value (to_string (arreglo (3))), -- dni
              To_String (arreglo (4)), --patente
              toBoolean (To_String (arreglo (5)))); --estado
         -- guardo el turno en la lista
         listaC.Insertar (listaFinal, uncliente);
         if not End_Of_File (archivo) then
            Get_Line
              (archivo, linea, longitud);  -- linea vacia que separa clientes

         end if;
      end loop;
      close (archivo);
   end cargarClientes;

   procedure cargarMecanicos (listaFinal : out listaM.TipoLista) is

      archivo    : File_Type;
      linea      : String (1 .. 40);
      longitud   : Natural;
      type arregloStrings is array (1 .. 5) of Unbounded_String;
      arreglo    : arregloStrings;
      unMecanico : Mecanico.Tipomecanico;

   begin

      open (archivo, In_File, "mecanicos.txt");

      while not End_Of_File (archivo) loop
         -- recorro todo el archivo

         for j in 1 .. 5 loop
            -- leo 5 lineas que son las que contienen un mecanico completo
            Get_Line (archivo, linea, longitud);
            arreglo (j) := To_Unbounded_String (linea (1 .. longitud));
         end loop;

         -- creo el mecanico
         unMecanico :=
           mecanico.Crearmecanico
             (To_String (arreglo (1)), --nombre
              to_string (arreglo (2)), -- apellido
              to_string (arreglo (3)), -- especialidad
              integer'Value (To_String (arreglo (4))), --dni
              toBoolean (To_String (arreglo (5)))); --estado
         -- guardo el mecanico en la lista
         listaM.Insertar (listaFinal, unMecanico);
         if not End_Of_File (archivo) then
            Get_Line
              (archivo, linea, longitud);  -- linea vacia que separa mecanicos

         end if;
      end loop;
      close (archivo);
   end cargarMecanicos;

   procedure cargarReparaciones (listaFinal : out listaR.TipoLista) is
      archivo       : File_Type;
      linea         : String (1 .. 100);  -- más largo por si acaso
      longitud      : Natural;
      type arregloStrings is array (1 .. 10) of Unbounded_String;
      arreglo       : arregloStrings;
      unaReparacion : Reparacion.TipoReparacion;
      fecha         : Calendar.Time;

      -- función para evitar errores por líneas vacías
      function Leer_Linea_Valida return Unbounded_String is
      begin
         loop
            exit when End_Of_File (archivo);
            Get_Line (archivo, linea, longitud);
            if longitud > 0 then
               return To_Unbounded_String (linea (1 .. longitud));
            end if;
            -- si es línea vacía, la ignora y sigue
         end loop;
         return To_Unbounded_String (""); -- nunca debería llegar
      end Leer_Linea_Valida;

   begin
      open (archivo, In_File, "reparaciones.txt");

      while not End_Of_File (archivo) loop
         for j in 1 .. 10 loop
            arreglo (j) := Leer_Linea_Valida;
         end loop;

         -- armar la fecha
         fecha :=
           cargarFecha
             (Integer'Value (To_String (arreglo (5))),
              Integer'Value (To_String (arreglo (6))),
              Integer'Value (To_String (arreglo (7))),
              12,
              00);

         -- crear la reparación
         Reparacion.AltaReparacion
           (unaReparacion,
            To_String (arreglo (1)),
            Integer'Value (To_String (arreglo (2))),
            To_String (arreglo (3)),
            To_String (arreglo (4)),
            fecha,
            Float'Value (To_String (arreglo (8))),
            Float'Value (To_String (arreglo (9))));

         -- insertar en la lista
         listaR.Insertar (listaFinal, unaReparacion);

         -- leer línea separadora
         if not End_Of_File (archivo) then
            Get_Line (archivo, linea, longitud);

         end if;
      end loop;

      close (archivo);
   end cargarReparaciones;

   --PROCEDIMIENTOS DE ESCRITURA DE ARCHIVOS

   function Sin_Espacio (n : Integer) return String is
   begin
      return Integer'Image (n) (2 .. Integer'Image (n)'Length);
   end Sin_Espacio;
   procedure guardarTurnos (listaFinal : in listaT.TipoLista) is
      ptr      : listaT.TipoLista := listaFinal;
      archivo  : File_Type;
      turnoAux : turno.TipoTurno;
      fecha    : Calendar.Time;
      anio     : Calendar.Year_Number;
      mes      : Calendar.Month_Number;
      dia      : Calendar.Day_Number;
      segundos : Calendar.Day_Duration;
      horas    : Integer;
      minutos  : Integer;
   begin
      open (archivo, Out_File, "turnos.txt");

      while not listaT.Vacia (ptr) loop
         turnoAux := listaT.Info (ptr);

         Put_Line (archivo, turno.getPatente (turnoAux));  --escribo la patente
         Put_Line (archivo, Sin_Espacio (turno.getCliente (turnoAux)));
         Put_Line (archivo, Sin_Espacio (turno.getMecanico (turnoAux)));
         -- separo la fecha por campos
         fecha := turno.getFecha (turnoAux);
         Calendar.Split (fecha, anio, mes, dia, segundos);
         horas := Integer (segundos) / 3600;
         minutos := (Integer (segundos) mod 3600) / 60;

         --escribo la fecha
         Put_Line (archivo, Sin_Espacio (dia));
         Put_Line (archivo, Sin_Espacio (mes));
         Put_Line (archivo, Sin_Espacio (anio));
         Put_Line (archivo, Sin_Espacio (horas));
         Put_Line (archivo, Sin_Espacio (minutos));
         Put_Line (archivo, turno.getMotivo (turnoAux)); -- escribo el motivo

         New_Line (archivo);  -- separa los turnos con un espacio

         ptr :=
           listaT.Sig (ptr); --muevo el puntero para buscar el siguiente turno
      end loop;
      close (archivo);

   end guardarTurnos;

   procedure guardarClientes (listaFinal : in listaC.TipoLista) is
      ptr        : listaC.TipoLista := listaFinal;
      archivo    : File_Type;
      clienteAux : clientes.TipoCliente;

      -- función auxiliar para sacar espacios
      function Trim (S : String) return String is

      begin
         return ada.Strings.Fixed.Trim (S, Ada.Strings.Both);
      end Trim;

   begin
      open (archivo, Out_File, "clientes.txt");

      while not listaC.Vacia (ptr) loop
         clienteAux := listaC.Info (ptr);

         Put_Line (archivo, Trim (clientes.getnombre (clienteAux)));
         Put_Line (archivo, Trim (clientes.getapellido (clienteAux)));
         Put_Line
           (archivo,
            Integer'Image
              (clientes.getdni (clienteAux))); -- sin Sin_Espacio, mejor esto
         Put_Line (archivo, Trim (clientes.getpatente (clienteAux)));

         if clientes.getestado (clienteAux) then
            Put_Line (archivo, "TRUE");
         else
            Put_Line (archivo, "FALSE");
         end if;

         New_Line (archivo);  -- línea en blanco entre clientes
         ptr := listaC.Sig (ptr);
      end loop;

      close (archivo);
   end guardarClientes;

   procedure guardarMecanicos (listafinal : in listaM.TipoLista) is
      ptr         : listaM.TipoLista := listaFinal;
      archivo     : File_Type;
      mecanicoAux : mecanico.Tipomecanico;
   begin
      open (archivo, Out_File, "mecanicos.txt");
      while not listaM.Vacia (ptr) loop
         mecanicoAux := listaM.Info (ptr);
         Put_Line (archivo, Mecanico.Obtenernombre (mecanicoAux));
         Put_Line (archivo, mecanico.Obtenerapellido (mecanicoAux));
         Put_Line (archivo, mecanico.Obtenerespecialidad (mecanicoAux));
         Put_Line (archivo, Sin_Espacio (mecanico.Obtenerdni (mecanicoAux)));
         if mecanico.obtenerEstado (mecanicoAux) then
            Put_Line (archivo, "TRUE");
         else
            Put_Line (archivo, "FALSE");
         end if;
         New_Line (archivo);  -- separa los mecanicos con un espacio
         ptr := listaM.Sig (ptr);
      end loop;
      close (archivo);
   end guardarMecanicos;

   procedure guardarReparaciones (listaFinal : in listaR.TipoLista) is
      ptr           : listaR.TipoLista := listaFinal;
      archivo       : File_Type;
      reparacionAux : reparacion.TipoReparacion;
      fecha         : Calendar.Time;
      anio          : Calendar.Year_Number;
      mes           : Calendar.Month_Number;
      dia           : Calendar.Day_Number;
      segundos      : Calendar.Day_Duration;
      horas         : Integer;
      minutos       : Integer;
   begin
      open (archivo, Out_File, "reparaciones.txt");
      while not listaR.Vacia (ptr) loop

         reparacionAux := data.listaR.Info (ptr);
         Put_Line (archivo, Reparacion.getPatente (reparacionAux));
         Put_Line
           (archivo, Sin_Espacio (reparacion.getDniMecanico (reparacionAux)));
         Put_Line (archivo, Reparacion.getCosasReparadas (reparacionAux));
         Put_Line (archivo, Reparacion.getPartesReemp (reparacionAux));
         fecha := Reparacion.getFecha (reparacionAux);
         Calendar.Split (fecha, anio, mes, dia, segundos);
         horas := Integer (segundos) / 3600;
         minutos := (Integer (segundos) mod 3600) / 60;

         --escribo la fecha
         Put_Line (archivo, Sin_Espacio (dia));
         Put_Line (archivo, Sin_Espacio (mes));
         Put_Line (archivo, Sin_Espacio (anio));
         ada.Float_Text_IO.Put
           (archivo,
            reparacion.getHoras (reparacionAux),
            Fore => 1,
            Aft  => 2,
            Exp  => 0);
         New_Line (archivo);
         ada.Float_Text_IO.Put
           (archivo,
            reparacion.getPrecio (reparacionAux),
            Fore => 1,
            Aft  => 2,
            Exp  => 0);
         New_Line (archivo);
         ptr := listaR.Sig (ptr);
         if reparacion.getEstado (reparacionAux) then
            Put_Line (archivo, "TRUE");
         else
            Put_Line (archivo, "FALSE");
         end if;
         New_Line (archivo);  -- separa las reparaciones con un espacio
      end loop;
      close (archivo);
   end guardarReparaciones;

end data;
