with Ada.Integer_Text_Io, Ada.Text_Io, Clientes, reparacion, turno, mecanico,cola,calendar, lista, Ada.Strings.Fixed;
use Ada.Integer_Text_Io, Ada.Text_Io, turno, mecanico,Ada.Strings.Fixed;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;


procedure Menu is


   --Rta: Character;
   --mecanicos: mecanico.tipomecanico; --un solo mecanico en particular

  

   package Lista_Mec is new lista (Mecanico.Tipomecanico,Natural,Mecanico.Comparardnimecanico);
   --lista de mecanicos

   




   lista_mecanicos: lista_mec.tipolista;    
   opciones: natural;


         --------------PROCEDIMIENTOS-PARA-PROGRAMA-PRINCIPAL----------------------
-----------------------------------------------------------------------------------------------------------
   procedure General_Mecanicos (lismecanico: in out lista_mec.tipolista) is
      
      Lis: Integer;      
      N_Mec: Mecanico.Tipomecanico;
      

      -----------------------------------------------------------
      procedure Alta_Mecanicos (X: out mecanico.Tipomecanico) is
        
         Nomb, Apellid, Especialida: String(1..50);
         auxnom,auxap,auxesp: string(1..50);
         Dni: Natural;
         Lnnm,Lnap,Lnesp: Natural;
         --rta: character;
         estado: boolean;
      begin    
         

         Put("ingrese el nombre del nuevo mecanico: ");
         Get_Line(Auxnom, Lnnm);
         Nomb := (others => ' ');         
         Nomb(1..lnnm):= Auxnom(1..lnnm);         
         New_Line;
         Put("ingrese el apellido del nuevo mecanico: ");
         Get_Line(Auxap,Lnap);
         Apellid:= (others => ' ');
         Apellid(1..lnap):= auxap(1..lnap);
         New_Line;
         Put("ingrese el dni del nuevo mecanico: ");
         Get(Dni);
         skip_line;
         New_Line;
         Put("ingrese la especialidad del nuevo mecanico: ");
         Get_Line(Auxesp,Lnesp);
         Especialida:= (others => ' ');
         Especialida(1..Lnesp):= Auxesp(1..Lnesp);
         estado := true;
            New_Line; 
            X := Crearmecanico(Nomb,Apellid,Especialida,Dni,estado);
            New_Line;
            
            put("Nuevo mecanico ingresado");
            new_line; new_line;
                  

      end Alta_Mecanicos;
      
      ---------------------------------------------------------------------
      procedure Baja_Mecanicos (lismecanico: in out lista_mec.tipolista) is
         Auxdni: Natural;
         Auxlista : Lista_Mec.Tipolista := lismecanico;
         Auxmeca: Mecanico.Tipomecanico;
            
      begin
      
         Put("ingrese el dni del mecanico a dar de baja: ");
         get(Auxdni);
         
         while not lista_mec.Vacia(Auxlista) loop
            
            Auxmeca := lista_mec.Info(Auxlista);
            
            if Auxdni = Obtenerdni(Auxmeca) then
               
               
               Lista_Mec.Suprimir(Lismecanico, Lista_Mec.Info(Auxlista));
               
               Mecanico.Bajamecanico(Auxmeca);

               Lista_Mec.Insertar(Lismecanico, Auxmeca);
               

               exit;     
                                          
               
            end if ; 
         Auxlista := lista_mec.sig(Auxlista);           
        end loop;
         
      end Baja_Mecanicos;
      
   
        procedure Listado_Mecanicos (lismecanico: in lista_mec.tipolista) is
      
   lis: integer;

      --PROCEDIMIENTO-PARA-LISTADO-MECANICO-GENERAL--
      procedure Mecanico_General (x: in lista_mec.tipolista) is
      
      auxlista: lista_mec.tipolista := x;
         Aux: Mecanico.Tipomecanico;
         
         --nom,ape,esp: string(1..50);
      begin
         
         
         while not Lista_Mec.Vacia(Auxlista) loop
            
            
            Aux := Lista_Mec.Info(Auxlista);
                 
            if Mecanico.Obtenerestado(Aux) then
               
            Put("nombre: ");             
            Put(Trim(ObtenerNombre(aux), Both));   new_line;
            
            Put("apellido: ");
            Put(Trim(ObtenerApellido(aux), Both));  New_Line; 
                      
            Put("dni: ");
            Put(Obtenerdni(Aux)); New_Line;
            
            Put("especialidad: ");
            Put(Trim(Obtenerespecialidad(Aux), Both)); New_Line;
            
            Put(""); New_Line;

            end if;
             
            Auxlista:= Lista_Mec.Sig(Auxlista);
            
         end loop; --fin recorrido lista         
      end Mecanico_General;


   --PROCEDIMIENTO-PARA-LISTADO-MECANICO-ESPECIFO--
