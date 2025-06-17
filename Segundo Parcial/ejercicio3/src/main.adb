with ada.Text_IO;         use ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with Quicksort;

procedure main is

   subtype indice is integer range 1 .. 20;

   type equipo is record
      idEquipo      : integer;
      empresa       : String (1 .. 40);
      canDiasSinAcc : Integer;
   end record;

   procedure put (e : in equipo) is
   begin
      put ("id del equipo:");
      Put_Line (e.idEquipo);
      put ("Empresa :");
      Put_Line (e.empresa);
      put ("Dias sin accidentes: ");
      Put (e.canDiasSinAcc);
   end put;

   procedure get (e : out equipo) is
      empresaAux : string (1 .. 40);
      longitud   : integer;
      int        : integer;

   begin
      Put_Line ("ingrese la empresa del equipo");
      Get_Line (empresaAux, longitud);
      e.empresa := empresaAux;
      Put_Line ("Ingrese el id del equipo");
      get (int);
      e.idEquipo := int;
      Put_Line ("Ingrese los dias sin accidentes");
      Get (int);
      e.canDiasSinAcc := int;
   end get;

   function menorIgual (A, B : in equipo) return boolean is
   begin
      if A.canDiasSinAcc = B.canDiasSinAcc then
         return A.empresa <= B.empresa;
      else
         return A.canDiasSinAcc <= B.canDiasSinAcc;
      end if;
   end menorIgual;

   function mayor (A, B : in equipo) return Boolean is
   begin
      if A.canDiasSinAcc = B.canDiasSinAcc then
         return A.empresa > B.empresa;
      else
         return A.canDiasSinAcc > B.canDiasSinAcc;
      end if;
   end mayor;

   package ordenar is new
     Quicksort (equipo, indice, put, get, menorIgual, mayor);

   vecEmpresas : ordenar.Arreglo.tipoVec;

   procedure Dias_sin_accidentes (vector : in out ordenar.Arreglo.tipoVec) is
   begin
      --asumo que el vector esta lleno
      ordenar.Ordrapida (vector, indice'First, indice'Last); --Ordeno el vector

      Put_Line ("5 equipos con menos accidentes ordenados de menor a mayor: ");
      for i in 1 .. 5 loop
         -- imprimo los 5 equipos con menos accidentes
         -- ordenar.Arreglo.tipoVec.put (vector (i));
         put (vector (i));
      end loop;

   end Dias_sin_accidentes;

begin
   null;
end;
