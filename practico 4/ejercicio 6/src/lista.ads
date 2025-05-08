generic-- especificación del paquete de lista enlazada no ordenada
   type Tipoelem is private; 
   package Lista is
      type Tipolista is private;
      Listavacia: exception;
      procedure Crear (Lista: out Tipolista); 
      function Vacia (Lista: Tipolista) return Boolean;
      function Esta (Lista: Tipolista; Elem: Tipoelem) return Boolean;
      procedure Insertar (Lista: in out Tipolista; Elemento: in Tipoelem);
      procedure Suprimir (Lista: in out Tipolista; Elemento: in Tipoelem);
      procedure Limpiar (Lista: in out Tipolista);
      function Info (Lista: in Tipolista) return Tipoelem;
      function Sig (Lista: in Tipolista) return Tipolista; 
 
      private
      type Tiponodo;
      type Tipolista is access Tiponodo;
      type Tiponodo is record
         Info: Tipoelem;
         Sig: Tipolista;
      end record;
   end Lista;

