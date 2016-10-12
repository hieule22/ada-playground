WITH Ada.Text_Io;   USE Ada.Text_Io;
WITH Ada.Float_Text_Io;   USE Ada.Float_Text_Io;
WITH Ada.Integer_Text_Io;   USE Ada.Integer_Text_Io;
WITH Ada.Numerics;    use ada.numerics;
WITH Ada.Numerics.Elementary_Functions;   USE Ada.Numerics.Elementary_Functions;

PROCEDURE Trig_Table IS
   -- This program displays a table of Sines and Cosines
   -- of values from 0 to 359 degrees

   Radians_Per_Degree : CONSTANT Float := 2.0 * Pi / 360.0;
   Degrees : Integer RANGE 0..360;   -- Loop control variable

BEGIN   -- Trig table
   -- Display table headings
   Put ("Degrees");
   Set_Col (To => 12);   -- Move writing marker to column 12
   Put ("Sine");
   Set_Col (To => 22);   -- Move writing marker to column 22
   Put ("Cosine");
   New_Line (2);

   -- Display the values
   Degrees := 0;
   Table_Loop:
      LOOP
      EXIT Table_Loop WHEN Degrees > 359;
      -- Display degrees
      Put (Degrees, Width => 5);
      -- Display the sine value
      Set_Col (To => 10);
      Put (Sin(Radians_Per_Degree * Float(Degrees)),
         Fore => 2,
         Aft => 4,
         Exp => 0);
      -- Display the cosine value
      Set_Col (To => 21);
      Put (Cos(Radians_Per_Degree * Float(Degrees)),
         Fore => 2,
         Aft => 4,
         Exp => 0);
      New_Line;
      Degrees := Degrees + 1;
   END LOOP Table_Loop;
END Trig_Table;

