with Ada.Integer_Text_Io,
     Ada.Text_Io,
     Clientes,
     reparacion,
     turno,
     mecanico,
     cola,
     lista,
     Ada.Strings.Fixed;
use Ada.Integer_Text_Io, Ada.Text_Io, turno, mecanico, Ada.Strings.Fixed;
with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
use Clientes;
with Ada.Calendar;          use Ada.Calendar;

--with data; use data;

procedure Menu is

   --Rta: Character;
   --mecanicos: mecanico.tipomecanico; --un solo mecanico en particular
   subtype CadenaClave is
     String (1 .. 10); -- es la clave para buscar la patente de reparaciones
   package lista_turnos is new
     lista (turno.TipoTurno, Integer, turno.compararDniCliente);

   package Lista_Mec is new
     lista (Mecanico.Tipomecanico, Integer, Mecanico.Comparardnimecanico);
   --lista de mecanicos

   package Listaclientes is new
     lista (Clientes.Tipocliente, integer, clientes.compararCliente);
   package lista_reparacion is new
     lista
       (Reparacion.TipoReparacion,
        CadenaClave,
        Reparacion.BuscarReparacion);
   --package listarepara is new lista();

   Lista_Mecanicos : Lista_Mec.Tipolista;
   Lista_Clientes  : Listaclientes.Tipolista;
   Listaturnos     : Lista_Turnos.Tipolista;
   listareparacion : lista_reparacion.TipoLista;

   package instanciaData is new
     data
       (Reparacion.ClaveCadena,
        listaC => Listaclientes,
        listaT => Lista_Turnos,
        listaR => lista_reparacion,
        listaM => Lista_Mec);

   procedure cargarListas
     (Lista_Mecanicos : in out Lista_Mec.TipoLista;
      Lista_Clientes  : in out Listaclientes.TipoLista;
      Listaturnos     : in out lista_turnos.TipoLista;
      listareparacion : in out lista_reparacion.TipoLista) is
   begin
      instanciaData.cargarClientes (Lista_Clientes);
      instanciaData.cargarMecanicos (Lista_Mecanicos);
      instanciaData.cargarReparaciones (listareparacion);
      instanciaData.cargarTurnos (listaTurnos);
   end;

   procedure guardarListas
     (Lista_Mecanicos : in out Lista_Mec.TipoLista;
      Lista_Clientes  : in out Listaclientes.TipoLista;
      Listaturnos     : in out lista_turnos.TipoLista;
      listareparacion : in out lista_reparacion.TipoLista) is
   begin
      instanciaData.guardarClientes (Lista_Clientes);
      instanciaData.guardarMecanicos (Lista_Mecanicos);
      instanciaData.guardarReparaciones (listareparacion);
      instanciaData.guardarTurnos (listaTurnos);
   end;

   Opciones : Natural;

   --procedure cargarData is

   --begin

   -- data.cargarClientes (Lista_Clientes);
   -- data.cargarMecanicos (Lista_Mecanicos);
   --data.cargarReparaciones (listaReparaciones);
   --data.cargarTurnos (Listaturnos);

   --end cargarData;

   function Cargarfecha

      (dia     : in Integer;
       mes     : in Integer;
       anio    : in integer;
       hora    : in Integer;
       Minutos : in Integer) return ada.Calendar.Time
   is
      Segundos : ada.Calendar.Day_Duration;
   begin
      Segundos := ada.Calendar.Day_Duration ((Hora * 3600) + (Minutos * 60));
      return ada.Calendar.Time_Of (Anio, Mes, Dia, Segundos);
   end Cargarfecha;

   procedure Split
     (Date    : Time;
      Year    : out Year_Number;
      Month   : out Month_Number;
      Day     : out Day_Number;
      Seconds : out Day_Duration)
   is

      H  : Integer;
      M  : Integer;
      Se : Integer;
      Ss : Duration;
      Le : Boolean;

      pragma Unreferenced (H, M, Se, Ss, Le);

   begin
      --  Even though the input time zone is UTC (0), the flag Use_TZ will
      --  ensure that Split picks up the local time zone.

      Ada.Calendar.Split (Date, Year, Month, Day, Seconds);

   end Split;

   --------------PROCEDIMIENTOS-PARA-PROGRAMA-PRINCIPAL----------------------
   -----------------------------------------------------------------------------------------------------------
   procedure General_Mecanicos (lismecanico : in out lista_mec.tipolista) is

      Lis   : Integer;
      N_Mec : Mecanico.Tipomecanico;

      -----------------------------------------------------------
      procedure Alta_Mecanicos (X : out mecanico.Tipomecanico) is

         Nomb, Apellid, Especialida : String (1 .. 50);
         auxnom, auxap, auxesp      : string (1 .. 50);
         Dni                        : Natural;
         Lnnm, Lnap, Lnesp          : Natural;
         estado                     : boolean;
      begin

         Put ("ingrese el nombre del nuevo mecanico: ");
         Get_Line (Auxnom, Lnnm);
         Nomb := (others => ' ');
         Nomb (1 .. lnnm) := Auxnom (1 .. lnnm);
         New_Line;
         Put ("ingrese el apellido del nuevo mecanico: ");
         Get_Line (Auxap, Lnap);
         Apellid := (others => ' ');
         Apellid (1 .. lnap) := auxap (1 .. lnap);
         New_Line;
         Put ("ingrese el dni del nuevo mecanico: ");
         Get (Dni);
         skip_line;
         New_Line;
         Put ("ingrese la especialidad del nuevo mecanico: ");
         Get_Line (Auxesp, Lnesp);
         Especialida := (others => ' ');
         Especialida (1 .. Lnesp) := Auxesp (1 .. Lnesp);
         estado := true;
         New_Line;
         X := Crearmecanico (Nomb, Apellid, Especialida, Dni, estado);
         New_Line;

         put ("Nuevo mecanico ingresado");
         new_line;
         new_line;

      end Alta_Mecanicos;

      ---------------------------------------------------------------------
      procedure Baja_Mecanicos (lismecanico : in out lista_mec.tipolista) is
         Auxdni   : Natural;
         Auxlista : Lista_Mec.Tipolista := lismecanico;
         Auxmeca  : Mecanico.Tipomecanico;

      begin

         Put ("ingrese el dni del mecanico a dar de baja: ");
         get (Auxdni);

         while not lista_mec.Vacia (Auxlista) loop

            Auxmeca := lista_mec.Info (Auxlista);

            if Auxdni = Obtenerdni (Auxmeca) then

               Lista_Mec.Suprimir (Lismecanico, Lista_Mec.Info (Auxlista));

               Mecanico.Bajamecanico (Auxmeca);

               Lista_Mec.Insertar (Lismecanico, Auxmeca);

               exit;

            end if;
            Auxlista := lista_mec.sig (Auxlista);
         end loop;

      end Baja_Mecanicos;

      procedure Listado_Mecanicos (lismecanico : in lista_mec.tipolista) is

         lis : integer;

         --PROCEDIMIENTO-PARA-LISTADO-MECANICO-GENERAL--
         procedure Mecanico_General (x : in lista_mec.tipolista) is

            auxlista : lista_mec.tipolista := x;
            Aux      : Mecanico.Tipomecanico;

            --nom,ape,esp: string(1..50);
         begin

            while not Lista_Mec.Vacia (Auxlista) loop

               Aux := Lista_Mec.Info (Auxlista);

               if Mecanico.Obtenerestado (Aux) then

                  Put ("nombre: ");
                  Put (Trim (ObtenerNombre (aux), Both));
                  new_line;

                  Put ("apellido: ");
                  Put (Trim (ObtenerApellido (aux), Both));
                  New_Line;

                  Put ("dni: ");
                  Put (Obtenerdni (Aux));
                  New_Line;

                  Put ("especialidad: ");
                  Put (Trim (Obtenerespecialidad (Aux), Both));
                  New_Line;

                  Put ("");
                  New_Line;

               end if;

               Auxlista := Lista_Mec.Sig (Auxlista);

            end loop; --fin recorrido lista
         end Mecanico_General;

         --PROCEDIMIENTO-PARA-LISTADO-MECANICO-ESPECIFO--
         procedure Mecanico_especifico (x : in lista_mec.tipolista) is

            auxlista                    : lista_mec.tipolista := x;
            Aux                         : Mecanico.Tipomecanico;
            mensaje                     : String (1 .. 100);
            Ln_Esp                      : Natural;
            Cont                        : Integer := 0;
            Especialidad_Real_Unbounded : Unbounded_String;

         begin
            Skip_Line;

            Put
              ("Ingrese el tipo de especializacion que usted quiere del mecanico: ");
            Get_Line (mensaje, Ln_Esp);

            declare
               Entrada_Limpia : constant String :=
                 Trim (mensaje (1 .. Ln_Esp), Both);
            begin
               Especialidad_Real_Unbounded :=
                 To_Unbounded_String (Entrada_Limpia);

               while not Lista_Mec.Vacia (Auxlista) loop
                  Aux := Lista_Mec.Info (Auxlista);

                  if Mecanico.Obtenerestado (Aux) then

                     declare
                        Especialidad_Mec           : constant String :=
                          Trim (ObtenerEspecialidad (Aux), Both);
                        Especialidad_Mec_Unbounded : Unbounded_String :=
                          To_Unbounded_String (Especialidad_Mec);
                     begin
                        if Especialidad_Real_Unbounded
                          = Especialidad_Mec_Unbounded
                        then
                           New_Line;
                           Put ("nombre: ");
                           Put (Trim (ObtenerNombre (Aux), Both));
                           New_Line;
                           Put ("apellido: ");
                           Put (Trim (ObtenerApellido (Aux), Both));
                           New_Line;
                           Put ("dni: ");
                           Put (ObtenerDni (Aux));
                           New_Line;
                           Put ("especialidad: ");
                           Put (Especialidad_Mec);
                           New_Line;
                           Put ("");
                           New_Line;
                           Cont := Cont + 1;
                        end if;
                     end;

                  end if;

                  Auxlista := Lista_Mec.Sig (Auxlista);
               end loop;

               if Cont = 0 then
                  Put ("El tipo de especialidad que mencionas no existe");
                  New_Line;
               end if;
            end;
         end Mecanico_Especifico;

         ------------------------------------------------------------------
      begin
         --Inicio de programa Listado_Mecanicos

         Put ("bienvenido a la seleccion de mecanicos");
         New_Line;
         Put
           ("Si desea tener un listado general de los mecanicos del taller, presione 1");
         new_line;
         put
           ("Si desea conocer un listado de mecanicos por especialidad, presione 2");
         New_Line;
         put ("Si desea volver al menu anterior, presione 0");
         New_Line;

         get (lis);
         case Lis is
            when 0 =>
               return;

            when 1 =>
               Mecanico_General (lismecanico);

            when 2 =>
               Mecanico_especifico (lismecanico);

            when others =>
               put ("numero equivocado");
         end case;

      end Listado_Mecanicos;

      -------------------------------------------------------------------------------------------------
   begin
      --comienza el procedimiento General_Mecanicos

      Put ("Has ingresado a la gestion de clientes del taller");
      New_Line;
      Put ("para ingresar un nuevo mecanico al sistema, ingrese el boton 1");
      New_Line;
      Put ("para bajar a un mecanico del sistema, ingrese el boton 2");
      New_Line;
      Put
        ("para ingresar al listado de mecanicos en el sistema, ingrese el boton 3");
      New_Line;
      Put ("para regresar al menu principal, ingrese el boton 0");
      New_Line;

      Get (Lis);
      Skip_Line;

      case Lis is

         when 0 =>
            return;

         when 1 =>
            Alta_Mecanicos (N_Mec);
            Lista_Mec.Insertar (Lismecanico, N_Mec);

         when 2 =>
            Baja_Mecanicos (lismecanico);

         when 3 =>
            Listado_Mecanicos (lismecanico);

         when others =>
            Put ("ingreso incorrecto");
      end case;

   end General_Mecanicos;

   -----------------------------------------------------------------------------
   ---------MENU-DE-CLIENTES----------------------------------------------------

   procedure Clientes_General (liscliente : in out Listaclientes.Tipolista) is

      Opcion_Cl : Natural;
      R_cl      : clientes.tipocliente;

      procedure Alta_Cliente (X : out clientes.tipocliente) is

         Nombre_Cl, Apellido_Cl : String (1 .. 50);
         Patente                : String (1 .. 10);
         Auxnom, Auxap          : String (1 .. 50);
         auxpat                 : String (1 .. 10);
         Dni                    : Natural;
         Lnnm, Lnap, Lnpat      : Natural;
         --estado: boolean;

      begin
         Put ("ingrese el nombre del nuevo cliente a ingresar: ");
         Get_Line (Auxnom, Lnnm);
         Nombre_Cl := (others => ' ');
         Nombre_Cl (1 .. lnnm) := Auxnom (1 .. lnnm);
         New_Line;
         Put ("ingrese el apellido del nuevo cliente: ");
         Get_Line (Auxap, Lnap);
         Apellido_Cl := (others => ' ');
         Apellido_Cl (1 .. lnap) := auxap (1 .. lnap);
         New_Line;
         Put ("ingrese el dni del nuevo cliente: ");
         Get (Dni);
         skip_line;
         New_Line;
         Put ("ingrese la patente del vehiculo del nuevo cliente: ");
         Get_Line (Auxpat, Lnpat);
         Patente := (others => ' ');
         Patente (1 .. Lnpat) := Auxpat (1 .. Lnpat);
         put ("nuevo cliente creado");
         New_Line;

         X := clientes.crear (Nombre_Cl, Apellido_Cl, Dni, Patente);
         New_Line;

      end Alta_Cliente;

      ----------------------------------------------------------------------
      procedure Baja_cliente (lista : in out Listaclientes.Tipolista) is
         Auxdni   : Natural;
         Auxlista : Listaclientes.Tipolista := lista;
         Auxcl    : clientes.tipocliente;

      begin

         Put ("ingrese el dni del cliente a dar de baja: ");
         get (Auxdni);

         while not Listaclientes.Vacia (Auxlista) loop

            Auxcl := Listaclientes.Info (Auxlista);

            if clientes.getestado (auxcl)
              and then Auxdni = Clientes.Getdni (Auxcl)
            then

               auxcl := Clientes.cambioestado (auxcl);
               Listaclientes.Suprimir (lista, Listaclientes.Info (Auxlista));
               Listaclientes.Insertar (lista, Auxcl);
               Put ("cliente dado de baja");
               new_line;

               exit;
            end if;

            Auxlista := Listaclientes.sig (Auxlista);
         end loop;

      end Baja_cliente;

      procedure Modificar_Cliente (lista : in out Listaclientes.Tipolista) is

         Opc      : Natural;
         Auxdni   : Natural;
         Auxlista : Listaclientes.Tipolista := Lista;
         Auxcl    : Clientes.Tipocliente;

         procedure N_Nombre (client : out Clientes.Tipocliente) is
            Nom, auxnm : String (1 .. 40);
            Ln_Nm      : Natural;
         begin
            Put ("ingrese un nuevo nombre: ");
            Get_Line (Auxnm, Ln_Nm);
            Nom := (others => ' ');
            Nom (1 .. Ln_Nm) := Auxnm (1 .. Ln_Nm);
            client := Clientes.Cambiarnombre (Auxcl, Nom);
         end N_Nombre;
         ---------
         procedure N_Apellido (Client : out Clientes.Tipocliente) is
            Ape, Auxap : String (1 .. 25);
            Ln_Ap      : Natural;
         begin
            Put ("ingrese un nuevo apellido: ");
            Get_Line (Auxap, Ln_Ap);
            Ape := (others => ' ');
            Ape (1 .. Ln_Ap) := Auxap (1 .. Ln_Ap);
            client := Clientes.Cambiarapellido (Auxcl, Ape);
         end N_Apellido;
         ---------
         procedure N_dni (Client : out Clientes.Tipocliente) is
            dni_cl : Natural;
         begin
            Put ("ingrese un nuevo dni: ");
            Get (Dni_Cl);
            Skip_Line;
            Client := Clientes.Cambiardni (Auxcl, Dni_Cl);
         end N_dni;
         ---------
         procedure N_Patente (Client : out Clientes.Tipocliente) is
            Pat, Auxp : String (1 .. 10);
            Ln_P      : Natural;

         begin
            Put ("ingrese una nueva patente: ");
            Get_Line (Auxp, Ln_P);
            Pat := (others => ' ');
            Pat (1 .. Ln_P) := Auxp (1 .. Ln_P);
            Client := Clientes.Cambiarpatente (Auxcl, Pat);

         end N_Patente;

      begin
         Put ("ingrese el dni del cliente a modificar: ");
         get (auxdni);
         Skip_Line;
         New_Line;
         while not Listaclientes.Vacia (Auxlista) loop
            auxcl := Listaclientes.info (auxlista);
            if Getestado (Auxcl) then
               if Auxdni = Clientes.Getdni (Auxcl) then

                  Put
                    ("Cliente encontrado, que dato de este desea modificar?");
                  New_Line;
                  Put ("Para cambiar nombre, pulse tecla 1");
                  New_Line;
                  Put ("Para cambiar apellido, pulse tecla 2");
                  New_Line;
                  Put ("Para cambiar dni, pulse tecla 3");
                  New_Line;
                  Put ("Para cambiar patente del vehiculo, pulse tecla 4");
                  New_Line;
                  Put ("pulse 0 para salir");
                  new_line;
                  Get (opc);
                  skip_line;

                  case Opc is
                     when 0 =>
                        Put ("ha salido de las opciones");
                        new_line;
                        exit;

                     when 1 =>
                        N_Nombre (auxcl);

                     when 2 =>
                        N_Apellido (auxcl);

                     when 3 =>
                        N_dni (auxcl);

                     when 4 =>
                        N_Patente (auxcl);

                     when others =>
                        put ("numero incorrecto, revise nuevamente el texto");
                  end case;

                  Listaclientes.Suprimir
                    (Lista, Listaclientes.Info (Auxlista));
                  Listaclientes.Insertar (Lista, Auxcl);

               end if;
            end if;
            auxlista := listaclientes.sig (auxlista);
         end loop;

      end Modificar_Cliente;

      ------------------------------------------------------------
      procedure Listado_Clientes (x : in listaclientes.tipolista) is

         auxlista : listaclientes.tipolista := x;
         Aux      : clientes.tipocliente;

      begin

         while not listaclientes.Vacia (Auxlista) loop

            Aux := listaclientes.Info (Auxlista);

            if clientes.getestado (Aux) then

               Put ("nombre: ");
               Put (Trim (getnombre (aux), Both));
               new_line;

               Put ("apellido: ");
               Put (Trim (getapellido (aux), Both));
               New_Line;

               Put ("dni: ");
               Put (getdni (Aux));
               New_Line;

               Put ("patente: ");
               Put (Trim (getpatente (Aux), Both));
               New_Line;

               Put ("");
               New_Line;

            end if;
            Auxlista := listaclientes.Sig (Auxlista);
         end loop; --fin recorrido lista
      end Listado_Clientes;

      --------------------------------------------------------------------------
   begin

      Put ("Has ingresado a la gestion de clientes del taller");
      New_Line;
      Put ("para ingresar un nuevo cliente al sistema, ingrese el boton 1");
      New_Line;
      Put ("para bajar a un cliente del sistema, ingrese el boton 2");
      New_Line;
      Put ("para modificar algo de un cliente, ingrese el boton 3");
      New_Line;
      Put
        ("para ingresar al listado de clientes en el sistema, ingrese el boton 4");
      New_Line;
      Put ("para volver al menu principal, ingrese el boton 0");
      New_Line;
      Get (Opcion_Cl);
      skip_line;

      case Opcion_Cl is

         when 0 =>
            return;

         when 1 =>
            Alta_Cliente (R_cl);
            listaclientes.insertar (liscliente, r_cl);

         when 2 =>
            Baja_Cliente (Liscliente);

         when 3 =>
            Modificar_Cliente (Liscliente);

         when 4 =>
            Listado_Clientes (Liscliente);

         when others =>
            Put ("ingreso incorrecto");
            new_line;

      end case;

   end Clientes_General;

   -------------------------------------------------------------------------------
   -------------------------------------------------------------------------------
   procedure Turnos_General (Listurno : in out Lista_Turnos.Tipolista) is

      Opcion : Natural;

      procedure Alta_Turno (Lturno : out Lista_Turnos.Tipolista) is

         Fecha                     : ada.Calendar.Time;
         Aux                       : Turno.Tipoturno;
         Dia, Mes, Anio, Hora, Min : Integer;
         Pat, Auxp                 : String (1 .. 7);
         Ln_P, Ln_Mtv              : Natural;
         Dni_Cl, Dni_Mec           : Natural;
         Motivo, Auxmot            : String (1 .. 150);

         procedure Verif (Num : in out Integer; Valorin, Valorfin : in Integer)
         is
         begin
            while Num < Valorin or Num > Valorfin loop
               Put ("ingrese el dato en el rango correcto: ");
               Get (Num);
            end loop;
         end Verif;

      begin
         Put ("ingrese el dia del turno (del 1 al 31): ");
         Get (Dia);
         Verif (dia, 1, 31);
         skip_line;
         New_Line;
         Put ("ingrese la hora del turno: ");
         Get (Hora);
         Verif (hora, 1, 24);
         New_Line;
         Put ("ingrese el minuto del turno: ");
         Get (Min);
         Verif (min, 1, 60);
         New_Line;
         Put ("ingrese el mes del turno: ");
         Get (Mes);
         Verif (mes, 1, 12);
         New_Line;
         Put ("ingrese el anio del turno: ");
         Get (Anio);
         --Verif(dia,1000,9999);
         New_Line;
         Fecha := Cargarfecha (Dia, Mes, Anio, Hora, Min);
         skip_line;

         Put ("ingrese la patente del cliente: ");
         Get_Line (Auxp, Ln_P);
         Pat := (others => ' ');
         Pat (1 .. Ln_P) := Auxp (1 .. Ln_P);
         Put ("ingrese el dni del cliente: ");
         Get (dni_cl);
         New_Line;
         Put ("ingrese el dni del mecanico: ");
         Get (dni_mec);
         New_Line;
         skip_line;
         Put ("ingrese el motivo: ");
         Get_Line (auxmot, Ln_mtv);
         motivo := (others => ' ');
         Motivo (1 .. Ln_Mtv) := Auxmot (1 .. Ln_Mtv);
         aux := turno.crear (fecha, Pat, dni_cl, dni_mec, motivo);
         Lista_Turnos.insertar (lturno, aux);
      end Alta_Turno;

      --------------------------------------------------------------
      procedure Baja_Turno (Lturno : in out Lista_Turnos.Tipolista) is

         dni      : Natural;
         auxturno : turno.TipoTurno;
         Auxlista : Lista_Turnos.Tipolista := Lturno;

      begin

         Put
           ("Para dar de baja un turno, por favor, ingrese los siguientes datos:");
         New_Line;
         Put ("Ingrese el DNI del cliente asociado al turno: ");
         Get (Dni);
         Skip_Line;

         while not Lista_Turnos.Vacia (Auxlista) loop
            Auxturno := Lista_Turnos.Info (Auxlista);

            if Turno.Getcliente (Auxturno) = Dni then

               Lista_Turnos.Suprimir (Lturno, Auxturno);
               Put ("Turno eliminado");
               New_Line;

               exit;

            end if;

         end loop;

      end Baja_Turno;

      -------------------------------------------------------------------------------
      procedure Modificar_Turno (Lturno : in out Lista_Turnos.Tipolista) is
         Dni      : Natural;
         Auxlista : Lista_Turnos.Tipolista := Lturno;
         Auxturno : Turno.Tipoturno;
         opc      : natural;

         procedure N_mec (client : in out turno.TipoTurno) is
            dninuevo : Natural;
         begin
            Put ("ingrese el nuevo dni del nuevo mecanico: ");
            Get (dninuevo);
            Skip_Line;
            Client := turno.cambiarMecanico (client, dninuevo);
         end N_mec;
         ---------
         procedure N_fecha (Client : in out turno.TipoTurno) is
            Min, Hora, Dia, Mes, Anio : Integer;
            Nuevafecha                : ada.Calendar.Time;

         begin
            Put ("ingrese un nuevo minuto: ");
            Get (min);
            New_Line;
            Put ("ingrese una nueva hora: ");
            Get (hora);
            New_Line;
            Put ("ingrese un nuevo dia: ");
            Get (dia);
            New_Line;
            Put ("ingrese un nuevo mes: ");
            Get (mes);
            New_Line;
            Put ("ingrese un nuevo anio: ");
            Get (anio);
            New_Line;
            Nuevafecha := Cargarfecha (Dia, Mes, Anio, Hora, Min);
            Client := cambiarFecha (Client, Nuevafecha);
         end N_fecha;
         ---------
         procedure N_motivo (Client : in out turno.TipoTurno) is
            motivo, Auxmot : String (1 .. 250);
            Ln_mtv         : Natural;

         begin
            Put ("ingrese un nuevo motivo: ");
            Get_Line (Auxmot, Ln_mtv);
            motivo := (others => ' ');
            motivo (1 .. Ln_mtv) := Auxmot (1 .. Ln_mtv);
            Client := turno.cambiarMotivo (client, motivo);

         end N_motivo;

         procedure N_patente (Client : in out turno.TipoTurno) is
            patente, Auxpat : String (1 .. 7);
            Ln_pat          : Natural;

         begin
            Put ("ingrese un nuevo motivo: ");
            Get_Line (Auxpat, Ln_pat);
            patente := (others => ' ');
            patente (1 .. Ln_pat) := Auxpat (1 .. Ln_pat);
            Client := turno.cambiarMotivo (client, patente);

         end N_patente;

      begin

         Put ("ingrese el dni del cliente a modificar: ");
         Get (Dni);

         while not Lista_Turnos.Vacia (Auxlista) loop
            Auxturno := Lista_Turnos.Info (Auxlista);

            if Getcliente (Auxturno) = Dni then

               Put ("cliente encontrado, elija que parte desea modificar");
               Put ("Para cambiar mecanico, pulse tecla 1");
               New_Line;
               Put ("Para cambiar la fecha, pulse tecla 2");
               New_Line;
               Put ("Para cambiar el motivo, pulse tecla 3");
               New_Line;
               --put("Para modificar el motivo, pulse tecla 5");
               Put ("pulse 0 para salir al menu principal");
               New_Line;
               Get (Opc);
               Skip_Line;

               case Opc is
                  when 0 =>
                     Put ("ha salido de las opciones");
                     new_line;
                     exit;

                  when 1 =>
                     N_mec (auxturno); --hecho

                  when 2 =>
                     N_fecha (auxturno); --hecho

                  when 3 =>
                     N_motivo (auxturno); --hecho

                  when 4 =>
                     N_Patente (auxturno); --hecho

                  when others =>
                     put ("numero incorrecto, revise nuevamente el texto");
               end case;
               Lista_Turnos.Suprimir (Lturno, Lista_Turnos.Info (Auxlista));
               Lista_Turnos.Insertar (Lturno, Auxturno);
            end if;

         end loop;

      end Modificar_Turno;
      -----------------------------------------------------------------------

      procedure Listar_Turnos
        (Lturno      : in Lista_Turnos.Tipolista;
         Liscliente  : in Listaclientes.Tipolista;
         Lismecanico : in Lista_Mec.Tipolista)
      is
         Auxlista   : Lista_Turnos.Tipolista := Lturno;
         Turnoaux   : Turno.Tipoturno;
         --Dia, Mes, Anio, Hora, Min : Integer;      
         Fechaturno : Ada.Calendar.Time;
         Fechastr   : String (1 .. 25);

         function Obtenernombrecliente
           (Dni : Natural; Lista : in Listaclientes.Tipolista) return String
         is

            Auxclilista : Listaclientes.Tipolista := Lista;
            Cli         : Clientes.Tipocliente;

         begin
            while not Listaclientes.Vacia (Auxclilista) loop
               Cli := Listaclientes.Info (Auxclilista);
               if Clientes.Getdni (Cli) = Dni then
                  return
                    Clientes.Getnombre (Cli)
                    & " "
                    & Clientes.Getapellido (Cli);
               end if;
               Auxclilista := Listaclientes.Sig (Auxclilista);
            end loop;
            return "No encontrado";
         end Obtenernombrecliente;

         function ObtenerNombreMecanico
           (Dni : Natural; Lista : in Lista_Mec.Tipolista) return String
         is
            Auxmeclista : Lista_Mec.Tipolista := Lista;
            Mec         : Mecanico.Tipomecanico;
         begin
            while not Lista_Mec.Vacia (Auxmeclista) loop
               Mec := Lista_Mec.Info (Auxmeclista);
               if Mecanico.Obtenerdni (Mec) = Dni then
                  return
                    Trim (Mecanico.Obtenernombre (Mec), Ada.Strings.Left)
                    & " "
                    & Ada.Strings.Fixed.Trim
                        (Mecanico.Obtenerapellido (Mec), Ada.Strings.Left);
               --exit;

               end if;
               Auxmeclista := Lista_Mec.Sig (Auxmeclista);
            end loop;
            return "Mecanico No Encontrado";
         end Obtenernombremecanico;

         function Mostrar_Fecha (Fecha : ada.Calendar.Time) return String is

            Dia, Mes, Anio : Integer;
            --Hora, Min: Integer;
            Seg            : Duration;

            M_Fecha : String (1 .. 25);
            --Min_Img : String (1..2);
         begin

            split (Fecha, Anio, Mes, Dia, seg);

            --Ada.Calendar.Split(
            --Fecha,
            --Year => Anio,
            --Month => Mes,
            --Day => Dia,
            --Hour => Hora,
            --Minute => Min,
            --Seconds => Seg);

            M_Fecha :=
              To_Unbounded_String
                (Integer'Image (Dia)
                 & "/"
                 & Integer'Image (mes)
                 & "/"
                 & Integer'Image (anio));

            --M_Fecha(1..f_str'Length) := f_str;

            return to_string (M_Fecha);

         end Mostrar_Fecha;
         -----------------------------------------
      begin

         Put ("listado de turnos");

         while not lista_turnos.vacia (Auxlista) loop

            Turnoaux := Lista_Turnos.Info (Auxlista);

            Fechaturno := getFecha (Turnoaux);

            put
              ("------------------------------------------------------------");
            new_line;
            Put ("nombre y apellido: ");
            --Nombrecliente :=
            Put (ObtenerNombreCliente (getCliente (turnoaux), Liscliente));
            new_line;
            Put ("DNI del cliente: ");
            Put (Getcliente (Turnoaux));
            New_Line;
            Put ("nombre del mecanico: ");
            Put (Obtenernombremecanico (Getmecanico (Turnoaux), Lismecanico));
            New_Line;
            Put ("DNI del mecanico: ");
            Put (getMecanico (Turnoaux));
            New_Line;
            Put ("Fecha del turno: ");
            --Put(Mostrar_Fecha(Getfecha(Turnoaux)));
            Fechastr := Mostrar_Fecha (Fechaturno);

            Put (Fechastr);
            new_line;
            Put ("patente: ");
            put (getPatente (Turnoaux));

            New_Line;
            Put ("Motivo: ");
            Put (Getmotivo (Turnoaux));
            New_Line;
            put
              ("------------------------------------------------------------");
            new_line;

            Auxlista := lista_turnos.sig (Auxlista);
         end loop;

         null;
      end Listar_Turnos;

      ------------------------------------------------------------------------
   begin

      put
        ("Bienvenido al menu de turnos, indique con tecla numerica a donde quiere ir");
      New_Line;

      Put ("para agregar un nuevo turno, presione la tecla 1");
      New_Line;
      Put ("para eliminar un turno, presione la tecla 2");
      New_Line;
      Put ("para modificar un turno, presione la tecla 3");
      New_Line;
      Put ("para ver la lista de los turnos disponibles, presione la tecla 4");
      New_Line;
      Put ("para volver al menu principal, presione la tecla 0");
      New_Line;
      Get (Opcion);
      Skip_Line;

      case Opcion is

         when 0 =>
            return;

         when 1 =>
            Alta_Turno (Listurno);

         when 2 =>
            Baja_Turno (Listurno);

         when 3 =>
            Modificar_Turno (Listurno);

         when 4 =>
            Listar_Turnos (Listurno, Lista_Clientes, Lista_Mecanicos);

         when others =>
            put
              ("numero mal ingresado, asegurese de leer el texto con las indicaciones");
      end case;

   end Turnos_General;
   ---------------------------------------------------------

   ---------------PROGRAMA-PRINCIPAL-------------------------------------------
begin

   cargarListas
     (Lista_Mecanicos, Lista_Clientes, Listaturnos, listareparacion);

   Put ("Bienvenido al menu del taller de reparacion");
   new_line;

   loop
      Put
        ("------------------------------------------------------------------------------");
      new_line;
      Put
        ("para ver todo lo relacionado a la gestion de mecanicos, presione el numero 1");
      New_Line;
      Put
        ("para ver todo lo relacionado a la gestion de clientes, presione el numero 2");
      New_Line;
      Put
        ("para ver todo lo relacionado a la gestion de turnos, presione el numero 3");
      New_Line;
      Put
        ("para ver todo lo relacionado a la gestion de reparaciones, presione el numero 4");
      New_Line;
      Put ("para solicitar informes, presione el numero 5");
      New_Line;
      Put ("para ver carga o guardado de archivos, presione el numero 6");
      New_Line;
      Put ("");
      New_Line;
      Put ("para salir del menu, presione el numero 0");
      New_Line;
      Put ("");
      New_Line;

      Get (Opciones);
      Skip_Line;
      case Opciones is

         when 0 =>
            put ("Usted ha salido del menu");
            exit;

         when 1 =>
            General_Mecanicos (Lista_Mecanicos);

         when 2 =>
            Clientes_General (Lista_Clientes);

         when 3 =>
            Turnos_General (Listaturnos);

         when others =>
            put
              ("numero mal ingresado, asegurese de leer el texto con las indicaciones");

      end case;

   end loop;

end menu;
