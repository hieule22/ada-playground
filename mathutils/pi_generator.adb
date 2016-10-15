WITH Ada.Float_Text_Io; USE Ada.Float_Text_Io;

PROCEDURE Pi_Generator IS
   Pi_Approx : Float;
   Inverse_Pi : Float;
   K : Integer;

   FUNCTION Factorial (X : IN Integer) RETURN Integer IS
      Result : Integer;
      Multiplier : Integer;
   BEGIN
      Multiplier := X;
      Result := 1;
      Multiply_Loop:
         LOOP
         EXIT Multiply_Loop WHEN Multiplier = 1;
         Result := Result * Multiplier;
         Multiplier := Multiplier - 1;
      END LOOP Multiply_Loop;
      RETURN Result;
   END Factorial;
   Numerator : Integer;
   Denominator : Integer;

   FUNCTION Sqrt (X : IN Float) RETURN Float IS
      Tolerance : constant Float := 0.0001;
      Approx : Float;
   BEGIN
      Approx := X / 2.0;
      Calculate_Square_Root:
         LOOP
         EXIT Calculate_Square_Root WHEN ABS(Approx**2 - X) < Tolerance;
         Approx := 0.5 * (Approx + X / Approx);
      END LOOP Calculate_Square_Root;
      RETURN Approx;
   END Sqrt;

BEGIN
   Inverse_Pi := 0.0;
   K := 0;
   Addition_Loop:
      LOOP
      EXIT Addition_Loop WHEN K = 10;
      Numerator := Factorial (4*K) * (1103 + 26390*K);
      Denominator := Factorial (K) * (396**(4*K));
      Inverse_Pi := Inverse_Pi + Float (Numerator) / Float (Denominator);
      K := K + 1;
   END LOOP Addition_Loop;
   Pi_Approx := 1.0 / (2.0*Sqrt(2.0) / 9801.0 * Inverse_Pi);
   Put (Item => Pi_Approx, Fore => 1, Aft => 10);
END Pi_Generator;
