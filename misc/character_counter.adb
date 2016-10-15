WITH Ada.Text_Io; USE Ada.Text_Io;
WITH Ada.Integer_Text_Io; USE Ada.Integer_Text_Io;

PROCEDURE Character_Counter IS
   In_String : String (1..32);
   String_Length : Integer;
   Character_Count : Integer;
   Value : Integer;
   Position : Integer;
   Check_Position : Integer;

BEGIN
   Put ("Enter a string: ");
   Get_Line (In_String, String_Length);

   Position := 1;
   Character_Count := 0;
   Counter:
      LOOP
      EXIT Counter WHEN Position > String_Length;
      Value := Character'Pos (In_String(Position));

      IF In_String(Position) /= '_' THEN
         Character_Count := Character_Count + 1;
      END IF;

      Check_Position := Position + 1;
      Elimination:
         LOOP
         EXIT Elimination WHEN Check_Position > String_Length;
         IF Character'Pos (In_String(Check_Position)) = Value THEN
            In_String(Check_Position) := '_';
         END IF;
         Check_Position := Check_Position + 1;
      END LOOP Elimination;

      Position := Position + 1;
   END LOOP Counter;

   Put ("The number of different characters in the input string is: ");
   Put (Character_Count, Width => 0);

END Character_Counter;
