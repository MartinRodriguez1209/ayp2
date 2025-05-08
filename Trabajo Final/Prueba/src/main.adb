with turno, Ada.Text_IO;
with Lista;
use Ada.Text_IO;

procedure Main is

   use turno;

   function compararDni (T : TipoTurno; DNI : String) return Boolean is
   begin
      return turno.getDNI (T) = DNI;
   end compararDni;

   package nuevaLista is new Lista (turno.TipoTurno, compararDni);
   use nuevaLista;

   unaLista : TipoLista;
   unTurno  : TipoTurno;
   turnoAux : TipoTurno;

begin
   unTurno := turno.Crear ("abcde", "16:00", "AAAAA", "12345", "motiv");
   nuevaLista.Insertar (unaLista, unTurno);

   turnoAux := nuevaLista.Buscar (unaLista, "12345");

end Main;
