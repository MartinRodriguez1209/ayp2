with Lista;

generic
   with package ListaMecanico is new Lista (<>);
   with package Listamotivos is new Lista (<>);
   with function Obtenernombre (L : Listamecanico.Tipoelem) return String;
   with
     function Obtenerespecialidad (L : Listamecanico.Tipoelem) return String;
   with function obtenerapellido (L : Listamecanico.Tipoelem) return String;
   with function getmotivos (L : Listamotivos.tipoelem) return string;
package Reportes is

   procedure Listar_Mecanicos_Por_Especialidad
     (L : in ListaMecanico.Tipolista; Especialidad : in String);

   procedure Listar_problemas
     (L : in Listamotivos.tipolista); --listamotivos es lista de turnos

end Reportes;
