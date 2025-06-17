package Clientes is

   type Tipocliente is private;

   function crear
     (nombre   : in string;
      apellido : in string;
      dni      : in natural;
      patente  : in string;
      estado   : in Boolean) return tipocliente;

   function getdni (cliente : in tipocliente) return natural;
   function getnombre (cliente : in tipocliente) return string;
   function getpatente (Cliente : in Tipocliente) return String;
   function getapellido (cliente : in tipocliente) return string;
   function getestado (cliente : in tipocliente) return boolean;

   function cambiarnombre
     (cliente : in tipocliente; nuevonombre : in string) return tipocliente;
   function cambiarapellido
     (cliente : in tipocliente; nuevoape : in string) return tipocliente;
   function cambiardni
     (cliente : in tipocliente; nuevodni : in natural) return tipocliente;
   function cambiarpatente
     (cliente : in tipocliente; nuevapatente : in string) return tipocliente;

   function cambioestado (cliente : in tipocliente) return tipocliente;
   function compararCliente
     (cliente : in Tipocliente; dni : in Integer) return boolean;

private

   type Tipocliente is record

      nombre   : string (1 .. 40);
      Long_Nom : Natural;

      Apellido : String (1 .. 25);
      Long_Ape : Natural;

      Dni : Natural;

      patente  : string (1 .. 10);
      Long_Pat : Natural;

      Estado : Boolean;

   end record;

end clientes;
