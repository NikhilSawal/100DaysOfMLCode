# Data Types

# Numberic [floating point values]
a <- 2.2

# Integer
b <- 2

# Logical [True/False]
c <- TRUE

# Characters [String]
# Can use single or double quotes [' '/" "]
d <- "Hello World!"

# Class Functions - Check Datatypes
class(a)
class(b)
class(c)
class(d)

# b inspite of being an interger is stored as numeric, because all integers are saved 
# as numeric

# Vector
# A vector is a one-dimensional array, that can hold character, logical or numeric data
# We use the combine funtion to create a vector

# Numeric Vector
num <- c(1,2,3,4,5)                # c() represents the combine function

class(num)
#Since every element in the above vector is numeric the class of num is numeric

char <- c("x", "y", "z")
class(char)

bool <- c(T, F)
class(bool)

# Key Points about vectors
# - All elements within a vector should be of the same data type
# - If the elements belong to some other data type, R will convert the class. This 
#   particular situation is referred to as coercion

f <- c(TRUE, 1, 4, 5)
print(f)
class(f)
# since the other elements in the vector f are numeric, TRUE is converted to numeric
# True is converted to 1
# False is converted to 0
# Another example

g <- c("afd", 1, 3, 6)
print(g)
class(g)
# Now, in case of the vector g, it is not possible to convert the character "afd" to a 
# numeric type, so the other elements are converted to a character data type

# Assign names to vector elements using names() function
temp <- c(32,33,36,42,37,41,33)
names(temp) <- c("Mon", "Tue", "Wed", "Thurs", "Fri", "Sat", "Sun")
print(temp)

# to make the above code reusable 
days <- c("Mon", "Tue", "Wed", "Thurs", "Fri", "Sat", "Sun")
names(temp) <- days

## Vector Operations
# Element to Element operations

v1 <- c(1,2,3)
v2 <- c(3,4,5)

# Element wise Addition
print(v1 + v2)
# Element wise Subtraction
print(v1 - v2)
# Element wise Division
print(v1 / v2)
# Element wise Multiplication
print(v1 * v2)

# Vector built-in functions
sum(v1)
mean(v2)
sd(v1)
max(v2)
min(v1)
prod(v2)
length(v1)

## Indexing vector and slicing
v1 <- c(1,2,3,4,6)
v2 <- c('a','b','c','d','e')

# Indexing in R starts at 1, unlike other programming languages, where it starts at 0

# index a single element
v1[1]

# to grab the first and second element
v1[c(1,2)]
v1[1:2]

# to get the last 3 elements
v1[3:5]

# Indexing using names
v <- c(1,2,3,4)
names(v) <- c('w', 'x', 'y', 'z')

v[2]
v['x']
v[c('x','y','z')]

# Indexing or filtering by comparison or using logical statements

# Index all elements greater tha 2
print(v[v>2])
print(v>2)
# Notice the difference b/w the above two statements

# comparison operators - Evaluates True/False

3 > 4
2 < 9
5 >= 5
2 <= 4
2 == 6
2 !=2

# Note that '=' is an assignment operator and CANNOT be used for comparison
# So doing the following will throw an error
print(2 = 4)





