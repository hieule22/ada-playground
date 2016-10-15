WITH Ada.Text_Io;         USE Ada.Text_Io;
WITH Ada.Float_Text_Io;   USE Ada.Float_Text_Io;

PROCEDURE Trig_Calculator IS
   -- This procedure computes the trigonometric functions from values
   -- input by the user

   -- Types of trigonometric calculations
   TYPE Trig_Type IS (Sin, Cos, Tan, Cot, Cosec, Sec);

   -- instantiate package for trigonometric I/O
   PACKAGE Trig_Io IS NEW Ada.Text_Io.Enumeration_Io (Enum => Trig_Type);

   -- Variable declaration
   X : Float;
   Trig_Function : Trig_Type;
-------------------------------------------------------------------------------------
   function Factorial (X : IN Integer) return integer IS
      -- This procedure calculates the factorial of a positive integer

      -- Variable declaration
      Factor : Integer;
      Result : Integer;

   BEGIN
      Result := 1;
      Factor := 1;
      Factorial_Loop:
      LOOP
         EXIT Factorial_Loop WHEN Factor > X;
         Result := Result * Factor;
         Factor := Factor + 1;
      END LOOP Factorial_Loop;
      return Result;
   END Factorial;
--------------------------------------------------------------------------------------
   function Sin (X : in Float) return float IS
      K : Integer;
      Denominator : Integer;
      Result : Float;

   BEGIN
      Result := 0.0;
      K := 0;
      Sin_Calc_Loop:
         LOOP
         EXIT Sin_Calc_Loop WHEN K > 5;
         Denominator := Factorial (2*k+1);
         Result := Result + Float((-1)**K) * Float(X**(2*K+1)) / Float(Denominator);
         K := K + 1;
      END LOOP Sin_Calc_Loop;
      RETURN Result;

   END Sin ;

   ---------------------------------------------------------------------------------------
   function Cos (X : in Float) return float IS
      K : Integer;
      Denominator : Integer;
      Result : Float;

   BEGIN
      Result := 0.0;
      K := 0;
      Sin_Calc_Loop:
         LOOP
         EXIT Sin_Calc_Loop WHEN K > 5;
         Denominator := Factorial (2*K);
         Result := Result + Float((-1)**K) * Float(X**(2*K)) / Float(Denominator);
         K := K + 1;
      END LOOP Sin_Calc_Loop;
      RETURN Result;

   END Cos;
   ---------------------------------------------------------------------------------------
   function Tan (X : in Float) return float IS
      Result : Float;
   BEGIN
      Result := Sin (x) / Cos (x);
      RETURN Result;
   END Tan;
   ---------------------------------------------------------------------------------------
   function Cot (X : in Float) return float IS
      Result : Float;
   BEGIN
      Result := 1.0 / Tan (x);
      RETURN Result;
   END cot;
   ---------------------------------------------------------------------------------------
   function Cosec (X : in Float) return float IS
      result : float;
   BEGIN
      Result := 1.0 / Sin (X);
      return result;
   END Cosec;
   ---------------------------------------------------------------------------------------
   function Sec (x: in Float) return float IS
      result : Float;
   BEGIN
      Result := 1.0 / Cos (X);
      RETURN Result;
   END sec;
------------------------------------------------------------------------------------------
   Result : Float;
   Trig_Value : String (1..32);
   Length : Integer;

BEGIN
   Put (Item => "What trigonometric functions do you want to evaluate? ");
   Get_Line (Item => Trig_Value, Last => Length);
   IF Trig_Value (1..5) /= "cosec" THEN
   X := float'Value (Trig_Value (4..Length));
   Trig_Function := Trig_Type'Value (Trig_Value (1..3));

   IF Trig_Function = Sin THEN
      result := sin (x);
   ELSIF Trig_Function = Cos THEN
      result := cos (x);
   ELSIF Trig_Function = Tan THEN
      result := tan (x);
   ELSIF Trig_Function = Cot THEN
      result := cot (x);
   ELSIF Trig_Function = Sec THEN
         Result := Sec (X);
      END IF;
      ELSE
         X := Float'Value (Trig_Value (6..Length));
            Result := Cosec (X);
   END IF;
   Put (Item => Result, Fore => 1, Aft => 3, Exp => 0);
END Trig_Calculator;
