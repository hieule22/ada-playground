-- Name of Creator    : Hieu T. Le
-- Date of Creation   : October 24, 2014
-- Date of Completion : N/A

WITH Ada.Text_Io, Ada.Integer_Text_Io, Ada.Io_Exceptions;
USE Ada.Text_Io, Ada.Integer_Text_IO;
---------------------------------------------------------------------
PROCEDURE Duration_Calculator IS
   -- This procedure allows user to calculate the number of days
   -- separating two dates

   -- Data types for date representation and their associated packages

   TYPE Day_Type       IS RANGE 1..31;
   TYPE Month_Type     IS RANGE 1..12;
   TYPE Year_Type      IS RANGE 0..2099;
   TYPE Include_Choice IS (Y, N);

   PACKAGE Day_Io    IS NEW Ada.Text_Io.Integer_Io (Num => Day_Type);
   PACKAGE Month_Io  IS NEW Ada.Text_Io.Integer_Io (Num => Month_Type);
   PACKAGE Year_Io   IS NEW Ada.Text_Io.Integer_Io (Num => Year_Type);
   PACKAGE Choice_Io IS NEW Ada.Text_Io.Enumeration_Io (Enum => Include_Choice);

   ---------------------------------------------------------------------
   Function Day_of_Week (Month : IN Month_Type;
                               Day : IN Day_Type;
                              Year : IN Year_Type) RETURN String IS
            -- This subprogram determines the day of the week for
            -- an input date
      Y : Integer;
      M : Integer;
      D : Integer;
      W : Integer;
   BEGIN
      Y := Integer(Year);
      M := Integer(Month);
      D := Integer(Day);
      -- Exceptions
      IF Month IN 1..2 THEN
         Y := Y - 1;
      END IF;
      IF Month = 1 AND Day = 1 AND Year = 2000 THEN
         M := 11;
      ELSIF Month = 12 AND Day = 31 AND Year = 2000 THEN
         M := 10;
      ELSIF Month = 4 AND Day = 30 AND Year = 1777 THEN
         M := 2;
      ELSIF Month = 10 AND Day = 4 AND Year = 1582 THEN
         M := 8;
      ELSIF Month = 1 AND Day = 1 AND Year = 0 THEN
         M := 11;
      END IF;
      M := (M + 10) rem 12;
      W := (D + Integer(2.6*Float(M) - 0.7) + 5*(Y rem 4) +
         4*(Y rem 100) + 6*(Y rem 400)) rem 7;

      CASE W IS
         WHEN 0 => RETURN "Sunday";
         WHEN 1 => RETURN "Monday";
         WHEN 2 => RETURN "Tuesday";
         WHEN 3 => RETURN "Wednesday";
         WHEN 4 => RETURN "Thursday";
         WHEN 5 => RETURN "Friday";
         WHEN 6 => RETURN "Saturday";
         WHEN OTHERS => NULL;
      END CASE;
   END Day_Of_Week;
   ---------------------------------------------------------------------
   PROCEDURE Addition (Month : IN OUT Month_Type;
                         Day : IN OUT Day_Type;
                        Year : IN OUT Year_Type;
                    Increase : IN Integer) IS
    -- This subprogram appends a specific number of days to an input date
      Count : Integer;
   BEGIN
      Count := 0;   -- Initialize counter to
      LOOP
         EXIT WHEN Count = Increase;
         CASE Month IS
            WHEN 1|3|5|7|8|10 =>
               IF Day = 31 THEN
                  Day := Day_Type'First;
                  Month := Month_Type'Succ(Month);
               ELSE
                  Day := Day_Type'Succ(Day);
               END IF;
            WHEN 4|6|9|11 =>
               IF Day = 30 THEN
                  Day := Day_Type'First;
                  Month := Month_Type'Succ(Month);
               ELSE
                  Day := Day_Type'Succ(Day);
               END IF;
            WHEN 2 =>
               IF Year rem 4 = 0 THEN
                  IF Day = 29 THEN
                     Day := Day_Type'First;
                     Month := Month_Type'Succ(Month);
                  ELSE
                     Day := Day_Type'Succ(Day);
                  END IF;
               ELSE
                  IF Day = 28 THEN
                     Day := Day_Type'First;
                     Month := Month_Type'Succ(Month);
                  ELSE
                     Day := Day_Type'Succ(Day);
                  END IF;
               END IF;
            WHEN 12 =>
               IF Day = 31 THEN
                  Day := Day_Type'First;
                  Month := Month_Type'First;
                  Year := Year_Type'Succ(Year);
               ELSE
                  Day := Day_Type'Succ(Day);
              END IF;
         END CASE;
         Count := Integer'Succ(Count);   -- Increment counter
      END LOOP;
   END Addition;
   ---------------------------------------------------------------------
   PROCEDURE Fetch_Data (Start_Month : OUT Month_Type;
                           Start_Day : OUT Day_Type;
                          Start_Year : OUT Year_Type;
                           End_Month : OUT Month_Type;
                             End_Day : OUT Day_Type;
                            End_Year : OUT Year_Type;
                              Choice : OUT Include_Choice) IS
       -- This subprogram fetches data from user
   BEGIN
      -- Prompt user to input start date
      Validation_Loop:
         LOOP
         Put ("Input start date (MM DD YYYY): ");
         Input_Block:
            BEGIN
               Month_Io.Get (Start_Month);
               Day_Io.Get   (Start_Day);
               Year_Io.Get  (Start_Year);
               EXIT Validation_Loop;
            EXCEPTION
               WHEN Ada.Io_Exceptions.Data_Error | Constraint_Error =>
                  Put ("Data entered is not valid");
                  Skip_Line;
                  New_Line;
               WHEN OTHERS =>
                  Put ("Some other exception was raised.");
                  New_Line;
            END Input_Block;
         END LOOP Validation_Loop;

      -- Prompt user to input end date
      Put ("Input end date   (MM DD YYYY): ");
      Month_Io.Get (End_Month);
      Day_Io.Get   (End_Day);
      Year_Io.Get  (End_Year);
      -- Identify if user wants end date included
      Put ("Include end date in calculation (1 date is added) (Y or N): ");
      Choice_Io.Get (Choice);
   END Fetch_Data;
   ----------------------------------------------------------------------
   PROCEDURE Calculate_Duration (Start_Month : IN Month_Type;
                                   Start_Day : IN Day_Type;
                                  Start_Year : IN Year_Type;
                                   End_Month : IN Month_Type;
                                     End_Day : IN Day_Type;
                                    End_Year : IN Year_Type;
                                      Choice : Include_Choice;
                                       Count : out Integer) is
      -- This subprogram calculates the number of days separating two dates
      ------------------------------------------------------------------

      ------------------------------------------------------------------
      PROCEDURE Date_Reader (Month : IN Month_Type;
                               Day : IN Day_Type;
                              Year : IN Year_Type) IS
         -- This subprogram reads a date input in numeric form
         -- and prints it in English
      BEGIN
         -- Print month
         CASE Month IS
            WHEN 1  => Put ("January");
            WHEN 2  => Put ("February");
            WHEN 3  => Put ("March");
            WHEN 4  => Put ("April");
            WHEN 5  => Put ("May");
            WHEN 6  => Put ("June");
            WHEN 7  => Put ("July");
            WHEN 8  => Put ("August");
            WHEN 9  => Put ("September");
            WHEN 10 => Put ("October");
            WHEN 11 => Put ("November");
            WHEN 12 => Put ("December");
         END CASE;
         -- Print day
         Put (" the ");
         CASE Day IS
            WHEN 10 => Put ("tenth");
            WHEN 11 => Put ("eleventh");
            WHEN 12 => Put ("twelth");
            WHEN 13 => Put ("thirteenth");
            WHEN 14 => Put ("fourteenth");
            WHEN 15 => Put ("fifteenth");
            WHEN 16 => Put ("sixteenth");
            WHEN 17 => Put ("seventeenth");
            WHEN 18 => Put ("eighteenth");
            WHEN 19 => Put ("nineteenth");
            WHEN 20 => Put ("twentieth");
            WHEN 21..29 => Put ("twenty");
            WHEN 30 => Put ("thirtieth");
            WHEN 31 => Put ("thirty");
            WHEN OTHERS => Null;
         END CASE;
         -- Print the dash within the day
         CASE Day IS
            WHEN 21..29 | 31 => Put ("-");
            WHEN OTHERS => NULL;
         END CASE;
         -- Print second part of the day
         CASE Day IS
            WHEN 1..9 | 21..29 | 31 =>
               CASE Day rem 10 IS
                  WHEN 1 => Put ("first");
                  WHEN 2 => Put ("second");
                  WHEN 3 => Put ("third");
                  WHEN 4 => Put ("fourth");
                  WHEN 5 => Put ("fifth");
                  WHEN 6 => Put ("sixth");
                  WHEN 7 => Put ("seventh");
                  WHEN 8 => Put ("eighth");
                  WHEN 9 => Put ("ninth");
                  WHEN OTHERS => Null;
               END CASE;
            WHEN OTHERS => Null;
         END CASE;
         Put (", ");
         -- Print The Century
         CASE Year IS
            WHEN 1901..1999 => Put ("nineteen hundred");
            WHEN OTHERS => Put ("two thousand");
         END CASE;
         -- Print the letter 'and' within the year
         CASE Year IS
            WHEN 1901..1999|2001..2099 => Put (" and ");
            WHEN OTHERS => Null;
         END CASE;
           -- Print the decade
         CASE Year rem 100 IS
            WHEN 10 => Put ("ten");
            WHEN 11 => Put ("eleven");
            WHEN 12 => Put ("twelve");
            WHEN 13 => Put ("thirteen");
            WHEN 14 => Put ("fourteen");
            WHEN 15 => Put ("fifteen");
            WHEN 16 => Put ("sixteen");
            WHEN 17 => Put ("seventeen");
            WHEN 18 => Put ("eighteen");
            WHEN 19 => Put ("nineteen");
            WHEN 20..29 => Put ("twenty");
            WHEN 30..39 => Put ("thirty");
            WHEN 40..49 => Put ("forty");
            WHEN 50..59 => Put ("fifty");
            WHEN 60..69 => Put ("sixty");
            WHEN 70..79 => Put ("seventy");
            WHEN 80..89 => Put ("eighty");
            WHEN 90..99 => Put ("ninety");
            WHEN OTHERS => Null;
         END CASE;
          -- Print the dash within the year
         CASE Year rem 100 IS
            WHEN 0..20|30|40|50|60|70|80|90 => NULL;
            WHEN OTHERS => Put ("-");
         END CASE;
         -- Print the last digit of the year
         IF Year rem 100 > 19 THEN
            CASE Year rem 10 IS
               WHEN 1 => Put ("one");
               WHEN 2 => Put ("two");
               WHEN 3 => Put ("three");
               WHEN 4 => Put ("four");
               WHEN 5 => Put ("five");
               WHEN 6 => Put ("six");
               WHEN 7 => Put ("seven");
               WHEN 8 => Put ("eight");
               WHEN 9 => Put ("nine");
               WHEN OTHERS => Null;
            END CASE;
         END IF;
         Put (".");
      END Date_Reader;
   ---------------------------------------------------------------------
      Temp_Day    : Day_Type;
      Temp_Month  : Month_Type;
      Temp_Year   : Year_Type;
      Increase    : CONSTANT := 1;
   BEGIN
      -- Initialize variables and counters
      Temp_Day   := Start_Day;
      Temp_Month := Start_Month;
      Temp_Year  := Start_Year;
      Count := 0;

      LOOP
         EXIT WHEN Temp_Day = End_Day AND
                 Temp_Month = End_Month AND
                  Temp_Year = End_Year;
         Addition (Temp_Month, Temp_Day, Temp_Year, Increase);
         Count := Count + 1;
      END LOOP;

      -- Echo print input and user option to include end date
      Put_Line      ("From day and including: ");
      Put (Day_Of_Week (Start_Month, Start_Day, Start_Year) & ", ");
      Date_Reader (Start_Month, Start_Day, Start_Year);
      New_Line;
      Put ("To ");
      IF Choice = N THEN
         Put_Line (", but not including: ");
      ELSE
         Put_Line ("and including: ");
      END IF;
      Put (Day_Of_Week (End_Month, End_Day, End_Year) & ", ");
      Date_Reader (End_Month, End_Day, End_Year);
      -- Print result
      New_Line;
      Put_Line ("-------------------------");
      Put      ("Result: ");
      IF Choice = Y THEN
         Count := Count + 1;
         Put (Count,0);
      ELSE
         Put (Count,0);
      END IF;
         Put (" days.");
   END Calculate_Duration;
   ---------------------------------------------------------------------
   PROCEDURE Day_Converter (Days : IN Integer) IS
      -- This program converts the number of dates
      -- into other alternative time units
      Seconds : Integer;
      Minutes : Integer;
      Hours   : Integer;
      Weeks   : Integer;
   BEGIN
      Hours   := Days * 24;
      Minutes := Hours * 60;
      Seconds := Minutes * 60;
      Weeks   := Integer (Days / 7);
      -- Print alternative time units
      Put_Line ("Alternative time units");
      Put (Days,0);
      Put_Line (" days can be converted to one of these units:");
      Put (Seconds,0);   Put_Line (" seconds");
      Put (Minutes,0);   Put_Line (" minutes");
      Put (Hours,0);     Put_Line (" hours");
      Put (Days,0);      Put_Line (" days");
      Put (Weeks,0);     Put (" weeks ");
      IF Float(Weeks) < Float(Days)/7.0 THEN
         Put ("(rounded down)");
      ELSIF Float(Weeks) > Float(Days)/7.0 THEN
         put ("(rounded up)");
      END IF;
   END Day_Converter;
   ---------------------------------------------------------------------
   PROCEDURE Age_Count (Start_Month : IN Month_Type;
                          Start_Day : IN Day_Type;
                         Start_Year : IN Year_Type;
                          End_Month_In : IN Month_Type;
                            End_Day_In : IN Day_Type;
                           End_Year_In : IN Year_Type;
                                Choice : Include_Choice) IS
            -- This subprogram puts the duration between two dates
            -- in year/month/day format

      Delta_Year : Integer;
      Delta_Month : Integer;
      Delta_Day : Integer;
      End_Month : Month_Type;
      End_Day : Day_Type;
      End_Year : Year_Type;
   BEGIN
      End_Month := End_Month_In;
      End_Day := End_Day_In;
      End_Year := End_Year_In;
      IF Choice = Y THEN
         Addition (End_Month, End_Day, End_Year, 1);
      END IF;

      IF Start_Month < End_Month THEN
         Delta_Year := Integer(End_Year) - Integer(Start_Year);
         IF Start_Day <= End_Day THEN
            Delta_Month := Integer(End_Month) - Integer(Start_Month);
            Delta_Day := Integer(End_Day) - Integer(Start_Day);
         ELSIF Start_Day > End_Day THEN
            Delta_Month := (Integer(End_Month) - 1) - Integer(Start_Month);
            CASE End_Month IS
               WHEN 2|4|6|8|9|11|1 =>
                  Delta_Day := (Integer(End_Day) + 31) - Integer(Start_Day);
               WHEN 5|7|10|12 =>
                  Delta_Day := (Integer(End_Day) + 30) - Integer(Start_Day);
               WHEN 3 =>
                  CASE Integer(End_Year) rem 4 IS
                     WHEN 0 =>
                        Delta_Day := (Integer(End_Day) + 29) - Integer(Start_Day);
                     WHEN OTHERS =>
                        Delta_Day := (Integer(End_Day) + 28) - Integer(Start_Day);
                  END CASE;
            END CASE;
         END IF;
      ELSIF Start_Month > End_Month THEN
         Delta_Year := (Integer(End_Year) - 1) - Integer(Start_Year);
         IF Start_Day <= End_Day THEN
            Delta_Month := (Integer(End_Month) + 12) - Integer(Start_Month);
            Delta_Day := Integer(End_Day) - Integer(Start_Day);
         ELSIF Start_Day > End_Day THEN
            Delta_Month := (Integer(End_Month) + 12 - 1) - Integer(Start_Month);
            CASE End_Month IS
               WHEN 2|4|6|8|9|11|1 =>
                  Delta_Day := (Integer(End_Day) + 31) - Integer(Start_Day);
               WHEN 5|7|10|12 =>
                  Delta_Day := (Integer(End_Day) + 30) - Integer(Start_Day);
               WHEN 3 =>
                  CASE Integer(End_Year) rem 4 IS
                     WHEN 0 =>
                        Delta_Day := (Integer(End_Day) + 29) - Integer(Start_Day);
                     WHEN OTHERS =>
                        Delta_Day := (Integer(End_Day) + 28) - Integer(Start_Day);
                  END CASE;
            END CASE;
         END IF;
      ELSIF Start_Month = End_Month THEN
         IF Start_Day >= End_Day THEN
            Delta_Year := Integer(End_Year) - Integer(Start_Year);
            Delta_Month := Integer(End_Month) - Integer(Start_Month);
            Delta_Day := Integer(End_Day) - Integer(Start_Day);
         ELSIF Start_Day < End_Day THEN
            Delta_Year := (Integer(End_Year) - 1) - Integer(Start_Year);
            Delta_Month := (Integer(End_Month) + 12 - 1) - Integer(Start_Month);
            CASE End_Month IS
               WHEN 2|4|6|8|9|11|1 =>
                  Delta_Day := (Integer(End_Day) + 31) - Integer(Start_Day);
               WHEN 5|7|10|12 =>
                  Delta_Day := (Integer(End_Day) + 30) - Integer(Start_Day);
               WHEN 3 =>
                  CASE Integer(End_Year) rem 4 IS
                     WHEN 0 =>
                        Delta_Day := (Integer(End_Day) + 29) - Integer(Start_Day);
                     WHEN OTHERS =>
                        Delta_Day := (Integer(End_Day) + 28) - Integer(Start_Day);
                  END CASE;
            END CASE;
         END IF;
      END IF;

      Put ("Or ");
      Put (Delta_Year,0);   Put (" years, ");
      Put (Delta_Month,0);  Put (" months, ");
      Put (Delta_Day,0);    Put (" days ");
      IF Choice = N THEN
         Put ("excluding the end date");
      ELSE
         Put ("including the end date");
      END IF;
   END Age_Count;
---------------------------------------------------------------------
   -- Variables
   Start_Day   : Day_Type;
   Start_Month : Month_Type;
   Start_Year  : Year_Type;
   End_Day     : Day_Type;
   End_Month   : Month_Type;
   End_Year    : Year_Type;
   Choice      : Include_Choice;
   Result      : Integer;

BEGIN
   -- Fetch user input
   Fetch_data (Start_Month, Start_Day, Start_Year,
               End_Month, End_Day, End_Year, Choice);
   -- Print result
   Put_Line ("------------------------------------------------------------");
   Calculate_Duration (Start_Month, Start_Day, Start_Year,
      End_Month, End_Day, End_Year, Choice, Result);
   -- Print result in years, months, days format
   New_Line;
   Age_Count (Start_Month, Start_Day, Start_Year,
      End_Month, End_Day, End_Year, Choice);
   -- Print result in alternative time units
   New_Line;
   Put_Line ("-------------------------");
   Day_Converter (Result);

END Duration_Calculator;













