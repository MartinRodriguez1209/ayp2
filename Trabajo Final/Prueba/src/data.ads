with Lista;
with Clientes;
with turno;
with Mecanico;
with Reparacion;

package data is
   subtype CadenaClave is String (1 .. 10);
   package listaC is new
     Lista (Clientes.Tipocliente, integer, clientes.compararCliente);
   package listaT is new
     lista (turno.TipoTurno, Integer, turno.compararDniCliente);
   package listaR is new
     lista
       (Reparacion.TipoReparacion,
        CadenaClave,
        Reparacion.BuscarReparacion);
   package listaM is new
     lista (Mecanico.Tipomecanico, integer, mecanico.compararDniMecanico);

   -- PROCEDIMIENTOS DE LECTURA DE ARCHIVOS
   procedure cargarTurnos (listaFinal : out listat.TipoLista);

   procedure cargarClientes (listaFinal : out listaC.TipoLista);

   procedure cargarMecanicos (listaFinal : out listaM.TipoLista);

   procedure cargarReparaciones (listaFinal : out listaR.TipoLista);

   --PROCEDIMIENTOS DE ESCRITURA DE ARCHIVOS

   procedure guardarTurnos (listaFinal : in listat.TipoLista);

   procedure guardarClientes (listaFinal : in listac.TipoLista);

   procedure guardarMecanicos (listafinal : in listaM.TipoLista);

   procedure guardarReparaciones (listaFinal : in listaR.TipoLista);

end data;
