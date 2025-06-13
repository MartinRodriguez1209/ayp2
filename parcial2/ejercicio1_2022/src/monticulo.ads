generic
type TipoElemento is private;
type VecMonticulo is array (Positive range <>) of TipoElemento;
with function ">" (x, y: in TipoElemento) return Boolean;

package Monticulo is
procedure intercambiar (izq,der: in out tipoelemento);
function Hijomayor (vm: in vecmonticulo) return positive;
procedure RestaurarAbajo (vm: in out VecMonticulo);
procedure RestaurarArriba (vm: in out VecMonticulo);
end Monticulo;