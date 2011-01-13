MODULE $(ModuleName);

(* ------------------------------------------------------------------------
 * (C) 2011 by Alexander Iljin
 * ------------------------------------------------------------------------ *)

$(Import)

(** ------------------------------------------------------------------------
  * This module implements a stack of $(ItemType) objects. All procedures
  * (except New) expect 'stack' parameter to be # NIL. All Stack instances
  * must be created using the New procedure.
  * ----------------------------------------------------------------------- *)

TYPE
   Item = POINTER TO RECORD
      this: $(ItemType);
      next: Item;
   END;

   Stack* = POINTER TO StackDesc;
   StackDesc = RECORD                       (* Abstract object *)
   END;
   StdStack = POINTER TO RECORD (StackDesc) (* Implementation object *)
      first: Item;
      size: INTEGER; (* number of items in the stack *)
   END;

PROCEDURE New* (old: Stack): Stack;
VAR
   res: StdStack;
BEGIN
   IF (old # NIL) & (old IS StdStack) THEN
      res := old (StdStack);
   ELSE
      NEW (res);
   END;
   res.first := NIL;
   res.size := 0;
   RETURN res
END New;

PROCEDURE Size* (stack: Stack): INTEGER;
BEGIN
   RETURN stack (StdStack).size
END Size;

PROCEDURE Push* (stack: Stack; this: $(ItemType));
(** 'this' may be NIL. *)
VAR
   std: StdStack;
   item: Item;
BEGIN
   std := stack (StdStack);
   NEW (item);
   item.this := this;
   item.next := std.first;
   std.first := item;
   INC (std.size);
   ASSERT (std.size > 0, 60);
END Push;

PROCEDURE Pop* (stack: Stack): $(ItemType);
VAR
   std: StdStack;
   res: $(ItemType);
BEGIN
   std := stack (StdStack);
   res := std.first.this;
   std.first := std.first.next;
   DEC (std.size);
   ASSERT ((std.size = 0) = (std.first = NIL), 60);
   RETURN res
END Pop;

PROCEDURE Find* (stack: Stack; this: $(ItemType)): BOOLEAN;
(** Return TRUE if 'this' was found in the 'stack'. *)
VAR
   item: Item;
BEGIN
   item := stack (StdStack).first;
   WHILE (item # NIL) & (item.this # this) DO
      item := item.next;
   END;
   RETURN item # NIL
END Find;

PROCEDURE Peek* (stack: Stack): $(ItemType);
BEGIN
   RETURN stack (StdStack).first.this
END Peek;

END $(ModuleName).
