WITH Ada.Text_Io; USE Ada.Text_Io;
WITH Ada.Integer_Text_Io; USE Ada.Integer_Text_Io;

PROCEDURE Word_Guess IS
   Word_File : Ada.Text_Io.File_Type;
   The_Word : String (1..32);
   Word_Size : Integer;
   Display : String (1..32);
   Guess_Count : Integer;
   Guess_Letter : String (1..1);
   Letter_Position : Integer;
   Underscore_Count : Integer;
   Game_Option : String (1..1);
   Correct_Count : Integer;
   Play_Count : Integer;
   Skipped_Lines : Integer;

BEGIN
   Put (Item => "Welcome to the game !");
   New_Line;

   Play_Count := 1;
   Game_Option := "c";
   Game_Option_Loop:
      LOOP
      EXIT Game_Option_Loop WHEN Game_Option = "q";
      Open (File => Word_File,
      Mode => Ada.Text_Io.In_File,
         Name => "Wordstoguess.txt");

      Skipped_Lines := 0;

      Game_Selection_Loop:
         LOOP
            exit Game_Selection_Loop when Skipped_Lines = Play_Count - 1;
         Skip_Line (File => Word_File);
         Skipped_Lines := Skipped_Lines + 1;
      END LOOP Game_Selection_Loop;

      Get_Line (File => Word_File,
                Item => The_Word,
         Last => Word_Size);

      Display := "________________________________";

      Put (Item => "The word has ");
      Put (Item => Word_Size,
           Width => 1);
      Put (Item => " letters in it.");
      New_Line;
      Guess_Count := 3 + Word_Size;
      Underscore_Count := Word_Size;
      Guess_Loop:
         LOOP
         EXIT Guess_Loop WHEN Guess_Count = 0 OR Underscore_Count = 0;
         Put (Item => "The word is " & Display (1..Word_Size) & ".");
         New_Line;
         Put (Item => "You have ");
         Put (Item => Guess_Count,
            Width => 1);
         Put (Item => " guesses remaining. Please guess a letter: ");
         Get (Item => Guess_Letter);
         New_Line;
         Put (Item => "Your guess is ");

         Letter_Position := 1;
         Correct_Count := 0;
         Letter_Scan_Loop:
            LOOP
            EXIT Letter_Scan_Loop WHEN Letter_Position > Word_Size;
            IF The_Word (Letter_Position..Letter_Position) = Guess_Letter (1..1) THEN
               Display (Letter_Position..Letter_Position) := Guess_Letter (1..1);
               Correct_Count := Correct_Count + 1;
               Underscore_Count := Underscore_Count - 1;
            END IF;

            Letter_Position := Letter_Position + 1;
         END LOOP Letter_Scan_Loop;

         IF Correct_Count = 0 THEN
            Put (Item => "incorrect. ");
         ELSE
            Put (Item => "correct. ");
         END IF;

         Guess_Count := Guess_Count - 1;
      END LOOP Guess_Loop;

      New_Line;
      IF Guess_Count = 0 AND Underscore_Count /= 0 THEN
         Put (Item => "Sorry, you have run out of guesses.");
      ELSE
         Put (Item => "You have guessed correctly. The word is ");
         Put (Item => Display (1..Word_Size));
         New_Line;
      END IF;

      New_Line;
      Put (Item => "Would you like to <c>ontinue or <q>uit? ");
      Get (Item => Game_Option);

      Play_Count := Play_Count + 1;
      Close (File => Word_File);

   END LOOP Game_Option_Loop;



   END Word_Guess;








