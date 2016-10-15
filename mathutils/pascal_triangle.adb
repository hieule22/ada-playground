WITH Ada.Text_Io, Ada.Integer_Text_Io;
USE Ada.Text_Io, Ada.Integer_Text_Io;

PROCEDURE Pascal_Triangle IS
   -- This program generates the Pascal's Triangle corresponding
   -- to a specific number of rows input by user

   -- Declare ranges for rows and columns
   SUBTYPE Row_Range IS Integer RANGE 1..30;
   SUBTYPE Column_Range IS Integer RANGE 1..30;

   -- Declare type for element coordinates
   TYPE Table_Type IS ARRAY (Row_Range, Column_Range) OF Integer;

   -- Variable(s)
   Row_Number : Integer;   -- Number of rows input by user
   Pascal : Table_Type;

BEGIN
   -- Prompt user to input number of rows
   Put ("Enter the number of rows: ");
   Get (Row_Number);

   -- Initialize all values to 0
   Pascal := (others => (others => 0));

   -- Initialize the all elements in the first column to 0
   FOR Row IN 1..Row_Number LOOP
      Pascal (Row,1) := 1;
   END LOOP;

   -- Compute values for every elements in Pascal's Triangle
   FOR Row IN 2..Row_Number LOOP
      FOR Column IN 2..Row LOOP
         Pascal (Row, Column) := Pascal (Row-1, Column-1) +
                                 Pascal (Row-1, Column);
      END LOOP;
   END LOOP;

   -- Print Pascal'Triangle
   Put_Line ("---------------------------------------------------------");
   Put_Line ("PASCAL'S TRIANGLE");
   FOR Row IN 1..Row_Number LOOP
      FOR Column IN 1..Row LOOP
         Put (Pascal(Row,Column), Width => 4);
      END LOOP;
      New_Line;
   END LOOP;

END Pascal_Triangle;
