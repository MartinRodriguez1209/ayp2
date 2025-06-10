with vecgenerico;
generic
   type Tipodato is private;
   type Indice is (<>);
   with procedure Put (X: in tipodato);
   with procedure Get (X: out tipodato);
   with function "<=" (A, B: in tipodato) return Boolean;
   with function "<" (A, B: in Tipodato) return Boolean;
   
   package Mergesort is  
      
      package Arreglo is new Vecgenerico(Tipodato, Indice, Put, Get);
      use Arreglo;	 
      procedure Leer(Datos: out Tipovec);
      procedure Imprimir (Datos : in Tipovec);
      procedure Ordmezcla (Datos: in out Tipovec; Primero, Ultimo: in Indice);         
      procedure Mezclar (Datos: in out Tipovec; Izqprim,Izqult, Derprim,Derult: in Indice); 
        
   end Mergesort;
  
   