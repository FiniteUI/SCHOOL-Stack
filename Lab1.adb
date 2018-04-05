WITH Ada.Text_Io;
USE Ada.Text_Io;
WITH Unchecked_Conversion;
WITH Generic_Stack;
WITH Ada.Integer_Text_IO;
USE Ada.Integer_Text_IO;

PROCEDURE Lab1 IS
   X       : Character;
   Y       : Integer;
   Success : Boolean;
   Max     : Integer   := 5;


   FUNCTION IntegerToCharacter IS
   NEW Unchecked_Conversion(Integer, Character);
   FUNCTION CharacterToInteger IS
   NEW Unchecked_Conversion(Character, Integer);


   SUBTYPE Uppercase IS Character RANGE 'A'..'Z';
   SUBTYPE Lowercase IS Character RANGE 'a'..'z';

   TYPE MonthName IS
         (January,
          February,
          March,
          April,
          May,
          June,
          July,
          August,
          September,
          October,
          November,
          December);
   PACKAGE MonthNameIO IS NEW Ada.Text_IO.Enumeration_IO(MonthName);
   USE MonthNameIO;

   TYPE DateType IS
      RECORD
         Month : MonthName;
         Day   : Integer RANGE 1 .. 31;
         Year  : Integer;
         Count : Integer;
      END RECORD;

   Date : DateType := (August, 17, 1995, 1);







BEGIN
   Put("Enter the max space needed:");
   Get(Max);

   Put_Line("Specify the type of stack to use: 1 for Character stack, 2 for Integer stack, 3 for date stack.");
   Get(Y);

   IF (Y = 1) THEN
      DECLARE
         PACKAGE CharStack IS NEW Generic_Stack(Max, Character);
         USE CharStack;
      BEGIN
         Max := 0;
         Put_Line("Enter the characters. Enter # to end a string of characters and count it. Enter - to end. Enter ! to pop a string of characters.");
         LOOP
            EXIT WHEN X = '-';
            Get(X);

            IF (X = '!') THEN
               IF (Max /= 0) THEN
                  Put_Line("Error: Enter # to push a character count for the current string before popping.");
               ELSE
                  Pop(X, Success);
                  IF (Success = False) THEN
                     Put_Line("Error: Stack Empty. Cannot Pop until Pushed.");
                  ELSE
                     Max := CharacterToInteger(X);
                     Put(Max);
                     FOR I IN 1..Max LOOP
                        Pop(X, Success);
                        Put(X);
                     END LOOP; --End for I in 0..Max
                     New_Line;
                     Max := 0;
                     X := '!';
                  END IF;--End if success = false
               END IF;--End if max /= 0

            ELSIF (X IN Uppercase OR X IN Lowercase) THEN
               Push(X, Success);
               IF (Success = False) THEN
                  Put_Line("Error: Stack overflow. Cannot push until popped.");
               ELSE
                  Max := Max + 1;
               END IF;--End if success = false

            ELSIF (X = '#') THEN
               IF (Max = 0) THEN
                  Put_Line("Error, no characters have been entered yet.");
               ELSE
                  X := IntegerToCharacter(Max);
                  Push(X, Success);
                  IF (Success = False) THEN
                     Put("Error: Stack Overflow on character count push.");
                  ELSE
                     Max := 0;
                  END IF; --End if success = false
               END IF;--End if max = 0

            END IF;--What x is
         END LOOP; --End CharStack Loop
      END; --End CharStack
   END IF; --End if y = 1

   IF (Y = 2) THEN
      DECLARE
         PACKAGE IntStack IS NEW Generic_Stack(Max, Integer);
         USE IntStack;
      BEGIN
         Max := 0;
         Put_Line("Enter the integers. Enter 0 to end a string of integers and count it. Enter -1 to end. Enter -2 to pop a string of integers.");
         LOOP
            EXIT WHEN Y = -1;
            Get(Y);

            IF (Y = -2) THEN
               IF (Max = 0) THEN
                  Pop(Max, Success);
                  IF (Success = False) THEN
                     Put_Line("Error: Stack empty");
                  ELSE
                     Put(Max);
                     Put(", ");
                     FOR I IN 1..Max LOOP
                        Pop(Y, Success);
                        Put(Y);
                        Put(", ");
                     END LOOP;
                     New_Line;
                  END IF;

               ELSE
                  Put(Max);
                  Put(", ");
                  FOR I IN 1..Max LOOP
                     Pop(Y, Success);
                     Put(Y);
                     Put(", ");
                  END LOOP;
                  New_Line;
                  Y := -2;
               END IF;
               Max := 0;


            ELSIF (Y = 0) THEN
               IF (Max = 0) THEN
                  Put_Line("Eroor: No integers have been entered yet");
               ELSE
                  Push(Max, Success);
                  IF (Success = False) THEN
                     Put_Line("Error: Stack Overflow on integer count push");
                  ELSE
                     Max := 0;
                  END IF;--End if success = false
               END IF;--End if max = 0

            ELSIF (Y > 0) THEN
               Push(Y, Success);
               IF (Success = False) THEN
                  Put_Line("Error: Stack overflow. Cannot push until popped.");
               ELSE
                  Max := Max + 1;
               END IF;--End if success = false

            ELSIF (Y < -2) THEN
               Put_Line("Error: Invalid input.");

            END IF; --What y is
         END LOOP; --End IntStack Loop
      END; --End IntStack
   END IF; --End if y = 2

   IF (Y = 3) THEN
      DECLARE
         PACKAGE DateStack IS NEW Generic_Stack(Max, DateType);
         USE DateStack;

      BEGIN
         Max := 1;
         Put_Line("Enter 1 to push a date, 2 to pop a date,  3 to push a date string count, or 4 to end:");
         LOOP
            EXIT WHEN Y = 4;
            Get(Y);
            IF (Y = 1) THEN
               Put_Line("Enter a date in Month, dd, yyyy");
               Get(Date.Month);
               Get(Date.Day);
               Get(Date.Year);
               Date.Count := Max;
               New_Line;
               Push(Date, Success);
               IF (Success = False) THEN
                  Put_Line("Error: Stack overflow");
               ELSE
                  Max := Max + 1;
               END IF;--End if success = false

                        ElsIF (Y = 2) THEN
               Pop(Date, Success);
               IF (Success = False) THEN
                  Put_Line("Error: Stack Underflow");
               ELSE
                  Put(Date.Count);
                  New_Line;
                  Put(Date.Month);
                  Put(Date.Day);
                  Put(Date.Year);
                  New_Line;
                  FOR I IN 2..Date.Count LOOP
                     Pop(Date, Success);
                     Put(Date.Month);
                     Put(Date.Day);
                     Put(Date.Year);
                     New_Line;
                  END LOOP;
                  Max := 1;
               END IF;



            ElsIF (Y = 3) THEN
               Max := 1;

            ELSif (y > 4 or y < 1) then
               put("Error: Invalid input");

            END IF;--If y = 3


         END LOOP; --End DateStack Loop
      END; --End DateStack

   END IF;--End if y = 3;

END Lab1;
