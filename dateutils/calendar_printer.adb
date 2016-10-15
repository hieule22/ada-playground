WITH Ada.Text_Io, Ada.Integer_Text_Io;
USE Ada.Text_Io, Ada.Integer_Text_Io;

PROCEDURE Calendar_Printer IS
   -- This procedure asks for an input consisting of a specific
   -- month of a specific year and prints a calendar for that
   -- month
   -- Type declaration
   TYPE Month_Type IS (January, February, March, April, May, June,
      July, August, September, October, November, December);
   TYPE Year_Type IS RANGE 1900..2099;
   TYPE Day_Type IS (Monday, Tuesday, Wednesday, Thursday, Friday,
      Saturday, Sunday);

   -- Package instantiation
   PACKAGE Month_Io IS NEW Ada.Text_Io.Enumeration_Io (Enum => Month_Type);
   PACKAGE Year_Io IS NEW Ada.Text_Io.Integer_Io (Num => Year_Type);
   PACKAGE Day_Io IS NEW Ada.Text_Io.Enumeration_Io (Enum => Day_Type);

   Function Day_of_Week (Month : IN Month_Type;
                           Day : IN Integer;
                          Year : IN Year_Type) RETURN Day_Type IS
            -- This subprogram determines the day of the week for
            -- an input date
      Y : Integer;
      M : Integer;
      D : Integer;
      W : Integer;
   BEGIN
      Y := Integer(Year);
      M := Month_Type'Pos(Month)+1;
      D := Integer(Day);
      -- Exceptions
      IF Month in January..February THEN
         Y := Y - 1;
      END IF;
      IF Month = January AND Day = 1 AND Year = 2000 THEN
         M := 11;
      ELSIF Month = December AND Day = 31 AND Year = 2000 THEN
         M := 10;
      ELSIF Month = April AND Day = 30 AND Year = 1777 THEN
         M := 2;
      ELSIF Month = October AND Day = 4 AND Year = 1582 THEN
         M := 8;
      ELSIF Month = January AND Day = 1 AND Year = 0 THEN
         M := 11;
      END IF;

      IF Month = February THEN
         M := 12;
      ELSE
         M := (M + 10) rem 12;
      END IF;

      W := (D + Integer(2.6*Float(M) - 0.7) + 5*(Y rem 4) +
         4*(Y rem 100) + 6*(Y rem 400)) rem 7;

      CASE W IS
         WHEN 0 => RETURN Sunday;
         WHEN 1 => RETURN Monday;
         WHEN 2 => RETURN Tuesday;
         WHEN 3 => RETURN Wednesday;
         WHEN 4 => RETURN Thursday;
         WHEN 5 => RETURN Friday;
         WHEN 6 => RETURN Saturday;
         WHEN OTHERS => NULL;
      END CASE;
   END Day_Of_Week;

   -- Variables
   Year  : Year_Type;
   Month_Length : Integer range 1..31;

BEGIN
   Year := 2014;
   FOR Month IN January..December LOOP
   -- Identify the length of the month
   CASE Month IS
      WHEN January|March|May|July|August|October|December
            => Month_Length := 31;
      WHEN April|June|September|November
            => Month_Length := 30;
      WHEN OTHERS =>
         IF Year rem 4 = 0 THEN Month_Length := 29;
         ELSE Month_Length := 28;
         END IF;
   END CASE;

   Set_Col (13);
   Month_Io.Put (Month);
   Put (" ");
   Year_Io.Put (Year);
   New_Line;

   FOR N IN 1..7 LOOP
      Set_Col (Count(N * 5));
      Put (Day_Type'Image (Day_Type'Val (N-1)) (1..2));
   END LOOP;

   FOR A IN 1..Month_Length LOOP
      IF Day_Of_Week (Month,A,Year) = Monday and A > 1 THEN
         New_Line;
      END IF;
      Set_Col (Day_Type'Pos(Day_Of_Week (Month, A, Year)) * 5 + 5);
         Put (A,0);
      END LOOP;

       New_Line(2);
   END LOOP;

END Calendar_Printer;
