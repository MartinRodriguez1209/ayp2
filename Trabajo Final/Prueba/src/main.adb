with turno, Ada.Text_IO;
with Lista;
use Ada.Text_IO;

procedure Main is

   use turno;

   package nuevaLista is new Lista (turno.TipoTurno, turno.compararDni);
   use nuevaLista;

   unaLista : TipoLista;
   unTurno  : TipoTurno;
   turnoAux : TipoTurno;

begin
   unTurno := turno.Crear ("abcde", "16:00", "AAAAA", "12345", "motiv");
   nuevaLista.Insertar (unaLista, unTurno);

   turnoAux := nuevaLista.Buscar (unaLista, "12345");
   turno.putTurno (turnoAux);
   turno.setFecha (turnoAux, "acabc");
   turno.putTurno (turnoAux);

end Main;
