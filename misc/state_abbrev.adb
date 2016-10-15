WITH Ada.Text_Io;   USE Ada.Text_Io;

PROCEDURE State_Abbrev IS
   Abbreviation : String (1..2);

BEGIN
   Put ("Input the two-letter state abbreviation: ");
   Get (Abbreviation);

   Put ("The full name of the state: ");


      CASE Abbreviation (1) IS
      WHEN 'A' =>
         CASE Abbreviation (2) IS
            WHEN 'L' =>
               Put ("Alabama");
            WHEN 'Z' =>
               Put ("Arizona");
            WHEN 'K' =>
               Put ("Alaska");
            WHEN 'R' =>
               Put ("Arkansas");
            WHEN OTHERS =>
               Put ("Invalid Input");
         END CASE;
      WHEN 'C' =>
         CASE Abbreviation (2) IS
            WHEN 'A' =>
               Put ("California");
            WHEN 'T' =>
               Put ("Connecticut");
            WHEN 'O' =>
               Put ("Colorado");
            WHEN OTHERS =>
               Put ("Invalid Input");
         END CASE;
      WHEN 'D' =>
         Put ("Delaware");
      WHEN 'G' =>
         Put ("Georgia");
      WHEN 'H' =>
         Put ("Hawaii");
      WHEN 'I' =>
         CASE Abbreviation (2) IS
            WHEN 'L' =>
               Put ("Illinois");
            WHEN 'A' =>
               Put ("Iowa");
            WHEN 'D' =>
               Put ("Idaho");
            WHEN 'N' =>
               Put ("Indiana");
            WHEN OTHERS =>
               Put ("Invalid Input");
         END CASE;
      WHEN 'K' =>
         Put ("Kentucky");
      WHEN 'L' =>
         Put ("Louisiana");
      WHEN 'M' =>
         CASE Abbreviation (2) IS
            WHEN 'E' =>
               Put ("Maine");
            WHEN 'A' =>
               Put ("Massachusetts");
            WHEN 'N' =>
               Put ("Minnesota");
            WHEN 'O' =>
               Put ("Missouri");
            WHEN 'D' =>
               Put ("Maryland");
            WHEN 'I' =>
               Put ("Michigan");
            WHEN 'S' =>
               Put ("Mississippi");
            WHEN 'T' =>
               Put ("Montana");
            WHEN OTHERS =>
               Put ("Invalid Input");
         END CASE;
      WHEN 'N' =>
         CASE Abbreviation (2) IS
            WHEN 'E' =>
               Put ("Nebraska");
            WHEN 'H' =>
               Put ("New Hampshire");
            WHEN 'M' =>
               Put ("New Mexico");
            WHEN 'C' =>
               Put ("North Carolina");
            WHEN 'V' =>
               Put ("Nevada");
            WHEN 'J' =>
               Put ("New Jersey");
            WHEN 'Y' =>
               Put ("New York");
            WHEN 'D' =>
               Put ("North Dakota");
            WHEN OTHERS =>
               Put ("Invalid Input");
         END CASE;
      WHEN 'O' =>
         CASE Abbreviation (2) IS
            WHEN 'H' =>
               Put ("Ohio");
            WHEN 'R' =>
               Put ("Oregon");
            WHEN 'K' =>
               Put ("Oklahoma");
            WHEN OTHERS =>
               Put ("Invalid Input");
         END CASE;
      WHEN 'P' =>
         Put ("Pennsylvania");
      WHEN 'R' =>
         Put ("Rhode Island");
      WHEN 'S' =>
         CASE Abbreviation (2) IS
            WHEN 'D' =>
               Put ("South Dakota");
            WHEN 'C' =>
               Put ("South Carolina");
            WHEN OTHERS =>
               Put ("Invalid Input");
         END CASE;
      WHEN 'T' =>
         CASE Abbreviation (2) IS
            WHEN 'X' =>
               Put ("Texas");
            WHEN 'N' =>
               Put ("Tennessee");
               WHEN OTHERS =>
                  Put ("Invalid Input");
            END CASE;
         WHEN 'U' =>
            Put ("Utah");
         WHEN 'V' =>
            CASE Abbreviation (2) IS
               WHEN 'T' =>
                  Put ("Vermont");
               WHEN 'A' =>
                  Put ("Virginia");
               WHEN OTHERS =>
                  Put ("Invalid Input");
            END CASE;
         WHEN 'W' =>
            CASE Abbreviation (2) IS
               WHEN 'A' =>
                  Put ("Washington");
               WHEN 'I' =>
                  Put ("Wisconsin");
               WHEN 'V' =>
                  Put ("West Virginia");
               WHEN 'Y' =>
                  Put ("Wyoming");
               WHEN OTHERS =>
                  Put ("Invalid Input");
            END CASE;
         WHEN OTHERS =>
            Put ("Invalid Input");
      END CASE;

   END State_Abbrev;
