with vecgenerico;
generic
   type Tipoelem is private;
   type Indice is (<>);
   with procedure Put (X: in Tipoelem);
   with procedure Get (X: out Tipoelem);
   with function "<=" (A, B: in Tipoelem) return Boolean;
   with function ">" (A, B: in Tipoelem) return Boolean;
   
   package Quicksort is  

      package Arreglo is new Vecgenerico(Tipoelem, Indice, Put, Get);
      use Arreglo;
      procedure Leer(Datos: out Tipovec);
      procedure Imprimir (Datos : in Tipovec);
      procedure Ordrapida (Datos: in out Tipovec; Primero, Ultimo: in Indice);
      procedure Dividir (Datos: in out TipoVec; Primero, Ultimo: in Indice; Puntodivision: in out Indice);   
      
   end Quicksort;
   
