WITH Ada.Text_Io; USE Ada.Text_Io;
WITH Ada.Integer_Text_Io; USE Ada.Integer_Text_Io;
WITH Ada.Numerics.Elementary_Functions; USE Ada.Numerics.Elementary_Functions;

PROCEDURE Prime_Finder IS
   -- This program finds and lists all the prime number
   -- within an input upper bound

   -- Number type
   TYPE Number_Type IS (Prime, Composite);

   -- Variable:
   Upper_bound : integer;    -- Upper bound input by user

   PROCEDURE Prime_Identifier (X : IN Integer;
         Status : OUT Number_Type) IS
     -- This subprogram identifies if an input integer is
     -- composite or prime
      Max_Factor : Integer;
      Factor : Integer;

   BEGIN
      Max_Factor := Integer (Sqrt(Float(X)));
      Factor := 2;
      Factorization:
         LOOP
         EXIT Factorization WHEN Factor > Max_Factor OR
            X rem Factor = 0;
         Factor := Factor + 1;
      END LOOP Factorization;

      IF X rem Factor = 0 THEN
         Status := Composite;
      ELSE
         Status := Prime;
      END IF;
   END Prime_Identifier;

   Status : Number_Type; -- whether a number is composite or prime
   Number : Integer;     -- a number within the given range

BEGIN
   Put ("Enter an upper bound to be analyzed: ");
   Get (Upper_Bound);
   Put ("The prime numbers from 0 to ");
   Put (Upper_Bound, Width => 0);
   Put (" are:");
   New_Line;
   Put ("2 ");
   put ("3 ");
   Number := 2;
   Prime_Lister:
      LOOP
      EXIT Prime_Lister WHEN Number > Upper_Bound;
      Prime_Identifier (Number, Status);
      IF Status = Prime THEN
         Put (Number, Width => 0);
         Put (" ");
      END IF;
      Number := Number + 1;
   END LOOP Prime_Lister;
END Prime_Finder;




