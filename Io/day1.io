writeln("== Evaluate 1 + 1 and then 1 + \"one\" == ")
writeln("1+1=", 1+1)
writeln("1+\"one\"=", error := try(1 + "one")
                      error catch (Exception, error println
                                              writeln("So it's strongly typed.")
                                  )
        )
writeln()

writeln("Is 0 false or true: ", 0 or false)
writeln("Is '' false or true: ", "" or false)
writeln("Is nil false or true: ", nil or false)
writeln()

writeln("== How can you tell what slots a prototype supports ? ==")
writeln("Object slots names: ", Object slotNames)
writeln()

writeln("== What is the difference btw = (equals), := (colon equals) ::= (colon colon equals) ==")
Vehicle := Object clone
writeln("Vehicle: ", Vehicle slotNames)
Vehicle description := "Something to take you places"
writeln("Vehicle: ", Vehicle slotNames)
writeln(":= is setSlot ==> Vehicle: ", Vehicle description)
writeln("= is updateSlot ==> ", error := try(Vehicle nonexistingSlot = "This won't work")
                                error catch (Exception, error println)
        )
Vehicle name ::= "Lightning McQueen"
writeln("::= is newSlot (setSlot + setter) ==> ")
writeln("Vehicle: ", Vehicle name)
Vehicle setName("Luigi")
writeln("Vehicle: ", Vehicle name)
writeln()

writeln("== Execute the code in a slot given its name ==")
Vehicle hello := method(return "Hello, " .. name)
writeln("Vehicle: ", Vehicle slotNames)
hello := Vehicle getSlot("hello")
writeln (Vehicle hello)

