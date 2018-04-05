PACKAGE BODY Generic_Stack IS
   Stack:ARRAY(1..Max) OF Item;
   Top: Integer RANGE 0..Max;

   PROCEDURE Push(X: IN Item; success: out boolean) IS
   BEGIN
      if (top < max) then
      Top := Top + 1;
         Stack(Top) := X;
         success := true;
      ELSE
         Success := false;
      END IF;
   END Push;

   PROCEDURE Pop(X: OUT Item; Success: OUT Boolean) IS
   BEGIN
      IF (Top > 0) THEN
         X := Stack(Top);
         Top := top - 1;
         success := true;
      ELSE
         Success := False;
      END IF;
   END Pop;

BEGIN
   Top := 0;
end generic_stack;
