with Lista;
with Clientes;
with turno;
with Mecanico;
with Reparacion;

generic

   type TipoClave is private;
   with package listaC is new
     Lista (Clientes.Tipocliente, Integer, clientes.compararCliente);
   with package listaT is new
     Lista (turno.TipoTurno, Integer, turno.compararDniCliente);
   with package listaR is new
     Lista
       (Reparacion.TipoReparacion,
        Reparacion.ClaveCadena,
        Reparacion.BuscarReparacion);
   with package listaM is new
     Lista (Mecanico.Tipomecanico, Integer, mecanico.compararDniMecanico);

package Data
is
   -- PROCEDIMIENTOS DE LECTURA DE ARCHIVOS
   procedure cargarTurnos (listaFinal : out listaT.TipoLista);

   procedure cargarClientes (listaFinal : out listaC.TipoLista);

   procedure cargarMecanicos (listaFinal : out listaM.TipoLista);

   procedure cargarReparaciones (listaFinal : out listaR.TipoLista);

   -- PROCEDIMIENTOS DE ESCRITURA DE ARCHIVOS
   procedure guardarTurnos (listaFinal : in listaT.TipoLista);

   procedure guardarClientes (listaFinal : in listaC.TipoLista);

   procedure guardarMecanicos (listaFinal : in listaM.TipoLista);

   procedure guardarReparaciones (listaFinal : in listaR.TipoLista);

end Data;
