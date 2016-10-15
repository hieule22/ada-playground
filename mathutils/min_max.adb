WITH Ada.Integer_Text_Io, Ada.Text_Io;
USE Ada.Integer_Text_Io, Ada.Text_Io;

PROCEDURE Min_Max IS
   -- A program to compute the minimum and maximum values
   -- of an input population

   -- Declare file variable
   In_Stat : File_Type;

   -- Declare file name variables
   File_Name : String (1..10);   -- Name of input file
      Name_Length : Integer;        -- Length of file name

      -- Declare array type
   TYPE Value_Array IS ARRAY (1..50) OF Integer;
   Value : Value_Array;

      -- Other variables
   Count : Integer;
   Maximum : Integer;
   Minimum : Integer;

BEGIN
   -- Prompt user to input file name
   Put ("Enter name of input file: ");
   Get_Line (File_Name, Name_Length);

   -- Open input file
   Open (In_Stat, In_File, File_Name (1..Name_Length));

   -- Calculate the number of values and assign them with an array value
   Count := 0;      -- Set count to 0
   LOOP
      EXIT WHEN End_Of_File (In_Stat) = True;
      Count := Count + 1;      -- Increment counter
      Get (In_Stat, Value (Count));
   END LOOP;

   -- Find the maximum value
   Maximum := Value (1);
   FOR N IN 1..Count LOOP
      IF Value (N) > Maximum THEN
         Maximum := Value (N);
      END IF;
   END LOOP;
   Put ("Maximum value: ");
   Put (Maximum, 0);
   New_Line;

   -- Find the minimum value
   Minimum := Value (1);
   FOR N IN 1..Count LOOP
      IF Value (N) < Minimum THEN
         Minimum := Value (N);
      END IF;
   END LOOP;
   Put ("Minimum value: ");
   Put (Minimum, 0);
END Min_Max;
