with ABB;
with Lista;

procedure main is

   procedure put (s : in string) is
   begin
      null;
   end;

   package arbolString is new ABB (String, "<", ">", "=", put);
   unArbol : arbolString.Tipoarbol;

   package listaString is new Lista (String);
   lista : listaString.TipoLista;

   procedure listarConC
     (arbol : in arbolString.Tipoarbol; lista : out listaString.TipoLista)
   is
      auxString : String;
   begin
      if not arbolString.Vacio (arbol) then
         if not arbolString.Vacio (arbolString.izq (arbol)) then
            listarConC (arbolString.izq (arbol), lista);
         end if;
         auxString := arbolString.Info (arbol);
         if auxString (1) = 'c' or else auxString (1) = 'C' then
            listaString.Insertar (lista, auxString);
         end if;
         if not arbolString.Vacio (arbolString.Der (arbol)) then
            listarConC (arbolString.der (arbol), lista);
         end if;
      end if;
   end listarConC;
begin

end;
