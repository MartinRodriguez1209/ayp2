generic
   type Tipodato is private;
   type Indice is range <>;
   Valorinicial : tipodato;
   with procedure Put (A : in Tipodato);
   with procedure get (A : out tipodato);

package Crearpackage
is
   type VecGeneric is array (Indice) of Tipodato;
   procedure Leer (Vec : out Vecgeneric);
   procedure Imprimir (Vec : in Vecgeneric);
end Crearpackage;
