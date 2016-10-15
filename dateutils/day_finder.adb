WITH Ada.Text_Io, Ada.Integer_Text_Io;
USE Ada.Text_Io, Ada.Integer_Text_Io;

PROCEDURE Day_Finder IS
   -- This program finds the day of the week for any given date

   -- Declaration of weekday:
   TYPE Week_Day_Type IS (Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday);
   PACKAGE Week_Day_Io IS NEW Ada.Text_Io.Enumeration_Io (Enum => Week_Day_Type);

   -- Variables:
   Y : Integer;
   M : Integer;
   D : Integer;

   -- Modularity
   W : Integer;
   Week_Day : Week_Day_Type;

BEGIN
   Put ("Put a date (MM DD YYYY): ");
   Get (M);   Get(D);   Get(Y);

   -- Exceptions
   IF M = 1 OR M = 2 THEN
      Y := Y - 1;
   END IF;

   IF M =1 AND D = 1 AND Y = 2000 THEN
      M := 11;
   ELSIF M = 12 AND D = 31 AND Y = 2000 THEN
      M := 10;
   ELSIF M = 4 AND D = 30 AND Y = 1777 THEN
      M := 2;
   ELSIF M = 10 AND D = 4 AND Y = 1582 THEN
      M := 8;
   ELSIF M = 1 AND D = 1 AND Y = 0 THEN
      M := 11;
   END IF;

   -- Assignment of derived variables
   M := (M + 10) rem 12;

   -- Calculate weekday for input date
   W := (D + Integer(2.6*Float(M) - 0.2 - 0.5) + 5*(Y rem 4) + 4*(Y rem 100)
      + 6*(y rem 400)) rem 7;

   -- Output weekday
   Put ("Result: ");
   Week_Day := Week_Day_Type'Val (W);
   Week_Day_Io.Put (Week_Day);

END Day_Finder;
