WITH Ada.Text_Io;         USE Ada.Text_Io;
WITH Ada.Integer_Text_Io; USE Ada.Integer_Text_Io;

   PROCEDURE Factorial_Calculator IS
      -- This procedure calculates the factorial of a positive integer
      FUNCTION Factorial (N : IN Integer) RETURN Integer IS
      BEGIN
         IF N = 0 THEN
            RETURN 1;
         ELSE
            RETURN N * Factorial (N-1);
         END IF;
      END Factorial;
      -- Variable declaration
     X : Integer;

   BEGIN
      Put (Item => "Input a number to be factorialed: ");
      Get (Item => X);
      Put (X, Width => 1);
      Put ("! = ");
      Put (Factorial(X), Width => 1);
   END Factorial_Calculator;