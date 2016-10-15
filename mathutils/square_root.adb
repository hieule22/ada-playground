WITH Ada.Float_Text_IO; USE Ada.Float_Text_IO;
with Ada.Text_IO; Use Ada.Text_IO;

PROCEDURE Square_Root IS
   X : Float RANGE 0.00..Float'Last;
   Approx : Float;
   Tolerance : CONSTANT Float := 1.00;

BEGIN
   Put (Item => "Enter a non-negative number to be square-rooted: ");
   Get (Item => X);
   Approx := X/2.0;
   Calculate_Square_Root:
      LOOP
      EXIT Calculate_Square_Root WHEN ABS(Approx**2 - X) < Tolerance;
      Approx := 0.5 * (Approx + X/Approx);
   END LOOP Calculate_Square_Root;
   Put (Item => "The square root of ");
   Put (Item => X,
      Fore => 5,
      Aft => 2,
      Exp => 0);
   Put (Item => " is: ");
   Put (Item => Approx,
      Fore => 3,
      Aft => 5,
      Exp => 0);
END Square_Root;
