package body vecgenerico is

procedure leer (vec: out tipoVec) is
begin
for i in fila'range loop
get (vec (i));
end loop;
end Leer;


procedure imprimir (vec: in tipoVec) is
begin
for i in fila'range loop
put(vec(i));
end loop;
end Imprimir;


end vecgenerico;