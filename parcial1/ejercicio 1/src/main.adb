with ada.Text_IO, ada.Integer_Text_IO, lista;
use ada.Text_IO, ada.Integer_Text_IO;

procedure main is

   type partidaAjedrez is record
      numeroJugador : integer;
      tiempoPartida : integer;

   end record;

   package listaEnlazada is new Lista (partidaAjedrez);

   listaPartidas : listaEnlazada.TipoLista;
   lista1        : listaEnlazada.TipoLista;
   lista2        : listaEnlazada.TipoLista;
   listaAux      : listaEnlazada.TipoLista;
   partidaAux    : partidaAjedrez;

   procedure cargarPartidas is
      numero : Integer;
      tiempo : Integer;
      condic : integer;

   begin
      condic := 1;
      while condic = 1 loop
         Put_Line ("ingrese el numero del jugador");
         Get (numero);
         Put_Line ("ingrese el tiempo de partida, el maximo es 10");
         get (tiempo);
         partidaAux.numeroJugador := numero;
         partidaAux.tiempoPartida := tiempo;
         listaEnlazada.Insertar (listaPartidas, partidaAux);
         Put_Line ("desea seguir cargando partidas? 1 SI / 0 NO");
         Get (condic);
      end loop;

   end;

begin

   cargarPartidas;

end main;
