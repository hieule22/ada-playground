WITH Ada.Text_Io, Ada.Integer_Text_Io;
USE  Ada.Text_Io, Ada.Integer_Text_Io;

PROCEDURE Merge_Sort_Illustration IS
   -- This procedure illustrates the use of merge
   -- sort to sort an array of elements

   -- Index range and array declaration
   TYPE A_Array IS ARRAY (0..60_000) OF Integer;

   PROCEDURE Merge_Sort (A : IN OUT A_Array;
                         P : IN Integer;
                         R : IN Integer) IS
      PROCEDURE Merge ( A : IN OUT A_Array;
                        P : IN Integer;
                        Q : IN Integer;
                        R : IN Integer) IS
         N_1 : Integer;
         N_2 : Integer;
         B   : A_Array;
         C   : A_Array;
         I   : Integer;
         j   : Integer;
      BEGIN
         N_1 := Q - P + 1;
         N_2 := R - Q;
         B (1..N_1) := A (P..Q);
         C (1..N_2) := A (Q+1..R);
         B (N_1 + 1) := Integer'Last;
         C (N_2 + 1) := Integer'Last;
         I := 1;
         J := 1;
         FOR K IN P..R LOOP
            IF B(I) <= C(J) THEN
               A(K) := B(I);
               I := I + 1;
            ELSE
               A(K) := C(J);
               J := J + 1;
            END IF;
         END LOOP;
      END Merge;

      Q : Integer;

   BEGIN
      IF P >= R THEN
         NULL;
      ELSE
         Q := Integer((P + R)/2);
         Merge_Sort (A, P, Q);
         Merge_Sort (A, Q+1, R);
         Merge (A, P, Q, R);
      END IF;
   END Merge_Sort;

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

   Merge_Sort (A, 1, N);

   Create (Output, Out_File, "output.txt");
   FOR I IN 1..N LOOP
      Put (Output, A(I), Width => 6);
   END LOOP;
   Close (Output);

END Merge_Sort_Illustration;




