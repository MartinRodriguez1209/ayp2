with turno, Ada.Text_IO;
with Lista;
use ada.Text_IO;

procedure Main is

   use Turno;

   function compararDni (T : TipoTurno; DNI : String) return Boolean is
   begin
      return DNI (T) = DNI;
   end compararDni;

   package nuevaLista is new Lista (Turno.TipoTurno, compararDni);
   use nuevaLista;

   unaLista : TipoLista;
   unTurno  : TipoTurno;
   turnoAux : TipoTurno;

begin
   Turno.Crear (unTurno, "abcde", "16:00", "AAAAA", "12345", "motiv");
   nuevaLista.Insertar (unaLista, unTurno);

   turnoAux := nuevaLista.Buscar (unaLista, "12345");

end Main;
