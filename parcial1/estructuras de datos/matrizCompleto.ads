generic
   type Tipodato is private;
   type fila is range <>;
   type Columna is range <>;
   with function "+" (A, B : in Tipodato) return Tipodato;
   with function "*" (A, B : in Tipodato) return Tipodato;
   with function "-" (A, B : in Tipodato) return Tipodato;
   with function ">" (A, B : in Tipodato) return Boolean;
   with function "<" (A, B : in Tipodato) return Boolean;
   with procedure Put (A : in Tipodato);
   with procedure get (A : out tipodato);

package matrizCompleto
is
   type Matgeneric is array (Fila, Columna) of Tipodato;
   type Mattranspuesta is array (Columna, Fila) of Tipodato;
   procedure Leer (Mat : out Matgeneric);
   procedure Imprimir (Mat : in Matgeneric);
   procedure Imprimirtras (Mat : in Mattranspuesta);
   procedure Busqueda
     (Mat                 : in Matgeneric;
      A                   : in Tipodato;
      Encontrado          : out Boolean;
      Posi_fila, posi_col : out Integer);
   procedure Ordenamiento (Mat : in out Matgeneric);
   procedure Comparacion (Mat1, Mat2 : Matgeneric; porcentaje : in Float);
   procedure Trasposicion
     (Mat : in out Matgeneric; mataux : out Mattranspuesta);
end matrizCompleto;
