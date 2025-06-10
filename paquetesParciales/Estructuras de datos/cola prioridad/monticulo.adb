
package body Monticulo is

procedure intercambiar(Izq, Der: in out TipoElemento) is
Temp: TipoElemento;
begin
Temp:= Izq; Izq:= Der; Der:= Temp;
end intercambiar;


   
function HijoMayor (vm: VecMonticulo) return Positive is 
HijoIzq, HijoDer: Positive;
begin
HijoIzq:= vm'First * 2;
HijoDer:= vm'First * 2 + 1;
   if Hijoder > Vm'Last then return Hijoizq; --HijoDer fuera de rango
   else
      if Vm(Hijoizq) > Vm(Hijoder) then return Hijoizq; --no hay orden
      else return Hijoder;
      end if;
end if;
end HijoMayor; 
   



procedure RestaurarAbajo (vm: in out VecMonticulo) is
raiz, mayor: Positive;
begin
raiz := vm'First;
if raiz <= vm'Last / 2 then
mayor:= HijoMayor(vm);
if vm(mayor) > vm(raiz) then
intercambiar(vm(Raiz), vm(mayor));
RestaurarAbajo(vm(mayor..vm'Last));
end if;
end if;
end RestaurarAbajo;


procedure RestaurarArriba (vm: in out VecMonticulo) is
ultimo, padre: Positive;
begin
ultimo := vm'Last;
if ultimo > vm'First then padre:= ultimo / 2;
if vm(ultimo) > vm(padre) then
intercambiar(vm(padre), vm(ultimo));
RestaurarArriba(vm(vm'First..padre));
end if;
end if;
end RestaurarArriba;


end Monticulo;