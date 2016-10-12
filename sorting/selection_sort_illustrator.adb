WITH Ada.Text_Io;
USE  Ada.Text_Io;

PROCEDURE Selection_Sort_Illustrator IS
   -- This program graphically represents how
   -- selection sort works in real time
   Max_Index : CONSTANT Integer := 10;
   TYPE N_Array IS ARRAY (1..Max_Index) OF Integer;

   PROCEDURE Initialize_Array (N : OUT N_Array) IS
      -- This procedure initializes values for
      -- each entry of array
   BEGIN
      FOR I IN 1..Max_Index LOOP
         N(I) := Max_Index - I + 1;
      END LOOP;
   END Initialize_Array;

   PROCEDURE Print_Array (N : IN N_Array) IS
      -- This procedure graphically presents
      -- input array using dashes
   BEGIN
      FOR I IN 1..Max_Index LOOP
         FOR J IN 1..N(I) LOOP
            Put ('-');
         END LOOP;
         New_Line;
      END LOOP;
   END Print_Array;

   FUNCTION Find_Min_Position (N : IN N_Array;
         Start : IN Integer; Finish : IN Integer) RETURN Integer IS
      -- This function returns the index of the min
      -- element in a specified subarray
      Min : Integer;
   BEGIN
      Min := Start;
      FOR I IN Start+1 .. Finish LOOP
         IF N(I) < N(Min) THEN
            Min := I;
         END IF;
      END LOOP;
      RETURN Min;
   END Find_Min_Position;

   PROCEDURE Swap_Element (N : IN OUT N_Array; A : IN Integer; B : IN Integer) IS
      -- This procedure swaps the Ath and Bth element of the array
      Temp : Integer;
   BEGIN
      Temp := N(A);
      N(A) := N(B);
      N(B) := Temp;
   END Swap_Element;
   N : N_Array;
   Min : Integer;
BEGIN
   Initialize_Array (N);

   FOR I IN 1..Max_Index-1 LOOP
      Print_Array (N);
      Min := Find_Min_Position (N, I, Max_Index);
      Swap_Element (N, I, Min);
      New_Line;
   END LOOP;
END Selection_Sort_Illustrator;


