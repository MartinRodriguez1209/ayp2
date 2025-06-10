generic
type Tipodato is private;
type Fila is (<>); 
with procedure put (x: in Tipodato);
with procedure get (x: out Tipodato);






package vecgenerico is
   type tipoVec is array (fila) of Tipodato;
   procedure leer (vec: out tipoVec);
   procedure imprimir (vec: in tipoVec);
end vecgenerico;