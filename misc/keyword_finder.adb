WITH Ada.Text_Io;
USE Ada.Text_Io;

PROCEDURE Keyword_Finder IS
   -- This program looks up a word or phrase  from
   -- a given text

   -- File variables
   Text_File   : File_Type;        -- Input text file
   File_Name   : String (1..20);   -- Name of input text file
   Name_Length : Integer;          -- Name length of input file

   -- Array type and variables
   TYPE Character_Array IS ARRAY (1..1000) OF Character;
   Char        : Character_Array;  -- Array storing each input character
   Index       : Integer;          -- Array index

   -- Search constant
   Case_Difference : CONSTANT Integer
                   := Character'Pos('a') - Character'Pos('A');

   -- Search variables
   Search      : String (1..10);   -- Search word
   Length      : Integer;          -- Length of search word
   Found       : Boolean;          -- Status when search word is found
   Count       : Integer;          -- Count of searches found

BEGIN
   -- Prompt user to input name of text file
   Put ("Enter the name of input text file: ");
   Get_Line (File_Name, Name_Length);

   -- Promt user to input search word
   Put ("Find: ");
   Get_Line (Search, Length);

   -- Open input file
   Open (Text_File, In_File, File_Name(1..Name_Length));

   -- Analyze characters from text
   Index := 1;       -- Initialize array index to 1st element
   Count := 0;       -- Initialize count to 0
   Found := False;   -- Initialize found to False
   LOOP
      EXIT WHEN End_Of_File (Text_File);
      Get (Text_File, Char(Index));
      IF Index = Length THEN
         Found := True;
         FOR A IN 0..Length-1 LOOP
            IF Char(Index-A) /= Search(Length-A) AND
                  ABS(Character'Pos(Char(Index-A)) - Character'Pos(Search(Length-A)))
                      /= Case_Difference THEN
               Found := False;
            END IF;
         END LOOP;
         -- Increment counter when search is found
         IF Found THEN
            Count := Integer'Succ (Count);
         END IF;
         -- Increment the index of the array
         FOR B IN 2..Length LOOP
            Char(B-1) := Char(B);
         END LOOP;
      END IF;
      IF Index < Length THEN
         Index := Integer'Succ (Index);
      ELSE
         Index := Length;
      END IF;
   END LOOP;

   -- Sever connection to input file
   Close (Text_File);

   IF Count > 0 THEN
      Put ("There are" & Integer'Image(Count) & " such item(s).");
   ELSE
      Put ("Search word is not found.");
   END IF;

END Keyword_Finder;
