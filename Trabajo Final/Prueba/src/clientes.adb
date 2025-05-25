package body Clientes is

   function crear
     (nombre   : in string;
      apellido : in string;
      dni      : in natural;
      patente  : in string) return tipocliente
   is
      X : Tipocliente;
   begin
      X.Nombre := Nombre;
      x.Apellido := Apellido;
      X.Dni := Dni;
      X.Patente := Patente;
      x.estado := true;
      return x;
   end Crear;

   function Cambioestado (Cliente : in Tipocliente) return tipocliente is
      x : tipocliente := cliente;
   begin
      if x.Estado = True then
         x.Estado := False;
      else
         x.Estado := True;
      end if;
      return x;
   end Cambioestado;

   function Getdni (Cliente : in Tipocliente) return Natural is
   begin
      return Cliente.Dni;
   end getdni;

   function getnombre (cliente : in tipocliente) return string is
   begin
      return Cliente.nombre;
   end getnombre;

   function getpatente (Cliente : in Tipocliente) return String is
   begin
      return Cliente.patente;
   end getpatente;

   function getapellido (cliente : in tipocliente) return string is
   begin
      return Cliente.apellido;
   end getapellido;

   function cambiarnombre
     (cliente : in tipocliente; nuevonombre : in string) return tipocliente
   is
      x : tipocliente := cliente;

   begin
      X.Nombre := Nuevonombre;
      return x;
   end cambiarnombre;

   function cambiarapellido
     (cliente : in tipocliente; nuevoape : in string) return tipocliente
   is
      x : tipocliente := cliente;
   begin
      X.Apellido := Nuevoape;
      return X;
   end Cambiarapellido;

   function cambiardni
     (cliente : in tipocliente; nuevodni : in natural) return tipocliente
   is
      x : tipocliente := cliente;
   begin
      X.dni := Nuevodni;
      return X;
   end cambiardni;

   function cambiarpatente
     (cliente : in tipocliente; nuevapatente : in string) return tipocliente
   is
      x : tipocliente := cliente;
   begin
      X.patente := Nuevapatente;
      return X;
   end cambiarpatente;

end Clientes;
