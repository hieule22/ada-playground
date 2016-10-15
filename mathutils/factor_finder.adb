WITH Ada.Text_Io; USE Ada.Text_Io;
WITH Ada.Integer_text_Io; USE Ada.Integer_text_Io;

PROCEDURE Factor_Finder IS

   X : Integer;
   Factor : Integer;
   Factor_Count : Integer;

BEGIN

   Put ("Enter a number to be analyzed: ");
   Get (Item => X);
   Put ("The factors of X are: ");

   Factor_Count := 0;
   Factor := 1;
   Factorization:
      LOOP
         exit Factorization when (Factor > X);
      IF X rem Factor = 0 THEN
         Put (Item => Factor, Width => 0);
         Put (", ");
         Factor_Count := Factor_Count + 1;
      END IF;
      Factor := Factor + 1;

      END LOOP Factorization;
   New_Line;
Put (Item => X, Width => 0);
   IF Factor_Count > 2 THEN
      Put (" is then a composite number with ");
      Put (Factor_Count, Width => 0);
      put (" factors.");
ELSE
   Put (" is then a prime number.");
END IF;

END Factor_finder;
