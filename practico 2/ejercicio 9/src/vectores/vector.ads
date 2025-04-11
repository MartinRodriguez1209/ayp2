generic
   type Tipodato is private;
   type Indice is range <>;
   Valorinicial : tipodato;
   with function "+" (A, B : in Tipodato) return Tipodato;
   with function "*" (A, B : in Tipodato) return Tipodato;
   with function "-" (A, B : in Tipodato) return Tipodato;
   with function ">" (A, B : in Tipodato) return Boolean;
   with function Raiz (A : in Tipodato) return float;
   with procedure Put (A : in Tipodato);
   with procedure get (A : out tipodato);

package Vector
is
   type VecGeneric is array (Indice) of Tipodato;
   procedure Leer (Vec : out Vecgeneric);
   procedure Imprimir (Vec : in Vecgeneric);
   procedure Busqueda
     (Vec        : in Vecgeneric;
      A          : in Tipodato;
      Encontrado : out Boolean;
      Posi       : out Integer);
   procedure Ordenamiento (Vec : in out Vecgeneric);
   procedure comparacion (vec1, vec2 : in vecgeneric; compa : out boolean);
end Vector;
