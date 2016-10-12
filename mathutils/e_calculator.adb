WITH Ada.Float_text_io, ada.integer_text_io, Ada.Text_Io;
USE Ada.Text_Io;

PROCEDURE ln2_Calculator IS
   -- This program makes use of infinitely alternating series
   -- to calculate the natural logarithm of 2
   Ln2 : Float;

BEGIN
   Ln2 := 0.0;
   FOR N IN 1..100 LOOP
      Ln2 := Ln2 + (-1.0)**(N+1) * 1.0/Float(N);
      Put ("ln2 = ");
      Ada.Float_Text_Io.Put (Ln2, Fore => 1, Aft =>10, Exp => 0);
      New_Line;
   END LOOP;

   -- Print ln2


end ln2_calculator;
