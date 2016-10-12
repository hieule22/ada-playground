WITH Ada.Text_Io;
USE Ada.Text_Io;

PROCEDURE Initials_Constructor IS
   -- This program helps construct the corresponding initials
   -- to an input name

   -- Variable(s)
   Name : String (1..30);   -- Name input by user
   Name_Length : Integer;   -- Number of input characters

BEGIN
   -- Prompt user to input name
   Put ("Enter your full name: ");
   Get_Line (Name, Name_Length);

   -- Print name initials for user
   New_Line;
   Put ("Your initials are: ");

   FOR Position IN 1..Name_Length LOOP
      IF Character'Pos(Name(Position)) >= Character'Pos('A') AND
            Character'Pos(Name(Position)) <= Character'Pos('Z') THEN
         Put(Name(Position) & " ");
      END IF;
   END LOOP;

END Initials_Constructor;


