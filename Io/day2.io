writeln("== The classic Fibonacci sequence ==")

fibRec := method(n, if(n==0, 0, if(n==1, 1, fibRec(n-1) + fibRec(n-2))))
for(i, 0, 10, writeln( "(" .. i .. ") " .. fibRec(i)))

fibLoop := method(n,
	l := list(0,1,1);
	for(i, 3, n, l append (l at(i-1) + l at(i-2)));
	return l at(n)
)

for(i, 0, 10, fibLoop(i) println)

writeln("----------------------------------------------------------------------")

writeln("== How would you change / to return 0 if the denominator is zero? ==")
Number div := Number getSlot("/")
Number / = method(n, if(n==0, 0, self div(n)))

writeln("2/0=", 2/0)
writeln("2/4=", 2/4)
writeln("4/2=", 4/2)
writeln("----------------------------------------------------------------------")

writeln("== Sum of a 2 dim array ==")
sum := method(l,
	if(l == nil,
	0,
	l flatten sum)
)

sum(list(list(1,2), list(3,4), list(4,5), list(6,7))) println
sum(nil) println
writeln("----------------------------------------------------------------------")

writeln("== Add a slot called myAverage to a list that computes average of all numbers ==")
myList := List clone
myList myAverage := method(if(self size == 0,
				0,
				s := 0;
				e := try ( s =  (self sum) / (self size) );
				e catch (Exception, Exception raise("Not a number");
					);
				return s;
				)
			)

for (i, 1, 10, myList append(i))
myList myAverage println
myList append("notAnNumber")
e := try(myList myAverage)
e catch (Exception, e println)
writeln("----------------------------------------------------------------------")

writeln("== A protote for a 2 dim list ==")
MultiArray := Object clone do (
	array := List clone;
	dim := method(x, y,
		self array setSize(y);
		row := List clone setSize(x);
		for (i, 0, self array size - 1, self array atPut(i, row clone))
		);
	set := method(x, y, value, (self array at(y)) atPut(x,value) );
	get := method(x, y, return (self array at(y)) at(x));
	writeToFile := method(filePath,
		file := File clone openForUpdating(filePath);
		#file write(self array asJson);
		file write(self array serialized);
		file close;
	);
	loadFromFile := method(filePath,
		file := File clone openForReading(filePath);
		line := file readLine;
		self array = doString(line);
		file close;
	);
)

myArray := MultiArray clone
myArray dim(2, 2)
myArray set(0, 0, 6)
myArray set(1, 0, 7)
myArray set(0, 1, 8)
myArray set(1, 1, 5)
myArray array println
myArray get(1, 1) println

myArray writeToFile("matrix.dat")
myArray2 := MultiArray clone
myArray2 loadFromFile("matrix.dat")
myArray2 println
writeln("----------------------------------------------------------------------")

writeln("== Guess Number Game ==")
pick := (Random clone) value(1,100) round

check := method(a, b,
		if (a < b, "Hotter. " print, "Colder. " print);
)
guesses := List clone
for (i, 1, 10,
	"Guess a number btwn 1 & 100: " print;
	guess := (File standardInput) readLine asNumber;
	if(guess == pick,
		"You win !" println; break,
		distance := (guess - pick) abs;
		guesses push(distance);
		if (distance < guesses at(0), "Hotter. " print, "Colder. " print);
                writeln ("Try again, remaining: " .. (10 - i) );
	);
)
("Number was " .. pick) println