generic
   type Tipodato is private;
   type fila is range <>;
   type Columna is range <>;
   with procedure Put (A : in Tipodato);
   with procedure get (A : out tipodato);
package matrizSimple is
   type Matgeneric is array (Fila, Columna) of Tipodato;
   procedure Leer (Mat : out Matgeneric);
   procedure Imprimir (Mat : in Matgeneric);
end matrizSimple;
