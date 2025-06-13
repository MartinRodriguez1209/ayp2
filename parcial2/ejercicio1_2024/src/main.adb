with ada.Text_IO; use ada.Text_IO;
with Lista;
with ABB;

procedure main is

   type palabraDic is record
      palabra    : string (1 .. 40);
      definicion : string (1 .. 200);
   end record;

   package listaPalabras is new Lista (palabraDic);

   type nodoArbol is record
      letra    : Character;
      palabras : listaPalabras.TipoLista;
   end record;

   function menor (X, Y : nodoArbol) return Boolean is
   begin
      return x.letra < y.letra;
   end;
   function mayor (X, Y : nodoArbol) return Boolean is
   begin
      return x.letra > y.letra;
   end;
   function igual (X, Y : nodoArbol) return Boolean is
   begin
      return x.letra = y.letra;
   end;
   procedure Put (X : in nodoArbol) is
   begin
      null;
   end;

   package arbolPalabras is new ABB (nodoArbol, menor, mayor, igual, put);

   procedure nuevaPalabra
     (palabra : in palabraDic; arbol : arbolPalabras.Tipoarbol)
   is
      primeraLetra    : Character;
      arbolAux        : arbolPalabras.Tipoarbol;
      nodoaux         : nodoArbol;
      listaAux        : listaPalabras.TipoLista;
      nuevaDefinicion : string (1 .. 200);
      registroAux     : palabraDic;
   begin
      primeraLetra := palabra.palabra (1);
      arbolAux := buscarNodoLetra (primeraLetra, arbol);
      nodoaux := arbolPalabras.Info (arbolAux);
      listaAux := nodoaux.palabras;

      while not listaPalabras.Vacia (listaAux) loop
         if listaPalabras.Info (listaAux).palabra = palabra.palabra then
            registroAux := listaPalabras.Info (listaAux).palabra;
            Put_Line ("Se encontro la palabra, ingrese la nueva definicion");
            get (nuevaDefinicion);
            listaPalabras.Suprimir (listaAux, registroAux);
            registroAux.definicion := nuevaDefinicion;
            listaPalabras.Insertar (listaAux, registroAux);
         end if;
      end loop;

   end;

   function buscarNodoLetra
     (letra : in Character; arbol : in arbolPalabras.Tipoarbol)
      return arbolPalabras.Tipoarbol
   is
      ptr : arbolPalabras.Tipoarbol := arbol;
   begin
      while not arbolPalabras.Vacio (ptr) loop
         if arbolPalabras.Info (ptr).letra = letra then
            return ptr;
         else
            if arbolPalabras.Info (ptr).letra > letra then
               ptr := arbolPalabras.Izq (ptr);
            else
               ptr := arbolPalabras.Der (ptr);
            end if;
         end if;
      end loop;
   end;

begin
   null;
end Main;
