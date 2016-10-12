WITH Ada.Integer_Text_Io;
USE Ada.Integer_Text_Io;
WITH Ada.Text_Io;
USE Ada.Text_Io;

PROCEDURE Binary_Converter IS
   -- This program programs converts a decimal number to a binary
   -- number and vice versa

   procedure Binary (In_Number: IN Integer) IS
      -- This subprogram converts decimal input to binary output

      Divident  : Integer;
      Divisor   : CONSTANT Integer := 2;
      Quotient  : Integer;
      Remainder : Integer;
      Loop_Count : Integer;
      Out_String : String (1..64);
      Count_Temp : Integer;

   BEGIN

      Divident := In_Number;
      Loop_Count := 1;

      Binary_Loop:
         LOOP
         EXIT Binary_Loop WHEN Divident < Divisor;
         Remainder := Divident rem Divisor;
         Quotient := (Divident - Remainder) / Divisor;
         Divident := Quotient;
         Loop_Count := Loop_Count + 1;
      END LOOP Binary_Loop;

      count_temp := loop_count;
      Loop_Count := 0;
      Divident := In_Number;
      Print_Loop:
         LOOP
         EXIT Print_Loop WHEN Divident < Divisor;
         Remainder := Divident rem Divisor;
         Out_String ((Count_Temp - Loop_Count)..(Count_Temp - Loop_Count)) := Integer'Image(Remainder)(2..2);
         Quotient := (Divident - Remainder) / Divisor;
         Divident := Quotient;
         Loop_Count := Loop_Count + 1;
      END loop Print_Loop;

      Out_String (1..1) := Integer'Image (Quotient)(2..2);
      Put ("Result: ");
      Put (Out_String (1..Count_Temp));

   END Binary;

   procedure Decimal (In_String : IN String; String_Length : in integer) IS
      -- This subprogram converts binary input to decimal output

      Digit_Position : Integer;
      Digit : Integer;
      Out_Number : Integer;

   BEGIN

      Out_Number := 0;
      Digit_Position := 1;

      Decimal_Loop:
         LOOP
         EXIT Decimal_Loop WHEN Digit_Position > String_Length;
         Digit := Integer'Value (" " & In_String (Digit_Position..Digit_Position));
         Out_Number := Out_Number + Digit * (2**(Digit_Position - 1));
         Digit_Position := Digit_Position + 1;
         END LOOP Decimal_Loop;

      Put ("Result: ");
      Put (Out_Number, Width => 0);

   END Decimal;

   In_Base    : Integer;          -- Base of the input number
   In_Number  : Integer;          -- The input number
   In_String : String (1..64);
   string_length : integer;

   BEGIN
      Put ("Enter input base: ");
      Get(In_Base);
      Skip_Line;
      Put ("Enter input number: ");

      IF In_Base = 10 THEN
         Get (In_Number);

         Binary (In_Number);
      ELSIF In_Base = 2 THEN
         Get_Line (In_String, String_Length);
         Decimal (In_String, String_Length);
      END IF;

   END Binary_Converter;
