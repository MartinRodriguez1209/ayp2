with Ada.Integer_Text_IO;
with Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;
with Unchecked_Deallocation;

procedure main is
   type pInt is access Integer;
   pUno : pInt;
   pDos : pInt;

   type pun is access integer;
   b       : integer;
   a, c, d : pun;

   procedure ejercicio6a is
   begin
      pUno := new Integer;
      pUno.all := 5;
      pDos := pUno;
      pDos.all := pDos.all * 2;
      put (pUno.all);
   end ejercicio6a;

   procedure free is new Unchecked_Deallocation (Integer, pun);

   procedure ejercicio6c is
   begin
      a := new integer;
      a.all := 3;
      b := 5;
      c := new integer;
      d := c;
      d.all := a.all;
      c := a;
      c.all := b;
      put (a.all);
      put (' ');
      put (b);
      put (' ');
      put (c.all);
      put (' ');
      put (d.all);
      new_line;
      c := d;
      c.all := 2;
      put (a.all);
      put (' ');
      put (b);
      put (' ');
      put (c.all);
      put (' ');
      put (d.all);
      free (d);
   end;

begin
   Put_Line ("resultado de prueba del ejercicio a");
   ejercicio6a;
   New_Line;
   Put_Line ("resultado de prueba del ejercicio c");
   New_Line;
   ejercicio6c;
end main;
