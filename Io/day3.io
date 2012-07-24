writeln("== Enhance the XML program to add spaces to show indentation and support attributes ==")
OperatorTable addAssignOperator(":", "atPutNumber")
Map atPutNumber := method(
  self atPut(
    call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""), call evalArgAt(1)
  )
)
curlyBrackets := method(
  m := Map clone
  call message arguments foreach(arg, m := m doString(arg asString))
  m
)


Builder := Object clone
Builder indent := 0
Builder startTag := method(name, args,
  attributes := ""
  firstContent := ""
  if (args at(0) != nil, firstContent := doMessage(args at(0)))
  if (firstContent type == "Map", firstContent foreach(k, v, attributes := attributes .. k .. " = " ..  "\"" .. v .."\" " ); args removeFirst )
  writeln(" " repeated (indent) .. "<" .. name .. " " .. attributes .. ">")
  indent = indent + 2
  args
)
Builder endTag := method(name,
  indent = indent - 2
  writeln(" " repeated (indent) .. "</" .. name .. ">")
)
Builder forward := method(
  args := startTag(call message name, call message arguments)
  args foreach(
    arg,
    content := self doMessage(arg)
    if(content type == "Sequence", writeln( " " repeated(indent) .. content)
    )
  )
  endTag(call message name)
)
Builder ul(li("Io"),li("Lua"),li("Javascript"))

Builder book({author : "Tate"}, ul(li("Io"),li("Lua"),li("Javascript")))
writeln("----------------------------------------------------------------------")

writeln("== Create a list syntax that use brackets ==")

curlyBrackets := method(
  l := List clone
  call message arguments foreach(arg, l push(doMessage(arg)))
  l
)

l := doString("{1,2,3,{4,5,6},{7,8}}")
l println
