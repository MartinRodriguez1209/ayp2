with ada.Text_IO;                   use ada.Text_IO;
with ada.Strings.Unbounded;         use ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Calendar;
with turno;
with Clientes;
with Mecanico;
with Reparacion;

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
   end cargarMecanicos;

   procedure cargarReparaciones (listaFinal : out listaR.TipoLista) is
      archivo       : File_Type;
      linea         : String (1 .. 50);
      longitud      : Natural;
      type arregloStrings is array (1 .. 10) of Unbounded_String;
      arreglo       : arregloStrings;
      unaReparacion : Reparacion.TipoReparacion;
      fecha         : Calendar.Time;
   begin
      open (archivo, In_File, "reparaciones.txt");

      while not End_Of_File (archivo) loop
         -- recorro todo el archivo

         for j in 1 .. 10 loop
            -- leo 10 lineas que son las que contienen una reparacion completa
            Get_Line (archivo, linea, longitud);
            arreglo (j) := To_Unbounded_String (linea (1 .. longitud));
         end loop;

         fecha :=
           cargarFecha
             (integer'Value (To_String (arreglo (5))),
              integer'Value (To_String (arreglo (6))),
              integer'Value (To_String (arreglo (7))),
              12,
              00);
         -- creo la reparacion
         Reparacion.Altareparacion
           (unaReparacion,
            To_String (arreglo (1)), -- patente
            integer'value (to_string (arreglo (2))), -- dni mecanico
            to_string (arreglo (3)), -- cosas reparadas
            To_String (arreglo (4)), -- partes reemplazadas
            fecha,
            float'value (To_String (arreglo (8))),
            float'value (To_String (arreglo (9))));
         -- guardo la reparacion en la lista
         listaR.Insertar (listaFinal, unaReparacion);
         if not End_Of_File (archivo) then
            Get_Line
              (archivo,
               linea,
               longitud);  -- linea vacia que separa reparaciones

         end if;
      end loop;
   end cargarReparaciones;

end data;
