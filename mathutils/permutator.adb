-- Name of Creator: Hieu T. Le
-- Date of Completion: October 23, 2014

-- Used libraries
WITH Ada.Text_Io;   USE Ada.Text_Io;
-------------------------------------------------------------------------------
PROCEDURE Permutator IS
   -- This program outputs all the possible permutations of
   -- the elements of a string input by user

   -- Array will be used to store each permutation obtained
   SUBTYPE Index_Range IS Integer RANGE 1..362_880;
   -- The system imposes a cap on the upper bound of index range:
   -- stack overflow arises when set above 1,000,000. Hence,
   -- strings of too great a length will not be processable
   TYPE Permutation_Array IS ARRAY (Index_Range) OF String (1..9);
   -- The string length must not exceed 9, for a string of 10 different
   -- elements may conjure 10! (= 3,628,800) different permutations,
   -- which exceed the upper bound of array index range

   -- Global variable
   In_String   : String (1..30);    -- String input by user
   In_Length   : Integer;           -- Length of input string
   Permutation : Permutation_Array; -- An array element assigned to each permutation
   Count       : Integer;           -- Counter of each permutation made thus far
   ------------------------------------------------------------------
   PROCEDURE Placer(L : IN Character;
                Input : IN String;
               Length : IN Integer) IS
      -- This subprogram inserts a specified character into an input string
      -- in order to create new string
      S : String (1..11);   -- Temporary string variable to store input string

   BEGIN
      FOR Berth IN 1..Length+1 LOOP
         -- New element L will be placed in from the 1st berth to
         -- the berth succeeding the last element of the input string
         S(1..Length) := Input(1..Length); -- Store the input string into temporary memory location
         IF Berth < Length+1 THEN   -- For all berths positioned within the input string
            FOR A IN REVERSE Berth..Length LOOP
               -- Shift all the elements of the input string in and after the
               -- selected berth 1 place to the right to allow space for the
               -- new element
               S(A+1) := S(A);
            END LOOP;
         END IF;
         -- Put the new element L into the vacated bert
         S(Berth) := L;

         -- Consider the case when insertion of additional element
         -- into the input string completes the user-input string
         IF Length+1 = In_Length THEN
            Count := Count + 1;   -- Increment the counter
            -- Storing the newly created permutation to an array element
            Permutation(Count)(1..In_Length) := S(1..In_Length);
         -- Otherwise if the newly-formed string does not complete
         -- the user-input string, repeat the subprogram to continue
         -- placing in string
         ELSIF Length+1 < In_Length THEN
            Placer (In_String(Length+2), S(1..Length+1), Length+1);
         END IF;
      END LOOP;
   END Placer;
   -------------------------------------------------------------------
   -- Variables local to the main program only
   Actual_Count : Integer;   -- The actual number of different permutations
   Unique : Boolean;   -- Boolean value to determine if a permutation is unique

BEGIN
   -- Prompt user for string input
   LOOP
      Put ("Enter a string of length 9 or less: ");
      Get_Line (In_String, In_Length);
      EXIT WHEN In_Length <= 9;
      IF In_Length > 9 THEN
         Put_Line ("String length exceeds 9!");
      END IF;
   END LOOP;

   Count := 0;   -- Initialize counter to 0
   IF In_Length = 1 THEN   -- If input is of length 1, echo print
      Put (In_String(1));
      count := 1;   -- Set counter to 1 as there is only 1 possible permutation
   ELSE      -- If input of length greater than 2, calls Placer
      Placer (In_String(2), In_String(1..1), 1);
      -- The first element to be placed will be the 2nd character of
      -- the string, while the string slice to be modified is the
      -- first character
      Actual_Count := Count;   -- Assign actual count to be equal to count
      FOR A IN 1..Count LOOP
         Unique := True;   -- Initialize Unique to True
         FOR B IN 1..A-1 LOOP   -- Now we trace all the previous elements to
                                -- determine if Permutation(A) is Unique
            IF Permutation(A)(1..In_Length) = Permutation(B)(1..In_Length) THEN
               Unique := False;   -- Assign Unique to False
            END IF;
         END LOOP;
         -- Print unique permutation
         IF Unique THEN
            Put_Line(Permutation(A)(1..In_Length));
         ELSE   -- Else decrement actual count if permutation is not unique
            Actual_Count := Actual_Count - 1;
         END IF;
      END LOOP;
   END IF;

   -- Print the total number of different possible permutations
   Put ("Number of permutations:" & Integer'Image(Actual_Count));

END Permutator;
