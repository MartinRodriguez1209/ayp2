with Ada.Integer_Text_Io,
     Ada.Text_Io,
     Clientes,
     reparacion,
     turno,
     mecanico,
     lista,
     Ada.Strings.Fixed;
use Ada.Integer_Text_Io, Ada.Text_Io, turno, mecanico, Ada.Strings.Fixed;
with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
use Clientes;
with Ada.Calendar;          use Ada.Calendar;
with data;
with Ada.Float_Text_Io;     use Ada.Float_Text_Io;
with reportes;

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
     Lista (Clientes.Tipocliente, Integer, Clientes.Compararcliente);

   package lista_reparacion is new
     lista
       (Reparacion.TipoReparacion,
        CadenaClave,
        Reparacion.BuscarReparacion);
   --package listarepara is new lista();

   package lista_reportes is new
     reportes
       (Lista_Mec,
        lista_turnos,
        mecanico.Obtenernombre,
        mecanico.Obtenerespecialidad,
        mecanico.Obtenerapellido,
        turno.getmotivo);
   use Lista_Reportes;

   Lista_Mecanicos : Lista_Mec.Tipolista;
   Lista_Clientes  : Listaclientes.Tipolista;
   Listaturnos     : Lista_Turnos.Tipolista;
   listareparacion : lista_reparacion.TipoLista;

   carga_estado : boolean := false;

   --Listar_Mecanicos_Por_Especialidad(Lista_Mecanicos, "soldador");
   --

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

   Opciones : Natural;

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

         Put ("----------------------------------------");
         new_line;
         Put ("Ingrese el nombre del nuevo mecanico: ");
         Get_Line (Auxnom, Lnnm);
         Nomb := (others => ' ');
         Nomb (1 .. lnnm) := Auxnom (1 .. lnnm);
         New_Line;
         Put ("Ingrese el apellido del nuevo mecanico: ");
         Get_Line (Auxap, Lnap);
         Apellid := (others => ' ');
         Apellid (1 .. lnap) := auxap (1 .. lnap);
         New_Line;
         Put ("Ingrese el DNI del nuevo mecanico: ");
         Get (Dni);
         skip_line;
         New_Line;
         Put ("Ingrese la especialidad del nuevo mecanico: ");
         Get_Line (Auxesp, Lnesp);
         Especialida := (others => ' ');
         Especialida (1 .. Lnesp) := Auxesp (1 .. Lnesp);
         estado := true;
         New_Line;
         X := Crearmecanico (Nomb, Apellid, Especialida, Dni, estado);
         New_Line;
         Carga_Estado := true;
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
         New_Line;
         Put ("----------------------------------------");
         new_line;
         Put ("Ingrese el dni del mecanico a dar de baja: ");
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
      ------------------------------------------------------------------------
      --------------------------------------------------------------------
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

                  new_line;
                  Put ("----------------------------------------");
                  new_line;
                  Put ("Nombre: ");
                  Put (Trim (ObtenerNombre (aux), Both));
                  new_line;

                  Put ("Apellido: ");
                  Put (Trim (ObtenerApellido (aux), Both));
                  New_Line;

                  Put ("DNI: ");
                  Put (Obtenerdni (Aux));
                  New_Line;

                  Put ("Especialidad: ");
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
                           Put ("Nombre: ");
                           Put (Trim (ObtenerNombre (Aux), Both));
                           New_Line;
                           Put ("Apellido: ");
                           Put (Trim (ObtenerApellido (Aux), Both));
                           New_Line;
                           Put ("DNI: ");
                           Put (ObtenerDni (Aux));
                           New_Line;
                           Put ("Especialidad: ");
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
         Put ("");
         New_Line;
         Put ("Ingrese opcion: ");
         Get (Lis);
         new_line;
         case Lis is
            when 0 =>
               return;

            when 1 =>
               Mecanico_General (lismecanico);

            when 2 =>
               Mecanico_especifico (lismecanico);

            when others =>
               put ("Numero equivocado");
               new_line;
         end case;

      end Listado_Mecanicos;

      -------------------------------------------------------------------------------------------------
   begin
      --comienza el procedimiento General_Mecanicos

      Put ("Has ingresado a la gestion de clientes del taller");
      New_Line;

      loop
         put ("---------------------------------------------------------");
         new_line;
         Put
           (" - Para ingresar un nuevo mecanico al sistema, ingrese el boton 1");
         New_Line;
         Put (" - Para bajar a un mecanico del sistema, ingrese el boton 2");
         New_Line;

         --Put("para modificar el dato de un mecanico en el sistema, ingrese el boton 3");
         --New_Line;
         Put
           (" - Para ingresar al listado de mecanicos en el sistema, ingrese el boton 3");  --si se hace el proc. modificar este pasa a 4
         New_Line;
         New_Line;

         Put (" - Para regresar al menu principal, ingrese el boton 0");
         New_Line;
         Put ("");
         New_Line;
         put ("Ingrese opcion: ");

         Get (Lis);
         Skip_Line;

         case Lis is

            when 0 =>
               new_line;
               exit;

            when 1 =>
               new_line;
               Alta_Mecanicos (N_Mec);
               Lista_Mec.Insertar (Lismecanico, N_Mec);
               new_line;

            when 2 =>
               new_line;
               Baja_Mecanicos (Lismecanico);
               new_line;
               --when 3 =>

            when 3 =>
               new_line;
               Listado_Mecanicos (lismecanico);
               new_line;

            when others =>
               new_line;
               Put ("Ingreso incorrecto");
               new_line;
         end case;

      end loop;

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
         estado                 : boolean;

      begin
         new_line;
         put ("--------------------------------------------------");
         new_line;
         Put ("Ingrese el nombre del nuevo cliente a ingresar: ");
         Get_Line (Auxnom, Lnnm);
         Nombre_Cl := (others => ' ');
         Nombre_Cl (1 .. lnnm) := Auxnom (1 .. lnnm);
         New_Line;
         Put ("Ingrese el apellido del nuevo cliente: ");
         Get_Line (Auxap, Lnap);
         Apellido_Cl := (others => ' ');
         Apellido_Cl (1 .. lnap) := auxap (1 .. lnap);
         New_Line;
         Put ("Ingrese el dni del nuevo cliente: ");
         Get (Dni);
         skip_line;
         New_Line;
         Put ("Ingrese la patente del vehiculo del nuevo cliente: ");
         Get_Line (Auxpat, Lnpat);
         Patente := (others => ' ');
         Patente (1 .. Lnpat) := Auxpat (1 .. Lnpat);
         put ("Nuevo cliente creado");
         New_Line;
         estado := true;
         X :=
           clientes.crear
             (Nombre_Cl (1 .. lnnm),
              Apellido_Cl (1 .. Lnap),
              Dni,
              Patente (1 .. Lnpat),
              estado);
         New_Line;
         Carga_Estado := true;
      end Alta_Cliente;

      ----------------------------------------------------------------------
      procedure Baja_cliente (lista : in out Listaclientes.Tipolista) is
         Auxdni   : Natural;
         Auxlista : Listaclientes.Tipolista := lista;
         Auxcl    : clientes.tipocliente;

      begin
         New_Line;
         put ("--------------------------------------------");
         new_line;
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
               Put ("Cliente dado de baja");
               new_line;
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
            new_line;
            Put ("Ingrese un nuevo nombre: ");
            Get_Line (Auxnm, Ln_Nm);
            Nom := (others => ' ');
            Nom (1 .. Ln_Nm) := Auxnm (1 .. Ln_Nm);
            client := Clientes.Cambiarnombre (Auxcl, Nom);
         end N_Nombre;
         ---------
         procedure N_Apellido (Client : out Clientes.Tipocliente) is

            Ape, Auxap : String (1 .. 30);
            Ln_Ap      : Natural;
            C_caso     : Natural;
         begin
            new_line;
            Put ("Ingrese un nuevo apellido (max 25 caracteres): ");

            Get_Line (Auxap, Ln_Ap);

            Ape := (others => ' ');

            if Ln_Ap > Ape'Length then

               C_caso := Ape'Length;
            else
               C_caso := Ln_Ap;
            end if;
            Ape (1 .. C_caso) := Auxap (1 .. C_caso);
            Client := Clientes.Cambiarapellido (Auxcl, Ape);

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
            new_line;
            Put ("Ingrese una nueva patente: ");
            Get_Line (Auxp, Ln_P);
            Pat := (others => ' ');
            Pat (1 .. Ln_P) := Auxp (1 .. Ln_P);
            Client := Clientes.Cambiarpatente (Auxcl, Pat);

         end N_Patente;

      begin
         new_line;
         Put ("Ingrese el dni del cliente a modificar: ");
         get (auxdni);
         Skip_Line;
         New_Line;
         while not Listaclientes.Vacia (Auxlista) loop
            auxcl := Listaclientes.info (auxlista);
            if Getestado (Auxcl) then
               if Auxdni = Clientes.Getdni (Auxcl) then

                  New_Line;
                  Put
                    ("Cliente encontrado, que dato de este desea modificar?");
                  New_Line;
                  Put (" - Pulse tecla 1 para cambiar nombre");
                  New_Line;
                  Put (" - Pulse tecla 2 para cambiar apellido");
                  New_Line;
                  Put (" - Pulse tecla 3 Para cambiar dni");
                  New_Line;
                  Put (" - Pulse tecla 4 Para cambiar patente del vehiculo");
                  New_Line;
                  Put (" - Pulse 0 para salir");
                  new_line;
                  new_line;
                  Put ("Ingrese opcion: ");
                  Get (opc);
                  skip_line;

                  case Opc is
                     when 0 =>
                        new_line;
                        Put ("Ha salido de las opciones");
                        new_line;
                        exit;

                     when 1 =>
                        N_Nombre (auxcl);
                        new_line;

                     when 2 =>
                        N_Apellido (auxcl);
                        new_line;

                     when 3 =>
                        N_dni (auxcl);
                        new_line;

                     when 4 =>
                        N_Patente (auxcl);
                        new_line;

                     when others =>
                        put ("numero incorrecto, revise nuevamente el texto");
                        new_line;
                  end case;

                  Listaclientes.Suprimir
                    (Lista, Listaclientes.Info (Auxlista));
                  Listaclientes.Insertar (Lista, Auxcl);
                  Put ("Cliente modificado");
                  New_line;
                  new_line;
                  return;
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

               put ("-----------------------------");
               new_line;
               Put ("Nombre: ");
               Put (Trim (getnombre (aux), Both));
               new_line;

               Put ("Apellido: ");
               Put (Trim (getapellido (aux), Both));
               New_Line;

               Put ("DNI: ");
               Put (getdni (Aux));
               New_Line;

               Put ("Patente: ");
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
      loop
         put ("----------------------------------------------------");
         new_line;
         Put (" - Ingrese 1 para ingresar un nuevo cliente al sistema");
         New_Line;
         Put (" - Ingrese 2 para bajar a un cliente del sistema");
         New_Line;
         Put (" - Ingrese 3 para modificar algo de un cliente");
         New_Line;
         Put
           (" - Ingrese 4 para ingresar al listado de clientes en el sistema");
         New_Line;
         new_line;
         Put (" - Ingrese 0 para volver al menu principal");
         New_Line;
         put ("Ingresar opcion: ");
         Get (Opcion_Cl);
         skip_line;

         case Opcion_Cl is

            when 0 =>
               new_line;
               exit;

            when 1 =>
               Alta_Cliente (R_cl);
               listaclientes.insertar (liscliente, r_cl);
               new_line;

            when 2 =>
               Baja_Cliente (Liscliente);
               new_line;

            when 3 =>
               Modificar_Cliente (Liscliente);
               new_line;

            when 4 =>
               Listado_Clientes (Liscliente);
               new_line;

            when others =>
               Put ("Ingreso incorrecto");
               new_line;

         end case;

      end loop;

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
         Put ("ingrese la hora del turno (00hs a 23hs): ");
         Get (Hora);
         Verif (hora, 0, 23);
         New_Line;
         Put ("ingrese el minuto del turno (0-59): ");
         Get (Min);
         Verif (min, 0, 59);
         New_Line;
         Put ("ingrese el mes del turno (1-12): ");
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
         Lista_Turnos.Insertar (Lturno, Aux);
         Carga_Estado := True;
         Put ("Nuevo turno ingresado");
         new_line;
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
            Auxlista := Lista_Turnos.sig (Auxlista);
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
            Client := Turno.Cambiarmecanico (Client, Dninuevo);
            put ("nuevo mecanico ingresado");
            new_line;

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
            Client := Cambiarfecha (Client, Nuevafecha);
            put ("nueva fecha ingresada");
            new_line;

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
            Client := Turno.Cambiarmotivo (Client, Motivo);
            put ("nuevo turno ingresado");
            new_line;

         end N_motivo;

         procedure N_patente (Client : in out turno.TipoTurno) is
            patente, Auxpat : String (1 .. 7);
            Ln_pat          : Natural;

         begin
            Put ("ingrese una nueva patente: ");
            Get_Line (Auxpat, Ln_pat);
            patente := (others => ' ');
            patente (1 .. Ln_pat) := Auxpat (1 .. Ln_pat);
            Client := turno.cambiarMotivo (client, patente);
            put ("nueva patente ingresada");
            new_line;

         end N_patente;

      begin

         Put ("ingrese el dni del cliente del turno a modificar: ");
         Get (Dni);
         skip_line;

         while not Lista_Turnos.Vacia (Auxlista) loop
            Auxturno := Lista_Turnos.Info (Auxlista);

            if Getcliente (Auxturno) = Dni then

               Put ("cliente encontrado, elija que parte desea modificar");
               new_line;
               Put ("Para cambiar mecanico, pulse tecla 1");
               New_Line;
               Put ("Para cambiar la fecha, pulse tecla 2");
               New_Line;
               Put ("Para cambiar el motivo, pulse tecla 3");
               New_Line;
               put ("Para modificar la patente, pulse tecla 4");
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
            Auxlista := Lista_Turnos.sig (Auxlista);
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
            n_ap        : Unbounded_String;
         begin
            while not Listaclientes.Vacia (Auxclilista) loop
               Cli := Listaclientes.Info (Auxclilista);
               if Clientes.Getdni (Cli) = Dni then
                  n_ap :=
                    To_Unbounded_String
                      (Trim (Clientes.Getnombre (Cli), Ada.Strings.Right))
                    & To_Unbounded_String (" ")
                    & To_Unbounded_String
                        (Trim (Clientes.Getapellido (Cli), Ada.Strings.Right));
                  return To_String (n_ap);
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

            M_Fecha : unbounded_String;

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
              To_unbounded_String
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
         new_line;

         while not lista_turnos.vacia (Auxlista) loop

            Turnoaux := Lista_Turnos.Info (Auxlista);

            Fechaturno := getFecha (Turnoaux);

            put
              ("------------------------------------------------------------");
            new_line;
            Put ("nombre y apellido: ");
            --declare
            --Linea : Unbounded_String;
            --begin

            --Linea := To_Unbounded_String(Obtenernombrecliente(Getcliente(Turnoaux), Liscliente));

            --Put_Line(To_String(Linea));

            --end;

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
            --Fechastr := Mostrar_Fecha (Fechaturno);
            declare
               Resultado : constant String := Mostrar_Fecha (Fechaturno);
            begin
               Fechastr := (others => ' ');
               Fechastr (1 .. Resultado'Length) := Resultado;
            end;
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

   -----------------------------------------------------------------------------
   ---------------------- GENERAL REPARACION------------------------------------
   -----------------------------------------------------------------------------
   procedure General_Reparaciones
     (Lista_Repar : in out lista_reparacion.Tipolista)
   is
      --Lista_Reparaciones : lista_reparacion.Tipolista;
      R   : Reparacion.TipoReparacion;
      Lis : Integer;
      -------------------------
      -----ALTA REPARACION-----
      -------------------------
      procedure Alta_Reparacion (X : out Reparacion.Tiporeparacion) is

         -- Variables auxiliares para entrada de datos

         Patente_Str, Cosas_Str, Partes_Str : String (1 .. 50);
         AuxPat, AuxCosas, AuxPartes        : String (1 .. 50);
         LPat, LCosas, LPartes              : Natural;
         dniMec                             : Natural;
         Fecha_Ing                          : ada.Calendar.Time;
         Horas_Trab                         : Float;
         Precio_Rep                         : Float;
         Fecha_Str                          : String (1 .. 20);
         Lfecha                             : Natural;

      begin
         Put ("Ingrese patente: ");
         Get_Line (AuxPat, LPat);
         Patente_Str := (others => ' ');
         Patente_Str (1 .. LPat) := AuxPat (1 .. LPat);
         New_Line;

         Put ("Ingrese DNI mecanico: ");
         Get (dniMec);
         Skip_Line;
         New_Line;

         Put ("Ingrese cosas reparadas: ");
         Get_Line (AuxCosas, LCosas);
         Cosas_Str := (others => ' ');
         Cosas_Str (1 .. LCosas) := AuxCosas (1 .. LCosas);
         New_Line;

         Put ("Ingrese partes reemplazadas: ");
         Get_Line (AuxPartes, LPartes);
         Partes_Str := (others => ' ');
         Partes_Str (1 .. LPartes) := AuxPartes (1 .. LPartes);
         New_Line;

         -- Pedir fecha ingreso (simplificado a fecha actual)
         Put ("Ingrese fecha ingreso (YYYY-MM-DD HH:MM:SS): ");
         Get_Line (Fecha_Str, Lfecha);

         -- Para simplicidad, uso fecha actual
         Fecha_Ing := ada.Calendar.Clock;
         New_Line;

         Put ("Ingrese horas trabajadas: ");
         Get (Horas_Trab);
         Skip_Line;
         New_Line;

         Put ("Ingrese precio: ");
         Get (Precio_Rep);
         Skip_Line;
         New_Line;

         declare

            Patente_Actual : String (1 .. Lpat) := Patente_Str (1 .. Lpat);
            Cosas_Actual   : String (1 .. Lcosas) := Cosas_Str (1 .. Lcosas);
            Partes_Actual  : String (1 .. Lpartes) :=
              Partes_Str (1 .. Lpartes);

         begin
            -- Llamar a AltaReparacion
            Reparacion.Altareparacion
              (X,
               Patente_Actual,
               Dnimec,
               Cosas_Actual,
               Partes_Actual,
               Fecha_Ing,
               Horas_Trab,
               Precio_Rep);

         end;
         carga_estado := true;
         Put_Line ("Reparacion dada de alta correctamente.");
         New_Line;
      end Alta_Reparacion;
      --------------------
      ---BAJA REPARACION--
      --------------------
      ---------------------------------------------------------------------------------------------------------           
      procedure Baja_Reparacion (L : in out lista_reparacion.Tipolista) is
         Patente_Buscar  : String (1 .. 10);
         AuxPat          : String (1 .. 10);
         LPat            : Natural;
         Nodo_Encontrado : lista_reparacion.Tipolista;
         Auxlista        : Lista_Reparacion.Tipolista := L;
         rep             : reparacion.tiporeparacion;
      begin
         Put ("Ingrese patente a dar de baja: ");
         Get_Line (AuxPat, LPat);
         Patente_Buscar := (others => ' ');
         Patente_Buscar (1 .. LPat) := AuxPat (1 .. LPat);
         New_Line;

         ------- Buscar nodo con patente
         while not lista_reparacion.Vacia (AuxLista) loop
            declare
               RepAux      : Reparacion.TipoReparacion :=
                 lista_reparacion.Info (AuxLista);
               Patente_Rep : String := Reparacion.getPatente (RepAux);
            begin
               if Patente_Rep = Patente_Buscar (1 .. LPat) then
                  Nodo_Encontrado := AuxLista;
                  exit;
               end if;
            end;
            AuxLista := lista_reparacion.Sig (AuxLista);
         end loop;

         if lista_reparacion.Vacia (Nodo_Encontrado) then
            Put_Line ("No se encontro reparacion con esa patente.");
         else
            rep := lista_reparacion.Info (Nodo_Encontrado);
            Reparacion.Bajareparacion (rep);
            Put_Line ("Reparacion dada de baja correctamente.");
         end if;
         New_Line;
      end Baja_Reparacion;
      -----------------------------------------------------------------------------------------------------------------
      -----------------------------
      ---MODIFICACION REPARACION---
      -----------------------------
      ------------------------------------------------------------------------------------------------------------------
      procedure Modificacion_Reparacion (L : in out lista_reparacion.Tipolista)
      is
         Patente_Mod     : String (1 .. 10);
         AuxPat          : String (1 .. 10);
         LPat            : Natural;
         Campo           : String (1 .. 20);
         AuxCampo        : String (1 .. 20);
         LCampo          : Natural;
         NuevoValor      : String (1 .. 50);
         AuxValor        : String (1 .. 50);
         LValor          : Natural;
         Nodo_Encontrado : lista_reparacion.Tipolista;
         Auxlista        : Lista_Reparacion.Tipolista := L;
         rep             : reparacion.TipoReparacion;
      begin
         Put ("Ingrese patente de reparacion a modificar: ");
         Get_Line (AuxPat, LPat);
         Patente_Mod := (others => ' ');
         Patente_Mod (1 .. LPat) := AuxPat (1 .. LPat);
         New_Line;

         -- Buscar nodo con patente
         while not lista_reparacion.Vacia (AuxLista) loop
            declare
               RepAux      : Reparacion.TipoReparacion :=
                 lista_reparacion.Info (AuxLista);
               Patente_Rep : String := Reparacion.getPatente (RepAux);
            begin
               if Patente_Rep = Patente_Mod (1 .. LPat) then
                  Nodo_Encontrado := AuxLista;
                  exit;
               end if;
            end;
            AuxLista := lista_reparacion.Sig (AuxLista);
         end loop;

         if lista_reparacion.vacia (Nodo_Encontrado) then
            Put_Line ("No se encontro reparacion con esa patente");
         else
            Put
              ("Ingrese campo a modificar (patente, cosas, partes, precio, horas): ");
            Get_Line (AuxCampo, LCampo);
            Campo := (others => ' ');
            Campo (1 .. LCampo) := AuxCampo (1 .. LCampo);
            New_Line;

            Put ("Ingrese nuevo valor: ");
            Get_Line (AuxValor, LValor);
            NuevoValor := (others => ' ');
            NuevoValor (1 .. LValor) := AuxValor (1 .. LValor);
            New_Line;
            rep := lista_reparacion.Info (Nodo_Encontrado);
            Reparacion.Modificacionreparacion
              (rep, Campo (1 .. LCampo), NuevoValor (1 .. LValor));

            Put_Line ("Reparacion modificada correctamente");
         end if;
         New_Line;
      end Modificacion_Reparacion;
      ---------------------------------------------------------------------------------------------------------------------------
      ----------------------------------------------
      ------------LISTADO DE REPARACIONES-----------
      ----------------------------------------------
      ---------------------------------------------------------------------------------------------------------------------------
      procedure Listado_Reparaciones (L : in Lista_Reparacion.Tipolista) is
         package Float_IO is new Ada.Text_IO.Float_IO (Float);
         AuxLista : lista_reparacion.Tipolista := L;
         R        : Reparacion.Tiporeparacion;

         function Fecha_A_String (T : Ada.Calendar.Time) return String is
            Year  : Integer;
            Month : Integer;
            Day   : Integer;
            Sec   : duration;
         begin
            Ada.Calendar.Split (T, Year, Month, Day, Sec);
            return
              Integer'Image (Day)
              & "/"
              & Integer'Image (Month)
              & "/"
              & Integer'Image (Year);
         end Fecha_A_String;

      begin
         Put_Line ("Listado de reparaciones activas:");
         new_line;
         while not lista_reparacion.Vacia (AuxLista) loop
            R := Lista_Reparacion.Info (Auxlista);

            if Reparacion.Getestado (R) then

               Put ("------------------------------");
               new_line;
               Put ("Patente: ");
               Put (Reparacion.Getpatente (R));
               New_Line;

               Put ("DNI Mecanico: ");
               Put (Natural'Image (Reparacion.Getdnimecanico (R)));
               New_Line;

               Put_Line
                 ("Cosas Reparadas: " & Reparacion.getCosasReparadas (R));

               Put_Line
                 ("Partes Reemplazadas: " & Reparacion.getPartesReemp (R));
               Put_Line
                 ("Fecha Ingreso: "
                  & Fecha_A_String (Reparacion.GetFecha (R)));

               Put ("Horas Trabajo: ");
               Float_IO.Put
                 (Reparacion.Gethoras (R), Fore => 1, Aft => 2, Exp => 0);
               put (" horas");
               new_line;

               Put ("Precio: ");
               Put (Reparacion.Getprecio (R), Fore => 1, Aft => 2, Exp => 0);
               Put (" ARS");
               new_line;
               Put_Line ("------------------------------");

            end if;
            AuxLista := lista_reparacion.Sig (AuxLista);
         end loop;
         New_Line;
      end Listado_Reparaciones;
      -------------------------------------------------------------------------------------------------------------------------------------
      ---- cuerpo General_Reparaciones-----
   begin
      loop
         Put_Line ("Menu gestion de reparaciones:");
         Put_Line ("1 - Alta de reparacion");
         Put_Line ("2 - Baja de reparacion");
         Put_Line ("3 - Modificacion de reparacion");
         Put_Line ("4 - Listado de reparaciones");
         Put_Line ("0 - Salir");
         Put ("Ingrese opcion: ");
         Get (Lis);
         Skip_Line;

         case Lis is
            when 0 =>
               exit;

            when 1 =>
               Alta_Reparacion (R);
               lista_reparacion.Insertar (Lista_Repar, R);

            when 2 =>
               Baja_Reparacion (Lista_Repar);

            when 3 =>
               Modificacion_Reparacion (Lista_Repar);

            when 4 =>
               Listado_Reparaciones (Lista_Repar);

            when others =>
               Put_Line ("Opcion invalida. Intente nuevamente.");
         end case;
      end loop;
   end General_Reparaciones;

   ------------------------------------------------------------------------------------------
   -----------------------------------------------------------------------------------------

   procedure General_Reportes
     (ListaMec : in reportes.ListaMecanico.Tipolista;
      ListaMot : in reportes.ListaMotivos.Tipolista)
   is

      Opcion : Integer;

      ---------------------------------------------
      --  Reporte de mec�nicos por especialidad  --
      ---------------------------------------------

      procedure Reporte_Mecanicos_Por_Especialidad is
         AuxEsp : String (1 .. 30);
         LEsp   : Natural;
      begin
         Put ("Ingrese especialidad a buscar: ");
         Get_Line (AuxEsp, LEsp);
         --Especialidad_Ing := (others => ' ');

         --Especialidad_Ing(1..LEsp) := AuxEsp(1..LEsp);
         New_Line;

         Lista_Reportes.Listar_Mecanicos_Por_Especialidad
           (ListaMec, AuxEsp (1 .. LEsp));
      end Reporte_Mecanicos_Por_Especialidad;

      ---------------------------------------------
      -- Reporte de causas m�s frecuentes --
      ---------------------------------------------
      procedure Reporte_Problemas_Frecuentes is
      begin
         lista_reportes.Listar_problemas (ListaMot);
      end Reporte_Problemas_Frecuentes;

   begin
      loop
         Put_Line ("---------------------------------------------------");
         Put_Line ("-------------- MENU DE REPORTES -------------------");
         Put_Line ("1 - Listar mecanicos por especialidad");
         Put_Line ("2 - Listar causas mas frecuentes");
         Put_Line ("0 - Salir");
         Put_Line ("---------------------------------------------------");
         Put ("Ingrese opcion: ");
         Get (Opcion);
         Skip_Line;
         New_Line;

         case Opcion is
            when 0 =>
               exit;

            when 1 =>
               Reporte_Mecanicos_Por_Especialidad;

            when 2 =>
               Reporte_Problemas_Frecuentes;

            when others =>
               Put_Line ("Opci�n invalida. Intente nuevamente.");
         end case;

         New_Line;
      end loop;
   end General_Reportes;

   ------------------------------------------------------------------------------------------
   -----------------------------------------------------------------------------------------
   procedure Datos_General is

      opc : natural;

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

   begin

      Put ("---menu de datos---");
      New_Line;

      Put (" - Presione 1 para cargar archivos");
      New_Line;
      Put (" - Presione 2 para guardar archivos");
      New_Line;
      new_line;
      Put ("Presione 0 para salir del menu");
      New_Line;
      Put ("");
      New_Line;

      put ("Ingresar opcion: ");
      Get (opc);
      Skip_Line;
      case opc is

         when 0 =>
            return;

         when 1 =>
            new_line;
            cargarListas
              (Lista_Mecanicos, Lista_Clientes, Listaturnos, Listareparacion);
            Carga_Estado := true;
            Put ("Informacion cargada");
            new_line;

         when 2 =>
            new_line;
            Guardarlistas
              (Lista_Mecanicos, Lista_Clientes, Listaturnos, Listareparacion);
            Put ("Informacion nueva guardada");
            new_line;

         when others =>
            put
              ("numero mal ingresado, asegurese de leer el texto con las indicaciones");

      end case;

   end Datos_General;

   ---------------------------------------------------------

   ---------------PROGRAMA-PRINCIPAL-------------------------------------------
begin

   Put ("Bienvenido al menu del taller de reparacion");
   new_line;

   loop

      if not Carga_Estado then
         put
           ("LISTAS VACIAS, ASEGURESE DE CARGAR LOS DATOS O DE HACER LA ALTA DE ALGUNA FUNCION");
         New_Line;
         put ("");
      end if;

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
      Put ("para guardar o cargar archivos, presione el numero 6");
      New_Line;
      Put ("");
      New_Line;
      Put ("para salir del menu, presione el numero 0");
      New_Line;
      Put ("");
      New_Line;

      put ("ingrese opcion: ");
      Get (Opciones);
      new_line;
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

         when 4 =>
            General_Reparaciones (listareparacion);

         when 5 =>
            General_Reportes (Lista_Mecanicos, Listaturnos);

         when 6 =>
            Datos_General;

         when others =>
            put
              ("numero mal ingresado, asegurese de leer el texto con las indicaciones");

      end case;
   end loop;
end menu;
