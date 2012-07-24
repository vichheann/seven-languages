#!/bin/sh
exec scala -savecompiled "$0" "$@"
!#
val list = List("one", "two", "three")
println(list.foldLeft(0)( (sum, word) => sum + word.length))

val sum = (0 /: list){ (sum, word) => sum + word.length }
println(sum)


