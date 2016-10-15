WITH Ada.Text_IO; USE Ada.Text_Io;
WITH Ada.Integer_Text_IO; USE Ada.Integer_Text_IO;
WITH Ada.Float_Text_IO; USE Ada.Float_Text_Io;

PROCEDURE Fibonacci IS
   Number_Of_Terms : Integer := 10;
   Count : Integer;
   A : Integer;
   B : Integer;
   C : Float;
   D : Float;


BEGIN
   Count := 1;
   A := 1;
   B := 1;
   Put (Item => A, Width => 1);
   New_Line;
   Put (Item => B, Width => 1);
   New_Line;
   Sequence:
      LOOP
      EXIT Sequence WHEN Count > Number_Of_Terms;
      A := A + B;
      C := Float(A) / Float(B);
      Put (Item => A, Width => 1);
      Put (Item => "---");
      Put (Item => C,
         Fore => 2,
         Aft => 8,
         Exp => 0);
      New_Line;
      B := A + B;
      D := Float(B) / Float(A);
      Put (Item => B, Width => 1);
      Put (Item => "---");
      Put (Item => D,
         Fore => 2,
         Aft => 8,
         Exp => 0);
      Count := Count + 1;
      New_Line;
   END LOOP Sequence;
END Fibonacci;