procedure Mecanico_especifico (x: in lista_mec.tipolista) is

   auxlista: lista_mec.tipolista := x;
   Aux: Mecanico.Tipomecanico;
   mensaje: String(1..100);
   Ln_Esp: Natural;
   Cont: Integer := 0;
   Especialidad_Real_Unbounded: Unbounded_String;

begin
   Skip_Line;

   Put("Ingrese el tipo de especializacion que usted quiere del mecanico: ");
   Get_Line(mensaje, Ln_Esp);

   declare
      Entrada_Limpia: constant String := Trim(mensaje(1..Ln_Esp), Both);
   begin
      Especialidad_Real_Unbounded := To_Unbounded_String(Entrada_Limpia);

      while not Lista_Mec.Vacia(Auxlista) loop
         Aux := Lista_Mec.Info(Auxlista);
         
         if Mecanico.Obtenerestado(Aux) then
           
         declare
            Especialidad_Mec: constant String := Trim(ObtenerEspecialidad(Aux), Both);
            Especialidad_Mec_Unbounded: Unbounded_String := To_Unbounded_String(Especialidad_Mec);
         begin
            if Especialidad_Real_Unbounded = Especialidad_Mec_Unbounded then
               New_Line;
               Put("nombre: "); Put(Trim(ObtenerNombre(Aux), Both)); New_Line;
               Put("apellido: "); Put(Trim(ObtenerApellido(Aux), Both)); New_Line;
               Put("dni: "); Put(ObtenerDni(Aux)); New_Line;
               Put("especialidad: "); Put(Especialidad_Mec); New_Line;
               Put("");New_Line;
               Cont := Cont + 1;
            end if;
         end;

         end if;
                  
         Auxlista := Lista_Mec.Sig(Auxlista);
      end loop;

      if Cont = 0 then
         Put("El tipo de especialidad que mencionas no existe"); New_Line;
      end if;
   end;
end Mecanico_especifico;
   ---------------------     
   begin --Inicio de programa Listado_Mecanicos
      
      Put("bienvenido a la seleccion de mecanicos");
      New_Line;
      Put("Si desea tener un listado general de los mecanicos del taller, presione 1");
      new_line;
      put("Si desea conocer un listado de mecanicos por especialidad, presione 2");
      New_Line;
      get(lis);
      case Lis is
         when 1 => Mecanico_General(lismecanico);
         when 2 => Mecanico_especifico(lismecanico);
         when others => put("numero equivocado");
      end case;
      
   end Listado_Mecanicos;


----------------------------------------------------------------------------------------------------
   begin --comienza el procedimiento General_Mecanicos
      
      Put("Has ingresado a la gestion de mecanicos del taller");
      New_Line;
      Put("para ingresar un nuevo mecanico al sistema, ingrese el boton 1");
      New_Line;
      Put("para bajar a un mecanico del sistema, ingrese el boton 2");
      New_Line;
      Put("para ingresar al listado de mecanicos en el sistema, ingrese el boton 3");
      New_Line;
      
      Get(Lis);
      skip_line;
      case Lis is
               
               
         when 1 =>
            Alta_Mecanicos(N_Mec);
            Lista_Mec.insertar(lismecanico,N_Mec);
            
         when 2 => Baja_Mecanicos(lismecanico);
         when 3 => Listado_Mecanicos(lismecanico);
           
         when others => Put("ingreso incorrecto");
      end case;
      
   end General_Mecanicos;
   

   --procedure Clientes_General() is
      

   --begin
      


   --end Clientes_General;
   






---------------PROGRAMA-PRINCIPAL-------------------------------------------
begin
   
   Put("Bienvenido al menu del taller de reparacion");
   new_line;

   loop
      Put("------------------------------------------------------------------------------");
      new_line;
      Put("para ver todo lo relacionado a la gestion de mecanicos, presione el numero 1");   
   New_Line;         
   Put("para ver todo lo relacionado a la gestion de clientes, presione el numero 2");   
   New_Line;   
   Put("para ver todo lo relacionado a la gestion de turnos, presione el numero 3");   
   New_Line;        
   Put("para ver todo lo relacionado a la gestion de reparaciones, presione el numero 4");   
   New_Line;   
   Put("para solicitar informes, presione el numero 5");   
   New_Line;   
   Put("para ver carga o guardado de archivos, presione el numero 6");   
   New_Line;
      Put("");         
      New_Line; 
      Put("para salir del menu, presione el numero 0");         
      New_Line;  
      Put("");         
      New_Line; 
      

      Get(Opciones);
      Skip_Line;
      case Opciones is
               
         when 0 => put("Usted ha salido del menu");
            exit;         
         when 1 => General_Mecanicos(lista_mecanicos);
            
         when others => put("numero mal ingresado, asegurese de leer el texto con las indicaciones");

      end case;
                  
   end loop;

end menu;
