WITH Ada.Text_Io, Ada.Integer_Text_Io;
USE  Ada.Text_Io, Ada.Integer_Text_Io;

PROCEDURE Insert_Sort_Illustration IS
   -- This procedure illustrates the use of insertion
   -- sort to sort an array of elements

   -- Index range and array declaration
   TYPE A_Array IS ARRAY (0..60_000) OF Integer;

   PROCEDURE Insertion_Sort (A : IN OUT A_Array;
         N : Integer) IS
      -- This procedure sorts an input array using
      -- insertion sort
      Key : Integer;
      J : Integer;
   BEGIN
      FOR I IN 2..N LOOP
         Key := A(I);
         J := I - 1;
         WHILE J > 0 AND A(J) > Key LOOP
            A(J+1) := A(J);
            J := J - 1;
         END LOOP;
         A(J+1) := Key;
      END LOOP;
   END Insertion_Sort;

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

   Insertion_Sort (A, N);

   Create (Output, Out_File, "output.txt");
   FOR I IN 1..N LOOP
      Put (Output, A(I), Width => 6);
   END LOOP;
   Close (Output);

END Insert_Sort_Illustration;
