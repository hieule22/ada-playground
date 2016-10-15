WITH Ada.Text_Io;   USE Ada.Text_Io;
WITH Ada.Integer_Text_Io;   USE Ada.Integer_Text_Io;

PROCEDURE Combination IS
-- This program finds the number of different assortments
-- of characters in a given string

   In_String : String (1..32);   -- String input by user
   Length : Integer;   -- Length of input string
   Check_Character : Character;
   Position : Integer;   -- Position of a specific character in the string
   Check_Position : Integer;   -- Position of the character being checked
   Count : Integer;   -- Counter of similar characters

BEGIN
   Put ("Enter a string: ");
   Get_Line (In_String, Length);

   Position := 1;
   Character_Loop:
      LOOP
      EXIT Character_Loop WHEN Position > Length;
      Check_Character := In_String (Position);
      IF Check_Character = ' ' THEN
         Space_Loop:
            LOOP
            EXIT Space_Loop WHEN Check_Character /= ' ';
            Position := Position + 1;
            Check_Character := In_String (Position);
         END LOOP Space_Loop;
       END IF;

       Check_Position := position + 1;
       Count := 0;
       Character_Check:
          LOOP
          EXIT Character_Check WHEN Check_Position > Length;
          IF In_String(Position) = Check_Character THEN
             Count := Count + 1;
             In_String(Position) := ' ';
          END IF;
          Check_Position := Check_Position + 1;
       END LOOP Character_Check;

       Put ("There are ");
       Put (Count, Width => 0);
       Put (" " & Check_Character & " in the input string.");
       New_Line;
       Position := Position + 1;
   END LOOP Character_Loop;

  END Combination;
