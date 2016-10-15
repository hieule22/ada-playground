-- Name of Creator    : Hieu Trung Le
-- Date of Creation   : November 7th, 2014
-- Date of Completion : N/A
-------------------------------------------------
-- Predefined packages used
WITH Ada.Text_Io, Ada.Float_Text_Io;
USE  Ada.Text_Io, Ada.Float_Text_Io;
-------------------------------------------------
PROCEDURE Ice_Skating IS
   -- This program computes and displays scores received
   -- by athletes in different ice skating competitions

   -- Type and subtype declarations
      -- Competition description subtype (<= 20 characters)
   SUBTYPE Description_Type IS String (1..20);
      -- Skater name subtype (<= 60 characters)
   SUBTYPE Name_Type IS String (1..60);
      -- Score range subtype (from 0 to 10)
   SUBTYPE Score_Range IS Float RANGE 0.00..10.00;
      -- Range of participating judges (7 in total)
   TYPE Judge_Range IS RANGE 1..7;
   PACKAGE Judge_IO IS NEW Ada.Text_Io.Integer_Io (Num => Judge_Range);
      -- Range of participating skaters (<= 50 skaters)
   TYPE Skater_Range IS RANGE 0..50;
      -- Range of competitions skaters may participate in (<= 20 competitions)
   TYPE Competition_Range IS RANGE 0..20;

   -- Array type declarations
      -- Array type of score given to specific skater in specific competition by specific judge
   TYPE Score_Array IS ARRAY (Skater_Range, Competition_Range, Judge_Range) OF Score_Range;
      -- Array type of average score given by specific judge to specific skater
   TYPE Judge_Average_Array IS ARRAY (Skater_Range, Judge_Range) OF Score_Range;
      -- Array type of average score earned by specific skater in specific competition
   TYPE Average_Array IS ARRAY (Skater_Range, Competition_Range) OF Score_Range;
      -- A boolean sentinel to signal if skater participates in specific competition
   TYPE Participation_Array IS ARRAY (Skater_Range, Competition_Range) OF Boolean;
      -- Record type of skater information, i.e. name, name length, overall score
      -- and number of competition skater participates in
   TYPE Skater_Rec IS RECORD
      Name    : Name_Type;           -- Skater name
      Length  : Integer;             -- No of characters in skater name
      Overall : Score_Range;         -- Skater overall score
      Count   : Competition_Range;   -- Number of competitions which a specific skater takes
   END RECORD;                       -- part in, which may not include all listed competitions
      -- Array type of skater record
   TYPE Skater_Array IS ARRAY (Skater_Range) OF Skater_Rec;
      -- Record type storing competition description, i.e. description and length
   TYPE Competition_Rec IS RECORD
      Description : Description_Type;   -- Competition description
      Length      : Integer;            -- No of characters in description
   END RECORD;
   -- Array type of competition record
   TYPE Competition_Array IS ARRAY (Competition_Range) OF Competition_Rec;
   -----------------------------------------------------------------------
   PROCEDURE Read_Input (Competition : OUT Competition_Array;
                             C_Count : OUT Competition_Range;
                              Skater : OUT Skater_Array;
                             S_Count : OUT Skater_Range;
                               Score : OUT Score_Array;
                       Participation : OUT Participation_Array) IS
      -- This subprogram opens and reads data from input file
   BEGIN
      -- Determine number and descriptions of competitions
      C_Count := 0;   -- Initialize competition count to 0
      LOOP
         C_Count := C_Count + 1;   -- Increment count
         Get_Line (Competition(C_Count).Description,
                   Competition(C_Count).Length);
         -- Exit when reaching End of Competitions
         EXIT WHEN Competition(C_Count).Description
               (1..Competition(C_Count).Length) =
               "End of Competitions";
      END LOOP;
      -- Decrement competition count by 1 to avoid counting
      -- End of Competitions
      C_Count := C_Count - 1;
      -- Determine skater number, skater names and scores
      S_Count := 0;   -- Initialize skater count to 0
      LOOP
         S_Count := S_Count + 1;   -- Increment skater count
         Get_Line (Skater(S_Count).Name,      -- Get skater name
                   Skater(S_Count).Length);   -- Get skater name length
         Skater(S_Count).Count := 0;   -- Initialize number of competitions which
                                       -- skater participates in to 0
         FOR C IN 1..C_Count LOOP
            Get (Score (S_Count, C, Judge_Range'First));   -- Get score
            IF End_Of_Line OR End_Of_File THEN
            -- If end of line or end of file is reached right after fetching first
            -- score then it is not a competition which skater takes part. This
            -- operates under assumption that there is no preceding white spaces
            -- before a line or file terminator
            -- Assign participation status to False
               Participation(S_Count, C) := False;
            ELSE
            -- Otherwise continue taking in scores as per normal
               FOR J IN 2..Judge_Range'Last LOOP
                  Get(Score(S_Count, C, J));
               END LOOP;
            -- Increment number of competitions skater participates in
               Skater(S_Count).Count := Skater(S_Count).Count + 1;
            -- Assign participation status to True
               Participation(S_Count, C) := True;
            END IF;
         END LOOP;
         EXIT WHEN End_Of_File;   -- Exit when reaching end of file
         Skip_Line;   -- Skip line before calling get_line
      END LOOP;
   END Read_Input;
   -----------------------------------------------------------------------
   PROCEDURE Average_Calc (C_Count : IN Competition_Range;
                           S_Count : IN Skater_Range;
                             Score : IN Score_Array;
                           Average : OUT Average_Array;
                     Participation : IN Participation_Array) IS
      -- This procedure calculates average score earned by specific
      -- athlete in specific competition
      ---------------------------------------------------------------
      FUNCTION Minimum (Score : IN Score_Array;
                            C : IN Competition_Range;
                            S : IN Skater_Range) RETURN Score_Range IS
         -- This function returns lowest score earned by skater S
         -- in competition C
         Minimum : Score_Range;
      BEGIN
         -- Initialize minimum score to 1st judge's score
         Minimum := Score(S, C, Judge_Range'First);
         FOR J IN Judge_Range LOOP
            IF Score(S, C, J) < Minimum THEN
               Minimum := Score(S, C, J);
            END IF;
         END LOOP;
         RETURN Minimum;
      END Minimum;
      ---------------------------------------------------------------
      FUNCTION Maximum (Score : IN Score_Array;
                            C : IN Competition_Range;
                            S : IN Skater_Range) RETURN Score_Range IS
         -- This function returns highest score earned by skater C
         -- in competition S
         Maximum : Score_Range;
      BEGIN
         -- Initialize maximum score to 1st judge's score
         Maximum := Score(S, C, Judge_Range'First);
         FOR J IN Judge_Range LOOP
            IF Score(S, C, J) > Maximum THEN
               Maximum := Score(S, C, J);
            END IF;
         END LOOP;
         RETURN Maximum;
      END Maximum;
      ---------------------------------------------------------------
      Sum : Float;   -- Sum of scores given by all judges
   BEGIN
      FOR S IN 1..S_Count LOOP
         FOR C IN 1..C_Count LOOP
            IF Participation(S, C) THEN   -- Check participation status
               Sum := 0.0;   -- Initialize sum to 0
               FOR J IN Judge_Range LOOP
                  Sum := Sum + Score(S, C, J);
               END LOOP;
               -- Subtract max and min scores from sum
               Sum := Sum - Maximum (Score, C, S) - Minimum (Score, C, S);
               -- Compute competition average by dividing sum by no of
               -- judges, remembering to exclude the 2 max and min judges
               Average (S,C) := Sum / Float(Judge_Range'Pos(Judge_Range'Last) -
                                            Judge_Range'Pos(Judge_Range'First) - 1);
            END IF;
         END LOOP;
      END LOOP;
   END Average_Calc;
   -----------------------------------------------------------------------
   PROCEDURE Judge_Average_Calc (C_Count : IN Competition_Range;
                                  Skater : IN Skater_Array;
                                 S_Count : IN Skater_Range;
                                   Score : IN Score_Array;
                           Judge_Average : OUT Judge_Average_Array;
                           Participation : IN Participation_Array) IS
      -- This subprogram calculates average score given by specific
      -- judge to specific skater
      Sum : Float;   -- Sum of scores given by specific judge
   BEGIN
      FOR S IN 1..S_Count LOOP
         FOR J IN Judge_Range LOOP
            Sum := 0.0;         -- Initialize sum to 0
            FOR C IN 1..C_Count LOOP
               IF Participation(S,C) THEN   -- Check participation status
                  Sum := Sum + Score (S, C, J);
               END IF;
            END LOOP;
            -- Compute judge's average score by dividing sum by
            -- no of competitions skater takes part in
            Judge_Average(S,J) := Sum / Float(Skater(S).Count);
         END LOOP;
      END LOOP;
   END Judge_Average_Calc;
   -----------------------------------------------------------------------
   PROCEDURE Overall_Calc (C_Count : IN Competition_Range;
                            Skater : IN OUT Skater_Array;
                           S_Count : IN Skater_Range;
                           Average : IN Average_Array;
                     Participation : IN Participation_Array) IS
      -- This subprogram calculates overall average score earned by
      -- specific skater
      Sum : Float;   -- Sum of average scores given to skater in all competitions
   BEGIN
      FOR S IN 1..S_Count LOOP
         Sum := 0.0;   -- Initialize sum to 0
         FOR C IN 1..C_Count LOOP
            IF Participation (S,C) THEN   -- Check participation status
               Sum := Sum + Average (S,C);
            END IF;
         END LOOP;
         -- Compute overall average score by dividing sum by no of competitions
         -- skater participates in
         Skater(S).Overall := Sum / Float(Skater(S).Count);
      END LOOP;
   END Overall_Calc;
   -----------------------------------------------------------------------
   PROCEDURE Print_Output (Competition : IN Competition_Array;
                               C_Count : IN Competition_Range;
                                Skater : IN Skater_Array;
                               S_Count : IN Skater_Range;
                                 Score : IN Score_Array;
                               Average : IN Average_Array;
                         Judge_Average : IN Judge_Average_Array;
                         Participation : In Participation_Array) IS
      -- This subprogram outputs processed data into an external file
   BEGIN
      -- Print skater name
      FOR S IN 1..S_Count LOOP
         Put_Line ("Skater: " & Skater(S).Name (1..Skater(S).Length));
         -- Print competition column header
         New_Line;
         Put ("Competition");
         -- Print judge list
         FOR J IN Judge_Range LOOP
            Set_Col (7*Judge_Range'Pos(J) + 20);
            Put ("Judge");   Judge_Io.Put (J,0);
         END LOOP;
         Set_Col (7*(Judge_Range'Pos(Judge_Range'Last)+1) + 20);
         Put ("Avg");
         -- Print dashes
         New_Line;
         Put ("-----------");
         FOR J IN Judge_Range LOOP
            Set_Col (7*Judge_Range'Pos(J) + 20);
            Put ("------" );
         END LOOP;
         Set_Col (7*(Judge_Range'Pos(Judge_Range'Last)+1) + 20);
         Put ("----");
         -- Print unprocessed scores
         FOR C IN 1..C_Count LOOP
            IF Participation (S,C) THEN
            -- Avoid scores for non-existent competitions by only considering
            -- those with TRUE participation status
               New_Line;
               Put (Competition(C).Description(1..Competition(C).Length));
               FOR J IN Judge_Range LOOP
                  Set_Col (7*Judge_Range'Pos(J) + 20);
                  Put (Score(S,C,J), 2,1,0);
               END LOOP;
               Set_Col (7*(Judge_Range'Pos(Judge_Range'Last)+1) + 20);
               Put (Average(S,C),2,2,0);
            END IF;
         END LOOP;
         -- Print judge's average scores
         New_Line (2);
         Put ("Averages per Judge");
         FOR J IN Judge_Range LOOP
            Set_Col (7*Judge_Range'Pos(J) + 20);
            Put (Judge_Average(S, J),2,2,0);
         END LOOP;
         -- Print skater's overall average score
         New_Line;
         Put ("Overall Average Score");
         Set_Col (7*(Judge_Range'Pos(Judge_Range'Last)+1) + 20);
         Put (Skater(S).Overall, 2,2,0);
         New_Line;
         FOR A IN 1..80 LOOP
            Put ("=");
         END LOOP;
         New_Line;
      END LOOP;
   END Print_Output;
   ----------------------------------------------------------------------------
   -- Array variables
   Competition       : Competition_Array;   -- Array of competition records
   C_Count           : Competition_Range;   -- Total number of competitions
   Skater            : Skater_Array;        -- Array of skater records
   S_Count           : Skater_Range;        -- Total number of skaters
   Score             : Score_Array;         -- Array of scores
   Average           : Average_Array;       -- Array of competition averages
   Judge_Average     : Judge_Average_Array; -- Array of judge averages
   Participation     : Participation_Array; -- Array of competition participation status

BEGIN
   -- Call Read_Input to read data from input file
   Read_Input (Competition, C_Count, Skater, S_Count, Score, Participation);

   -- Call Average_Count to compute average score earned by
   -- each skater in each competition
   Average_Calc (C_Count, S_Count, Score, Average, Participation);

   -- Call Judge_Average_Calc to compute average score given by
   -- each judge to each skater
   Judge_Average_Calc (C_Count, Skater, S_Count, Score, Judge_Average, Participation);

   -- Call Overall_Calc to compute overall average score earned by
   -- eachskater
   Overall_Calc (C_Count, Skater, S_Count, Average, Participation);

   -- Call Print_Output to output result onto external file
   Print_Output (Competition, C_Count, Skater, S_Count,
                 Score, Average, Judge_Average, Participation);

END Ice_Skating;
