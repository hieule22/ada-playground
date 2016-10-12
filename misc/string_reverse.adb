WITH Ada.Text_Io;   USE Ada.Text_Io;

PROCEDURE String_Reverse IS
   In_String : String (1..32);
   Length : Integer;
   Letter_Position : Integer;

BEGIN
   Put ("Enter a string: ");
   Get_Line (In_String, Length);

   Reverse_Loop:
      FOR Letter_Position IN REVERSE 1..Length LOOP
      Put (In_String(Letter_Position));
   END LOOP Reverse_Loop;
END String_Reverse;


