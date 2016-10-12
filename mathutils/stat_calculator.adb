WITH Ada.Text_Io, Ada.Float_Text_Io, Ada.Integer_Text_Io;
USE Ada.Text_Io, Ada.Float_Text_Io, Ada.Integer_Text_Io;

PROCEDURE Stat_Calculator IS
   -- This program reads in values from an input file and
   -- compute the statistical attributes of that population

   -- Declare file variable
   In_Stat : File_Type;

   -- Declare array type
   TYPE Value_Array IS ARRAY (1..50) OF Float;

   -- Declare value array
   Value : Value_Array;

   -- Variables

---------------------------------------------------------------------
   FUNCTION Population_Size (In_File : IN File_Type) RETURN Integer IS
      -- This function computes the size of a population
      Size : Integer;   -- Population size
   BEGIN
      Size := 0;      -- Set the population size to 0
      LOOP
         EXIT WHEN End_Of_File (In_File) = True;
         -- Exit loop when the reading marker reaches
         -- the end of the file
         Ada.Float_Text_Io.Get (In_File, Value(Size + 1));
         -- Get an array of values
         Size := Size + 1;   -- Increment the size
      END LOOP;
      RETURN Size;           -- Return population size to caller
   END Population_Size;
---------------------------------------------------------------------
   FUNCTION Sum (Size : IN Integer) RETURN Float IS
      -- This function computes the total sum of a population
      Sum : Float;
   BEGIN
      Sum := 0.0;      -- Set the initial sum to 0
      FOR N IN 1..Size LOOP
         Sum := Sum + Value(N);
      END LOOP;
      RETURN Sum;
   END Sum;
---------------------------------------------------------------------
   FUNCTION Square_Sum (Size : IN Integer) RETURN Float IS
      -- This function computes the sum of squares of all values
      Square_Sum : Float;
   BEGIN
      Square_Sum := 0.0;   -- Set initial square sum to 0
      FOR N IN 1..Size LOOP
         Square_Sum := Square_Sum + (Value(N))**2;
      END LOOP;
      RETURN Square_Sum;
   END Square_Sum;
---------------------------------------------------------------------
   FUNCTION Mean (Sum: IN Float; Size : IN Integer) RETURN Float IS
      -- This function computes the average of a population
      -- given the total sum and the population size
   BEGIN
      RETURN Sum / Float(Size);
   END Mean;
---------------------------------------------------------------------
   FUNCTION Variance (Sum : IN Float; Square_Sum : IN Float; Size : IN Integer)
         RETURN Float IS
      -- This function computes the variance of a population
      -- given the population sum and sum of all squares
   BEGIN
      RETURN (Square_Sum / Float(Size)) - (Sum / Float(Size)) ** 2;
   END Variance;
---------------------------------------------------------------------
   File_Name : String (1..10);   -- Name of the input file
   Name_Length : Integer;        -- Length of the name
   Pop_Size : Integer;               -- Size of the population
   Pop_Sum : Float;              -- Total sum
   Pop_Square_Sum : Float;       -- Total sum of all squares
   Pop_Mean : Float;             -- Population mean
   Pop_Variance : Float;         -- Population variance

BEGIN
   -- Prompt user to enter input file name
   Put ("Enter file name to be analyzed: ");
   Get_Line (File_Name, Name_Length);

   -- Open input file
   Open (In_Stat, In_File, File_Name (1..Name_Length));

   -- Call function to compute population size
   Pop_Size := Population_Size (In_Stat);
   New_Line;
   Put ("Population size: ");
   Put (Pop_Size,0);

   -- Call function to compute total sum of all values
   Pop_Sum := Sum (Pop_Size);
   New_Line;
   Put ("Sum: ");
   Put (Pop_Sum, Fore => 4, Aft => 4, Exp => 0);

   -- Call function to compute total sum of all squares of values
   Pop_Square_Sum := Square_Sum (Pop_Size);
   New_Line;
   Put ("Square Sum: ");
   Put (Pop_Square_Sum, Fore => 4, Aft => 4, Exp => 0);

   -- Call function to compute the population mean
   Pop_Mean := Mean (Pop_Sum, Pop_Size);
   New_Line;
   Put ("Mean: ");
   Put (Pop_Mean, Fore => 4, Aft => 4,Exp => 0);

   -- Call function to compute the variance
   Pop_Variance := Variance (Pop_Sum, Pop_Square_Sum, Pop_Size);
   New_Line;
   Put ("Mean: ");
   Put (Pop_Variance, Fore => 4, Aft => 4, Exp => 0);

END Stat_Calculator;






