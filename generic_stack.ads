GENERIC
   Max: Integer;
   TYPE Item IS PRIVATE;
   PACKAGE Generic_Stack IS
      PROCEDURE Push(X: IN Item; success: out boolean);
      PROCEDURE Pop(X: OUT Item; Success: OUT Boolean);
end generic_stack;
