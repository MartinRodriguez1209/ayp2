with lista, ada.Text_IO, ada.Strings.Fixed;
use Ada.Text_Io, ada.Strings.Fixed;

package body Reportes is

   procedure Listar_Mecanicos_Por_Especialidad
     (L : in Listamecanico.Tipolista; Especialidad : in String)
   is
      Aux : Listamecanico.Tipolista := L;
      M   : Listamecanico.tipoelem;
   begin
      put_line ("Listado de mecanicos por especialidad: " & especialidad);
      while not Listamecanico.Vacia (Aux) loop
         M := Listamecanico.Info (Aux);
         if Obtenerespecialidad (M) = Especialidad then
            put_line
              ("______________________________________________________________");
            Put_Line ("Mecanico: " & Obtenernombre (M));
            put_line
              ("_______________________________________________________________");
         end if;
         Aux := Listamecanico.Sig (Aux);

      end loop;
   end Listar_Mecanicos_Por_Especialidad;

   type T_Reg is record
      Causa    : String (1 .. 50);
      contador : integer;
   end record;

   function Comparar (A : T_Reg; Dni : Natural) return Boolean is
   begin
      return false;
   end;

   package ListaTemp is new Lista (T_Reg, natural, Comparar);
   use Listatemp;

   function AjustarString (Texto : String; Longitud : Positive) return String
   is
      Resultado : String (1 .. Longitud);
   begin
      if Texto'Length >= Longitud then
         Resultado := Texto (Texto'First .. Texto'First + Longitud - 1);
      else
         Resultado (1 .. Texto'Length) := Texto;
         Resultado (Texto'Length + 1 .. Longitud) := (others => ' ');
      end if;
      return Resultado;
   end AjustarString;

   procedure Listar_problemas (L : in Listamotivos.Tipolista) is

      ListaContador : Tipolista;
      AuxLista      : Listamotivos.Tipolista := L;
      R             : Listamotivos.tipoelem;
      Temp          : T_Reg;
      Encontrado    : Boolean;
      Aux_Rec       : Listatemp.Tipolista;

      procedure Buscar_E_Incrementar
        (L : in out Tipolista; CausaBuscada : String; encontrado : out Boolean)
      is
         Aux   : Tipolista := L;
         Causa : T_Reg;
      begin

         encontrado := false;

         while not Listatemp.Vacia (Aux) loop
            Causa := Listatemp.Info (Aux);
            if Trim (causa.causa, Ada.Strings.Right)
              = Trim (CausaBuscada, Ada.Strings.Right)
            then
               Encontrado := True;
               Listatemp.suprimir (L, causa);
               Causa.Contador := Causa.Contador + 1;
               Listatemp.insertar (L, causa);
            end if;
            aux := Sig (aux);
         end loop;
      end;

   begin

      listatemp.Crear (ListaContador);

      while not Listamotivos.Vacia (AuxLista) loop
         R := Listamotivos.Info (AuxLista);

         Buscar_E_Incrementar (ListaContador, getmotivos(r), Encontrado);

         if not Encontrado then
            Temp.Causa := AjustarString (getmotivos(r), 50);
            Temp.Contador := 1;
            listatemp.Insertar (ListaContador, Temp);
         end if;

         AuxLista := Listamotivos.Sig (AuxLista);
      end loop;

      Aux_Rec := Listacontador;
      Put_Line ("Listado de los problemas mas frecuentes en autos");
      while not Vacia (Aux_Rec) loop
         put_line
           ("_________________________________________________________________");
         Put_Line ("Causa: " & Info (Aux_Rec).Causa);
         Put_line ("Frecuencia: " & Integer'Image (Info (Aux_Rec).Contador));
         Aux_Rec := Sig (Aux_Rec);
         put_line
           ("_________________________________________________________________");
      end loop;

   end Listar_problemas;

end reportes;
