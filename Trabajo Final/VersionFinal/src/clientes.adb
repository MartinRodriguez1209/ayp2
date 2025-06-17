with Clientes;

package body Clientes is

   function compararCliente
     (cliente : in Tipocliente; dni : in Integer) return boolean is
   begin
      return cliente.Dni = dni;
   end compararCliente;

   function Ajustarstring (Texto : String; Longitud : Positive) return String is
      
      Resultado : String (1 .. Longitud);
      
      Len : Natural := Texto'Length;
      
      To_Copy : Natural;
      
   begin
      
      if Len > Longitud then
         
         To_Copy := Longitud;
         
      else
         
         To_Copy := Len;
         
      end if;
      Resultado := (others => ' ');      
      Resultado (1 .. To_Copy) := Texto (Texto'First .. Texto'First + To_Copy - 1);
      
      return Resultado;
      
   end Ajustarstring;
   

   function crear
     (nombre   : in string;
      apellido : in string;
      dni      : in natural;
      patente  : in string;
      estado   : in Boolean) return tipocliente
   is

      X : Tipocliente;

   begin

      X.Nombre := Ajustarstring (Nombre, X.Nombre'Length);
      X.Long_Nom := Nombre'Length;

      X.Apellido := ajustarString (apellido, X.Apellido'Length);
      X.Long_Ape := Apellido'Length;

      X.Dni := Dni;

      X.Patente := ajustarString (patente, X.Patente'Length);
      X.Long_Pat := patente'Length;

      x.estado := estado;

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

      if nuevonombre'length <= x.nombre'length then

         X.Nombre := ajustarstring (nuevonombre, x.nombre'length);

      end if;
      return x;
   end Cambiarnombre;

   function getestado (cliente : in tipocliente) return boolean is

   begin
      return cliente.estado;
   end getestado;

   function cambiarapellido
     (cliente : in tipocliente; nuevoape : in string) return tipocliente
   is

      x : tipocliente := cliente;

   begin
      
      X.Apellido := Ajustarstring (Nuevoape, X.Apellido'Length); 
      
      X.Long_Ape := Nuevoape'Length; 
      
      return X;
      
end Cambiarapellido;

   function cambiardni
     (cliente : in tipocliente; nuevodni : in natural) return tipocliente
   is

      x : tipocliente := cliente;

   begin

      x.dni := nuevodni;

      return x;
   end cambiardni;

   function cambiarpatente
     (cliente : in tipocliente; nuevapatente : in string) return tipocliente
   is

      x : tipocliente := cliente;

   begin

      if nuevapatente'length <= x.patente'length then

         x.patente := ajustarstring (nuevapatente, x.patente'length);

      end if;
      return X;
   end cambiarpatente;

end Clientes;
