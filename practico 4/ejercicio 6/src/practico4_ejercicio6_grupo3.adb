with Lista, Ada.Text_Io, Ada.Integer_Text_Io;
use ada.Integer_Text_IO, ada.Text_IO;

procedure main is

   package Listachara is new Lista (Character);
   use Listachara;

   package Listalista is new Lista (Listachara.Tipolista);
   use listalista;

   procedure Llenarlista (lista1 : out listalista.tipolista) is
      Rta, Rta2 : Integer;
      Lista2    : Listachara.Tipolista;
      charaaux  : character;
   begin

      Put ("Ingrese la cantidad de lista que desea ingresar: ");
      get (rta);
      Put ("Ingrese la cantidad de caracteres que almacenara cada lista: ");
      Get (Rta2);

      Listalista.crear (lista1);
      for I in 1 .. Rta loop
         listachara.crear (lista2);
         for J in 1 .. Rta2 loop
            Put
              ("Ingrese el caracter "
               & Integer'Image (J)
               & " para la lista "
               & Integer'Image (I)
               & ": ");
            Get (Charaaux);
            listachara.insertar (lista2, charaaux);
         end loop;
         listalista.insertar (lista1, lista2);
      end loop;
   end Llenarlista;

   procedure Imprimir (lista1 : listalista.tipolista) is
      Auxlista1 : Listalista.Tipolista := Lista1;
      Auxlista2 : Listachara.Tipolista;
      contador  : integer := 1;
   begin

      while not Listalista.Vacia (Auxlista1) loop
         Auxlista2 := Listalista.Info (Auxlista1);
         Put_Line ("SUBLISTA" & Integer'Image (Contador));

         while not Listachara.Vacia (Auxlista2) loop
            Put (Listachara.Info (Auxlista2));
            auxlista2 := listachara.sig (auxlista2);
         end loop;
         new_line;
         Contador := Contador + 1;
         auxlista1 := listalista.sig (auxlista1);

      end loop;

   end Imprimir;

   procedure comparacion
     (lista1 : listalista.tipolista; listarep : out listalista.tipolista)
   is
      Aux1    : Listalista.Tipolista := Lista1;
      Aux2    : Listachara.Tipolista;
      Aux2sig : Listachara.Tipolista;
      Sig     : Listalista.Tipolista;
      Igual   : Boolean;
   begin
      Listalista.Crear (Listarep);
      while not Listalista.Vacia (Aux1)
        and not listalista.vacia (listalista.sig (aux1))
      loop

         Aux2 := Listalista.Info (Aux1);
         sig := listalista.sig (aux1);
         Aux2sig := Listalista.Info (Sig);
         Igual := True;

         while not Listachara.Vacia (aux2)
           and not listachara.vacia (aux2sig)
           and igual
         loop

            if Listachara.Info (Aux2) /= listachara.info (aux2sig) then
               Igual := False;
            else
               Aux2 := Listachara.Sig (Aux2);
               Aux2sig := Listachara.Sig (Aux2sig);
            end if;
         end loop;

         if Igual and Listachara.Vacia (Aux2) and Listachara.Vacia (Aux2sig)
         then
            Listalista.Insertar (Listarep, Listalista.Info (Aux1));
         end if;

         Aux1 := Listalista.Sig (Aux1);
      end loop;

   end Comparacion;

   lista1, listarep : listalista.tipolista;

begin

   Llenarlista (Lista1);
   Comparacion (Lista1, listarep);

   put_line ("Lista normal");
   Imprimir (Lista1);
   Put_Line ("Lista rep");
   Imprimir (Listarep);

end main;
