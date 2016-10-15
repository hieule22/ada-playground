WITH Ada.Text_Io;   USE Ada.Text_Io;
WITH Ada.Integer_Text_Io;   USE Ada.Integer_Text_Io;

PROCEDURE Date_Reader IS
   -- This program reads a date in numeric form
   -- and prints it in English

   SUBTYPE Day_Type IS Integer RANGE 1..31;
   SUBTYPE Month_Type IS Integer RANGE 1..12;
   SUBTYPE Year_Type IS Integer RANGE 1901..2000;

   Month : Month_type;
   Day : Day_Type;
   Year : Year_Type;

BEGIN
   -- Prompt user for input
   Put ("Enter a date in the form mm dd yyyy.");
   New_Line;
   Get (Month);
   Get (Day);
   Get (Year);

   -- Print month
   CASE Month IS
      WHEN 1 =>
         Put ("January");
      WHEN 2 =>
         Put ("February");
      WHEN 3 =>
         Put ("March");
      WHEN 4 =>
         Put ("April");
      WHEN 5 =>
         Put ("May");
      WHEN 6 =>
         Put ("June");
      WHEN 7 =>
         Put ("July");
      WHEN 8 =>
         Put ("August");
      WHEN 9 =>
         Put ("September");
      WHEN 10 =>
         Put ("October");
      WHEN 11 =>
         Put ("November");
      WHEN 12 =>
         Put ("December");
   END CASE;

   Put (" ");

   -- Print day
   CASE Day IS
      WHEN 10 =>
         Put ("tenth");
      WHEN 11 =>
         Put ("eleventh");
      WHEN 12 =>
         Put ("twelth");
      WHEN 13 =>
         Put ("thirteenth");
      WHEN 14 =>
         Put ("fourteenth");
      WHEN 15 =>
         Put ("fifteenth");
      WHEN 16 =>
         Put ("sixteenth");
      WHEN 17 =>
         Put ("seventeenth");
      WHEN 18 =>
         Put ("eighteenth");
      WHEN 19 =>
         Put ("nineteenth");
      WHEN 20 =>
         Put ("twentieth");
      WHEN 21..29 =>
         Put ("twenty");
      WHEN 30 =>
         Put ("thirtieth");
      WHEN 31 =>
         Put ("thirty");
      WHEN OTHERS =>
         Null;
   END CASE;

   -- Print the dash within the day
   CASE Day IS
      WHEN 21..29 | 31 =>
         Put ("-");
      WHEN OTHERS =>
         NULL;
   END CASE;

   CASE Day IS
      WHEN 1..9 | 21..29 | 31 =>
         CASE Day rem 10 IS
            WHEN 1 =>
               Put ("first");
            WHEN 2 =>
               Put ("second");
            WHEN 3 =>
               Put ("third");
            WHEN 4 =>
               Put ("fourth");
            WHEN 5 =>
               Put ("fifth");
            WHEN 6 =>
               Put ("sixth");
            WHEN 7 =>
               Put ("seventh");
            WHEN 8 =>
               Put ("eighth");
            WHEN 9 =>
               Put ("ninth");
            WHEN OTHERS =>
               Null;
         END CASE;
      WHEN OTHERS =>
         Null;
    END CASE;

   Put (", ");

   -- Print the century
   CASE Year IS
      WHEN 1901..1999 =>
         Put ("nineteen hundred");
      WHEN OTHERS =>
         Put ("two thousand");
   END CASE;

   -- Print the letter 'and' within the year
   CASE Year IS
      WHEN 1901..1999 =>
         Put (" and ");
      WHEN OTHERS =>
         Null;
   END CASE;

   -- Print the decade
   CASE Year rem 100 IS
      WHEN 10 =>
         Put ("ten");
      WHEN 11 =>
         Put ("eleven");
      WHEN 12 =>
         Put ("twelve");
      WHEN 13 =>
         Put ("thirteen");
      WHEN 14 =>
         Put ("fourteen");
      WHEN 15 =>
         Put ("fifteen");
      WHEN 16 =>
         Put ("sixteen");
      WHEN 17 =>
         Put ("seventeen");
      WHEN 18 =>
         Put ("eighteen");
      WHEN 19 =>
         Put ("nineteen");
      WHEN 20 .. 29 =>
         Put ("twenty");
      WHEN 30..39 =>
         Put ("thirty");
      WHEN 40..49 =>
         Put ("forty");
      WHEN 50..59 =>
         Put ("fifty");
      WHEN 60..69 =>
         Put ("sixty");
      WHEN 70..79 =>
         Put ("seventy");
      WHEN 80..89 =>
         Put ("eighty");
      WHEN 90..99 =>
         Put ("ninety");
      WHEN OTHERS =>
         Null;
   END CASE;

   -- Print the dash within the year
   CASE Year rem 100 IS
      WHEN 0..20|30|40|50|60|70|80|90 =>
         NULL;
      WHEN OTHERS =>
         Put ("-");
   END CASE;

   -- Print the last digit of the year
   IF Year rem 100 > 19 THEN
   CASE Year rem 10 IS
      WHEN 1 =>
         Put ("one");
      WHEN 2 =>
         Put ("two");
      WHEN 3 =>
         Put ("three");
      WHEN 4 =>
         Put ("four");
      WHEN 5 =>
         Put ("five");
      WHEN 6 =>
         Put ("six");
      WHEN 7 =>
         Put ("seven");
      WHEN 8 =>
         Put ("eight");
      WHEN 9 =>
         Put ("nine");
      WHEN OTHERS =>
         Null;
      END CASE;
   END IF;


    Put (".");

END Date_Reader;
