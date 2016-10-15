WITH Ada.Text_Io, Ada.Integer_Text_Io, Ada.Io_Exceptions;
USE  Ada.Text_Io, Ada.Integer_Text_Io, Ada.Io_Exceptions;

PROCEDURE Date_Validation IS
   -- This procedure ensures that the input data is valid
   TYPE Month_Type IS (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec);
   SUBTYPE Month_Subtype IS Month_Type RANGE Jan..Dec;
   SUBTYPE Date_Length IS Integer RANGE 1..31;
   TYPE Month_Length IS ARRAY (Month_Type) OF Integer;

   PACKAGE Month_Io IS NEW Ada.Text_Io.Enumeration_Io (Month_Type);

   Month : Month_Type;
   Date  : Date_Length;
   Length : CONSTANT Month_Length := (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

   BEGIN
-- Prompt user for date input
      LOOP
         Put ("Enter a date: ");
         Input_Block:
            BEGIN
               Month_IO.Get (Month);
               Get (Date);
               EXIT;
            EXCEPTION
               WHEN Ada.Io_Exceptions.Data_Error | Constraint_Error =>
                  IF (Date IN 1..Length(Month)) THEN
                     Put_Line ("Month entered is invalid");
                     Skip_Line;
                  ELSIF (Month IN month_subtype) THEN
                     Put_Line ("Date entered is invalid");
                     Skip_Line;
                  ELSE
                     put_Line ("Data entered is invalid");
                  END IF;
            END Input_Block;
         END LOOP;

            -- Echo print user input
         Put ("The input date: ");
            Month_Io.Put (Month);
            Put (Date,3);
      END Date_Validation;
