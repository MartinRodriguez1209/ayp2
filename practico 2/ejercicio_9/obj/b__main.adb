pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is

   E058 : Short_Integer; pragma Import (Ada, E058, "system__os_lib_E");
   E018 : Short_Integer; pragma Import (Ada, E018, "ada__exceptions_E");
   E014 : Short_Integer; pragma Import (Ada, E014, "system__soft_links_E");
   E012 : Short_Integer; pragma Import (Ada, E012, "system__exception_table_E");
   E035 : Short_Integer; pragma Import (Ada, E035, "ada__containers_E");
   E054 : Short_Integer; pragma Import (Ada, E054, "ada__io_exceptions_E");
   E009 : Short_Integer; pragma Import (Ada, E009, "ada__strings_E");
   E087 : Short_Integer; pragma Import (Ada, E087, "ada__strings__maps_E");
   E090 : Short_Integer; pragma Import (Ada, E090, "ada__strings__maps__constants_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "interfaces__c_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__exceptions_E");
   E066 : Short_Integer; pragma Import (Ada, E066, "system__object_reader_E");
   E044 : Short_Integer; pragma Import (Ada, E044, "system__dwarf_lines_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "system__soft_links__initialize_E");
   E034 : Short_Integer; pragma Import (Ada, E034, "system__traceback__symbolic_E");
   E137 : Short_Integer; pragma Import (Ada, E137, "ada__numerics_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "ada__strings__utf_encoding_E");
   E106 : Short_Integer; pragma Import (Ada, E106, "ada__tags_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "ada__strings__text_buffers_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "ada__streams_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "system__file_control_block_E");
   E121 : Short_Integer; pragma Import (Ada, E121, "system__finalization_root_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "ada__finalization_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "system__file_io_E");
   E160 : Short_Integer; pragma Import (Ada, E160, "ada__calendar_E");
   E094 : Short_Integer; pragma Import (Ada, E094, "ada__text_io_E");
   E158 : Short_Integer; pragma Import (Ada, E158, "system__random_seed_E");
   E148 : Short_Integer; pragma Import (Ada, E148, "packagecola_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "packagepila_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "vector_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E094 := E094 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "ada__text_io__finalize_spec");
      begin
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "system__file_io__finalize_body");
      begin
         E118 := E118 - 1;
         F2;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E012 := E012 + 1;
      Ada.Containers'Elab_Spec;
      E035 := E035 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E054 := E054 + 1;
      Ada.Strings'Elab_Spec;
      E009 := E009 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E087 := E087 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E090 := E090 + 1;
      Interfaces.C'Elab_Spec;
      E064 := E064 + 1;
      System.Exceptions'Elab_Spec;
      E021 := E021 + 1;
      System.Object_Reader'Elab_Spec;
      E066 := E066 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E044 := E044 + 1;
      System.Os_Lib'Elab_Body;
      E058 := E058 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E083 := E083 + 1;
      E014 := E014 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E034 := E034 + 1;
      E018 := E018 + 1;
      Ada.Numerics'Elab_Spec;
      E137 := E137 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E100 := E100 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E106 := E106 + 1;
      Ada.Strings.Text_Buffers'Elab_Spec;
      Ada.Strings.Text_Buffers'Elab_Body;
      E098 := E098 + 1;
      Ada.Streams'Elab_Spec;
      E096 := E096 + 1;
      System.File_Control_Block'Elab_Spec;
      E122 := E122 + 1;
      System.Finalization_Root'Elab_Spec;
      System.Finalization_Root'Elab_Body;
      E121 := E121 + 1;
      Ada.Finalization'Elab_Spec;
      E119 := E119 + 1;
      System.File_Io'Elab_Body;
      E118 := E118 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E160 := E160 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E094 := E094 + 1;
      System.Random_Seed'Elab_Body;
      E158 := E158 + 1;
      E148 := E148 + 1;
      E150 := E150 + 1;
      E169 := E169 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Users\marti\Documents\ayp2\practico 2\ejercicio_9\obj\packageCola.o
   --   C:\Users\marti\Documents\ayp2\practico 2\ejercicio_9\obj\packagePila.o
   --   C:\Users\marti\Documents\ayp2\practico 2\ejercicio_9\obj\vector.o
   --   C:\Users\marti\Documents\ayp2\practico 2\ejercicio_9\obj\main.o
   --   -LC:\Users\marti\Documents\ayp2\practico 2\ejercicio_9\obj\
   --   -LC:\Users\marti\Documents\ayp2\practico 2\ejercicio_9\obj\
   --   -LC:/gnat/2021/lib/gcc/x86_64-w64-mingw32/10.3.1/adalib/
   --   -static
   --   -lgnat
   --   -lm
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
