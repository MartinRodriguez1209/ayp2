with ada.Text_IO, ada.Integer_Text_IO, lista;
use ada.Text_IO, ada.Integer_Text_IO;

procedure main is

   type partidaAjedrez is record
      numeroJugador : integer;
      tiempoPartida : integer;
      ultimaPieza   : Character;

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
      pieza  : Character;
      condic : integer;

   begin
      condic := 1;
      while condic = 1 loop
         Put_Line ("ingrese el numero del jugador");
         Get (numero);
         Put_Line ("ingrese el tiempo de partida, el maximo es 10");
         get (tiempo);
         Put_Line ("ingresa la ultima pieza movida");
         Get (pieza);
         partidaAux.numeroJugador := numero;
         partidaAux.tiempoPartida := tiempo;
         partidaAux.ultimaPieza := pieza;
         listaEnlazada.Insertar (listaPartidas, partidaAux);
         Put_Line ("desea seguir cargando partidas? 1 SI / 0 NO");
         Get (condic);
      end loop;

   end cargarPartidas;

   procedure obtenerListas
     (listaPartidas : in listaEnlazada.TipoLista;
      lista1        : out listaEnlazada.TipoLista;
      lista2        : out listaEnlazada.TipoLista) is
   begin
      listaAux := listaPartidas;
      while not listaEnlazada.Vacia (listaAux) loop
         partidaAux := listaEnlazada.Info (listaAux);
         if partidaAux.tiempoPartida = 10 and partidaAux.ultimaPieza = 'r' then
            listaEnlazada.Insertar (lista1, partidaAux);
         elsif partidaAux.ultimaPieza = 'p' and partidaAux.tiempoPartida < 10
         then
            listaEnlazada.insertar (lista2, partidaAux);
         end if;
         listaAux := listaEnlazada.Sig (listaAux);
      end loop;
   end obtenerListas;

   procedure imprimirLista (lista : in listaEnlazada.TipoLista) is
   begin

      listaAux := lista;
      while not listaEnlazada.vacia (listaAux) loop
         partidaAux := listaEnlazada.Info (listaAux);
         Put_Line
           ("numero de jugador: " & integer'Image (partidaAux.numeroJugador));
         Put_Line
           ("tiempo de partida: " & integer'Image (partidaaux.tiempoPartida));
         Put_Line
           ("ultima pieza: " & Character'Image (partidaaux.ultimaPieza));
         listaAux := listaEnlazada.Sig (listaAux);
      end loop;

   end imprimirLista;

begin

   cargarPartidas;
   obtenerListas (listaPartidas, lista1, lista2);
   Put_Line ("partidas cuya ultima pieza es el rey y terminaron por tiempo:");
   imprimirLista (lista1);
   Put_Line
     ("partidas cuya ultima pieza es un peon y terminaron por jaque mate:");
   imprimirLista (lista2);

end main;
