WITH Ada.Text_Io, Ada.Integer_Text_Io;
USE  Ada.Text_Io, Ada.Integer_Text_Io;

PROCEDURE Quick_Sort_Illustration IS
   -- This procedure illustrates the use of quick
   -- sort to sort an array of elements

   -- Index range and array declaration
   TYPE A_Array IS ARRAY (1..20) OF Integer;

   PROCEDURE Quicksort (A : IN OUT A_Array;
                        P : IN Integer;
                        R : IN Integer) IS
      PROCEDURE Partition (A : IN Out A_ARRAY;
                          P : IN Integer;
                          R : IN Integer;
                          Q : in out integer) IS
         Temp : Integer;
      BEGIN
         Q := P;
         FOR U IN P..R-1 LOOP
            IF A(U) <= A(R) THEN
               Temp := A(Q);
               A(Q) := A(U);
               A(U) := Temp;
               Q := Q + 1;
            END IF;
         END LOOP;
         Temp := A(Q);
         A(Q) := A(R);
         A(R) := Temp;
      END Partition;

      Q : Integer;
   BEGIN
      IF P >= R THEN
         NULL;
      ELSE
         Partition (A, P, R, Q);
         Quicksort (A, P, Q-1);
         Quicksort (A, Q+1, R);
      END IF;
   END QuickSort;

   Input  : File_Type;
   Output : File_Type;
   A : A_Array;
   N : Integer;
BEGIN
   Open (Input, In_File, "input.txt");
   N := 1;
   WHILE NOT End_Of_File (Input) LOOP
      Get (Input, A(N));
      N := N + 1;
   END LOOP;
   Close (Input);

   N := N - 1;

   Quicksort (A, 1, N);

   Create (Output, Out_File, "output.txt");
   FOR I IN 1..N LOOP
      Put (Output, A(I), Width => 3);
   END LOOP;
   Close (Output);

END Quick_Sort_Illustration;
