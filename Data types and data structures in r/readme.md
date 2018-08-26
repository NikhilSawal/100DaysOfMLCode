R Data types and Data structures
================
Nikhil Sawal
August 11, 2018

1. Data Types
=============

### 1.1 Numberic \[floating point values\]

``` r
a <- 2.2
```

### 1.2 Integer

``` r
b <- 2
```

### 1.3 Logical \[True/False\]

``` r
c <- TRUE
```

### 1.4 Characters \[String\]

##### Can use single or double quotes \["" / ""\]

``` r
d <- "Hello World!"
```

2. Function class() - Checks Datatype
=====================================

``` r
class(a)
```

    ## [1] "numeric"

``` r
class(b)
```

    ## [1] "numeric"

``` r
class(c)
```

    ## [1] "logical"

``` r
class(d)
```

    ## [1] "character"

**NOTE:** `b`, inspite of being an interger is stored as numeric, because all integers are stored as numeric

3. Vector
=========

A vector is a one-dimensional array, that can hold character, logical or numeric data. We use the combine funtion to create a vector.

### 3.1 Numeric Vector

``` r
num <- c(1,2,3,4,5)                # c() represents the combine function

class(num)
```

    ## [1] "numeric"

Since every element in the above vector is numeric the class of `num` is "numeric".

### 3.2 Character and Boolean vector

``` r
char <- c("x", "y", "z")
class(char)
```

    ## [1] "character"

``` r
bool <- c(T, F)
class(bool)
```

    ## [1] "logical"

Key Points about vectors

-   All elements within a vector should be of the **SAME DATA TYPE**
-   If the elements belong to some other data type, R will convert their class. This particular situation is referred to as coercion

``` r
f <- c(TRUE, 1, 4, 5)
print(f)
```

    ## [1] 1 1 4 5

Since the other elements in the vector f are numeric, TRUE is converted to numeric

-   True is converted to 1
-   False is converted to 0

Now,if we check the class of the vector `f`, it should be numeric.

``` r
class(f)
```

    ## [1] "numeric"

Another example

``` r
g <- c("afd", 1, 3, 6)
print(g)
```

    ## [1] "afd" "1"   "3"   "6"

``` r
class(g)
```

    ## [1] "character"

In case of the vector `g`, it is not possible to convert the character "afd" to a numeric type, so the other elements are converted to a character data type

### 3.3 Assign names to vector elements using **names()** function

``` r
temp <- c(32,33,36,42,37,41,33)
names(temp) <- c("Mon", "Tue", "Wed", "Thurs", "Fri", "Sat", "Sun")
print(temp)
```

    ##   Mon   Tue   Wed Thurs   Fri   Sat   Sun 
    ##    32    33    36    42    37    41    33

To make the above code reusable, assign the vector of days to a variable `days`. This would spare a lot of time for productive more work.

``` r
days <- c("Mon", "Tue", "Wed", "Thurs", "Fri", "Sat", "Sun")
names(temp) <- days
print(temp)
```

    ##   Mon   Tue   Wed Thurs   Fri   Sat   Sun 
    ##    32    33    36    42    37    41    33

4. Vector Operations
====================

### 4.1 Elementwise operations.

``` r
v1 <- c(1,2,3)
v2 <- c(3,4,5)
```

### 4.2 Elementwise Addition

``` r
print(v1 + v2)
```

    ## [1] 4 6 8

### 4.3 Elementwise Subtraction

``` r
print(v1 - v2)
```

    ## [1] -2 -2 -2

### 4.4 Elementwise Division

``` r
print(v1 / v2)
```

    ## [1] 0.3333333 0.5000000 0.6000000

### 4.4 Elementwise Multiplication

``` r
print(v1 * v2)
```

    ## [1]  3  8 15

### 4.5 Vector built-in functions

``` r
sum(v1)              # Returns Sum
```

    ## [1] 6

``` r
mean(v2)             # Returns Mean
```

    ## [1] 4

``` r
sd(v1)               # Returns Standard Deviation
```

    ## [1] 1

``` r
max(v2)              # Returns Maximum
```

    ## [1] 5

``` r
min(v1)              # Returns Minimum
```

    ## [1] 1

``` r
prod(v2)             # Returns Product
```

    ## [1] 60

``` r
length(v1)           # Returns Length
```

    ## [1] 3

5. Indexing vector and slicing
==============================

``` r
v1 <- c(1,2,3,4,6)
v2 <- c('a','b','c','d','e')
```

Indexing in R starts at `1`, unlike other programming languages, where it starts at `0`

### 5.1 Index a single element

``` r
v1[1]
```

    ## [1] 1

### 5.2 To grab the first and second element

``` r
v1[c(1,2)]
```

    ## [1] 1 2

``` r
v1[1:2]
```

    ## [1] 1 2

### 5.3 To get elements in continuous sequence

``` r
v1[3:5]
```

    ## [1] 3 4 6

### 5.4 Indexing using names

``` r
v <- c(1,2,3,4)
names(v) <- c('w', 'x', 'y', 'z')

v[2]
```

    ## x 
    ## 2

``` r
v['x']
```

    ## x 
    ## 2

``` r
v[c('x','y','z')]
```

    ## x y z 
    ## 2 3 4

### 5.5 Indexing or filtering by comparison or using logical statements

#### 5.5.1 Index all elements greater than 2

``` r
print(v[v>2])
```

    ## y z 
    ## 3 4

``` r
print(v>2)
```

    ##     w     x     y     z 
    ## FALSE FALSE  TRUE  TRUE

Notice the difference b/w the above two statements

#### 5.5.2 Comparison operators - Evaluates True/False

``` r
3 > 4
```

    ## [1] FALSE

``` r
2 < 9
```

    ## [1] TRUE

``` r
5 >= 5
```

    ## [1] TRUE

``` r
2 <= 4
```

    ## [1] TRUE

``` r
2 == 6
```

    ## [1] FALSE

``` r
2 !=2
```

    ## [1] FALSE

**Note:** that `'='` is an assignment operator and **CANNOT** be used for comparison So, using `'='` for comparison will throw an error.

6. Matrix
=========

A matrix is a 2-dimensional data structure which consists of elements of the same data type

### 6.1 Create Matrix with `matrix()` function

``` r
vec <- 1:10
matrix(vec)
```

    ##       [,1]
    ##  [1,]    1
    ##  [2,]    2
    ##  [3,]    3
    ##  [4,]    4
    ##  [5,]    5
    ##  [6,]    6
    ##  [7,]    7
    ##  [8,]    8
    ##  [9,]    9
    ## [10,]   10

This will create a matrix of 10 rows and 1 column, which is the default setting.

### 6.2 To specify the number of rows or columns, use the `nrow()` or `ncol()` argument respectively.

``` r
matrix(vec, nrow = 2)
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    3    5    7    9
    ## [2,]    2    4    6    8   10

The default for filling the elements in a matrix is by columns. To change it to rows, set the `byrow` argument to `TRUE`

``` r
matrix(1:12, byrow = T, nrow = 4)
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    2    3
    ## [2,]    4    5    6
    ## [3,]    7    8    9
    ## [4,]   10   11   12

``` r
matrix(1:12, byrow = F, nrow = 4)
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    5    9
    ## [2,]    2    6   10
    ## [3,]    3    7   11
    ## [4,]    4    8   12

**Notice:** the difference. In the first matrix the elements are filled by rows since we set the `byrow` argument to `TRUE`. In the second matrix, the elements are filled by columns.

Let's do an example of creating a matrix, for the prices of apples and oranges for weekdays. We start with creating 2 vectors `apples and oranges` and the elements of each vector, would be their prices for that respective weekdays.

``` r
apples <- c(12, 11, 10, 9, 14)
oranges <- c(6, 9, 7, 11, 8)
```

Using the combine function `c()`, will create a vector

``` r
prices <- c(apples, oranges)
prices
```

    ##  [1] 12 11 10  9 14  6  9  7 11  8

In order to create a matix, we perform the following operations.

``` r
prices.matrix <- matrix(prices, byrow = T, nrow = 2)
print(prices.matrix)
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]   12   11   10    9   14
    ## [2,]    6    9    7   11    8

Now, we can use the `colnames()` and `rownames()` function to give names to the columns and rows respectively.

``` r
days <- c("Mon", "Tue", "Wed", "Thur", "Fri")
fruits <- c("Apples", "Oranges")

colnames(prices.matrix) <- days
rownames(prices.matrix) <- fruits

print(prices.matrix)
```

    ##         Mon Tue Wed Thur Fri
    ## Apples   12  11  10    9  14
    ## Oranges   6   9   7   11   8

7. Matrix Arithmetic
====================

We first create a matrix, `mat`.

``` r
mat <- matrix(1:25, byrow = T, nrow = 5)
```

### 7.1 Matrix operations \[ELEMENTWISE\]

#### 7.1.1 Multiply all the elements by 2

``` r
mat*2
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    2    4    6    8   10
    ## [2,]   12   14   16   18   20
    ## [3,]   22   24   26   28   30
    ## [4,]   32   34   36   38   40
    ## [5,]   42   44   46   48   50

#### 7.1.2 Divide all elements by 2

``` r
mat/2
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]  0.5  1.0  1.5  2.0  2.5
    ## [2,]  3.0  3.5  4.0  4.5  5.0
    ## [3,]  5.5  6.0  6.5  7.0  7.5
    ## [4,]  8.0  8.5  9.0  9.5 10.0
    ## [5,] 10.5 11.0 11.5 12.0 12.5

#### 7.1.3 Power - Square all elements in the matrix

``` r
mat^2
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    4    9   16   25
    ## [2,]   36   49   64   81  100
    ## [3,]  121  144  169  196  225
    ## [4,]  256  289  324  361  400
    ## [5,]  441  484  529  576  625

#### 7.1.4 Using the comparison operator will return a matrix of logical values.

``` r
mat > 14
```

    ##       [,1]  [,2]  [,3]  [,4]  [,5]
    ## [1,] FALSE FALSE FALSE FALSE FALSE
    ## [2,] FALSE FALSE FALSE FALSE FALSE
    ## [3,] FALSE FALSE FALSE FALSE  TRUE
    ## [4,]  TRUE  TRUE  TRUE  TRUE  TRUE
    ## [5,]  TRUE  TRUE  TRUE  TRUE  TRUE

#### 7.1.5 For filtering

``` r
mat[mat > 15]
```

    ##  [1] 16 21 17 22 18 23 19 24 20 25

This will return a vector of all the elements &gt; 15 in the matrix `mat`

#### 7.1.6 Matrix summation \[ELEMENTWISE\]

``` r
mat + mat
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    2    4    6    8   10
    ## [2,]   12   14   16   18   20
    ## [3,]   22   24   26   28   30
    ## [4,]   32   34   36   38   40
    ## [5,]   42   44   46   48   50

You can perform other operations like multiplication, subtraction, division.

#### 7.1.7 Matrix multiplication

``` r
mat %*% mat
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]  215  230  245  260  275
    ## [2,]  490  530  570  610  650
    ## [3,]  765  830  895  960 1025
    ## [4,] 1040 1130 1220 1310 1400
    ## [5,] 1315 1430 1545 1660 1775

**This is not an element by element multiplication.**

### 7.2 Matrix operations \[MATRIX FUNCTIONS\]

#### 7.2.1 Sums

``` r
colSums(prices.matrix)
```

    ##  Mon  Tue  Wed Thur  Fri 
    ##   18   20   17   20   22

``` r
rowSums(prices.matrix)
```

    ##  Apples Oranges 
    ##      56      41

#### 7.2.2 Means

``` r
rowMeans(prices.matrix)
```

    ##  Apples Oranges 
    ##    11.2     8.2

``` r
colMeans(prices.matrix)
```

    ##  Mon  Tue  Wed Thur  Fri 
    ##  9.0 10.0  8.5 10.0 11.0

#### 7.2.3 `cbind()` and `rbind()` function to add columns and rows to an existing matrix

Let's use the fruit price example to see the application

``` r
Grapes <- c(13, 14, 11, 10, 10)
fruit.prices <- rbind(prices.matrix, Grapes)
print(fruit.prices)
```

    ##         Mon Tue Wed Thur Fri
    ## Apples   12  11  10    9  14
    ## Oranges   6   9   7   11   8
    ## Grapes   13  14  11   10  10

We can add a row that shows the weekly average price of the fruits

``` r
avg <- rowMeans(fruit.prices)
prices.matrix <- cbind(fruit.prices, avg)
prices.matrix
```

    ##         Mon Tue Wed Thur Fri  avg
    ## Apples   12  11  10    9  14 11.2
    ## Oranges   6   9   7   11   8  8.2
    ## Grapes   13  14  11   10  10 11.6

8. Matrix Indexing
==================

We start by creating a new matrix `mat`.

``` r
mat <- matrix(1:20, byrow = T, nrow = 5)
mat
```

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    2    3    4
    ## [2,]    5    6    7    8
    ## [3,]    9   10   11   12
    ## [4,]   13   14   15   16
    ## [5,]   17   18   19   20

### 8.1 Index first row and all columns. Returns a vector

``` r
mat[1,]
```

    ## [1] 1 2 3 4

### 8.2 Just the Second column

``` r
mat[,2]
```

    ## [1]  2  6 10 14 18

### 8.3 First two rows and all columns

``` r
mat[1:2,]
```

    ##      [,1] [,2] [,3] [,4]
    ## [1,]    1    2    3    4
    ## [2,]    5    6    7    8

### 8.4 Last 2 rows and first 2 columns

``` r
mat[4:5,1:2]
```

    ##      [,1] [,2]
    ## [1,]   13   14
    ## [2,]   17   18

9. Data Frames
==============

Data frames enable us to organize and mix data types to create powerful data structures, unlike vectors and matrices where all the elements should be of the same data type. Data frames can be thought of as an Excel spreadsheet.

### 9.1 Few build-in data frames in R

``` r
state.x77
```

    ##                Population Income Illiteracy Life Exp Murder HS Grad Frost
    ## Alabama              3615   3624        2.1    69.05   15.1    41.3    20
    ## Alaska                365   6315        1.5    69.31   11.3    66.7   152
    ## Arizona              2212   4530        1.8    70.55    7.8    58.1    15
    ## Arkansas             2110   3378        1.9    70.66   10.1    39.9    65
    ## California          21198   5114        1.1    71.71   10.3    62.6    20
    ## Colorado             2541   4884        0.7    72.06    6.8    63.9   166
    ## Connecticut          3100   5348        1.1    72.48    3.1    56.0   139
    ## Delaware              579   4809        0.9    70.06    6.2    54.6   103
    ## Florida              8277   4815        1.3    70.66   10.7    52.6    11
    ## Georgia              4931   4091        2.0    68.54   13.9    40.6    60
    ## Hawaii                868   4963        1.9    73.60    6.2    61.9     0
    ## Idaho                 813   4119        0.6    71.87    5.3    59.5   126
    ## Illinois            11197   5107        0.9    70.14   10.3    52.6   127
    ## Indiana              5313   4458        0.7    70.88    7.1    52.9   122
    ## Iowa                 2861   4628        0.5    72.56    2.3    59.0   140
    ## Kansas               2280   4669        0.6    72.58    4.5    59.9   114
    ## Kentucky             3387   3712        1.6    70.10   10.6    38.5    95
    ## Louisiana            3806   3545        2.8    68.76   13.2    42.2    12
    ## Maine                1058   3694        0.7    70.39    2.7    54.7   161
    ## Maryland             4122   5299        0.9    70.22    8.5    52.3   101
    ## Massachusetts        5814   4755        1.1    71.83    3.3    58.5   103
    ## Michigan             9111   4751        0.9    70.63   11.1    52.8   125
    ## Minnesota            3921   4675        0.6    72.96    2.3    57.6   160
    ## Mississippi          2341   3098        2.4    68.09   12.5    41.0    50
    ## Missouri             4767   4254        0.8    70.69    9.3    48.8   108
    ## Montana               746   4347        0.6    70.56    5.0    59.2   155
    ## Nebraska             1544   4508        0.6    72.60    2.9    59.3   139
    ## Nevada                590   5149        0.5    69.03   11.5    65.2   188
    ## New Hampshire         812   4281        0.7    71.23    3.3    57.6   174
    ## New Jersey           7333   5237        1.1    70.93    5.2    52.5   115
    ## New Mexico           1144   3601        2.2    70.32    9.7    55.2   120
    ## New York            18076   4903        1.4    70.55   10.9    52.7    82
    ## North Carolina       5441   3875        1.8    69.21   11.1    38.5    80
    ## North Dakota          637   5087        0.8    72.78    1.4    50.3   186
    ## Ohio                10735   4561        0.8    70.82    7.4    53.2   124
    ## Oklahoma             2715   3983        1.1    71.42    6.4    51.6    82
    ## Oregon               2284   4660        0.6    72.13    4.2    60.0    44
    ## Pennsylvania        11860   4449        1.0    70.43    6.1    50.2   126
    ## Rhode Island          931   4558        1.3    71.90    2.4    46.4   127
    ## South Carolina       2816   3635        2.3    67.96   11.6    37.8    65
    ## South Dakota          681   4167        0.5    72.08    1.7    53.3   172
    ## Tennessee            4173   3821        1.7    70.11   11.0    41.8    70
    ## Texas               12237   4188        2.2    70.90   12.2    47.4    35
    ## Utah                 1203   4022        0.6    72.90    4.5    67.3   137
    ## Vermont               472   3907        0.6    71.64    5.5    57.1   168
    ## Virginia             4981   4701        1.4    70.08    9.5    47.8    85
    ## Washington           3559   4864        0.6    71.72    4.3    63.5    32
    ## West Virginia        1799   3617        1.4    69.48    6.7    41.6   100
    ## Wisconsin            4589   4468        0.7    72.48    3.0    54.5   149
    ## Wyoming               376   4566        0.6    70.29    6.9    62.9   173
    ##                  Area
    ## Alabama         50708
    ## Alaska         566432
    ## Arizona        113417
    ## Arkansas        51945
    ## California     156361
    ## Colorado       103766
    ## Connecticut      4862
    ## Delaware         1982
    ## Florida         54090
    ## Georgia         58073
    ## Hawaii           6425
    ## Idaho           82677
    ## Illinois        55748
    ## Indiana         36097
    ## Iowa            55941
    ## Kansas          81787
    ## Kentucky        39650
    ## Louisiana       44930
    ## Maine           30920
    ## Maryland         9891
    ## Massachusetts    7826
    ## Michigan        56817
    ## Minnesota       79289
    ## Mississippi     47296
    ## Missouri        68995
    ## Montana        145587
    ## Nebraska        76483
    ## Nevada         109889
    ## New Hampshire    9027
    ## New Jersey       7521
    ## New Mexico     121412
    ## New York        47831
    ## North Carolina  48798
    ## North Dakota    69273
    ## Ohio            40975
    ## Oklahoma        68782
    ## Oregon          96184
    ## Pennsylvania    44966
    ## Rhode Island     1049
    ## South Carolina  30225
    ## South Dakota    75955
    ## Tennessee       41328
    ## Texas          262134
    ## Utah            82096
    ## Vermont          9267
    ## Virginia        39780
    ## Washington      66570
    ## West Virginia   24070
    ## Wisconsin       54464
    ## Wyoming         97203

``` r
USPersonalExpenditure
```

    ##                       1940   1945  1950 1955  1960
    ## Food and Tobacco    22.200 44.500 59.60 73.2 86.80
    ## Household Operation 10.500 15.500 29.00 36.5 46.20
    ## Medical and Health   3.530  5.760  9.71 14.0 21.10
    ## Personal Care        1.040  1.980  2.45  3.4  5.40
    ## Private Education    0.341  0.974  1.80  2.6  3.64

``` r
women
```

    ##    height weight
    ## 1      58    115
    ## 2      59    117
    ## 3      60    120
    ## 4      61    123
    ## 5      62    126
    ## 6      63    129
    ## 7      64    132
    ## 8      65    135
    ## 9      66    139
    ## 10     67    142
    ## 11     68    146
    ## 12     69    150
    ## 13     70    154
    ## 14     71    159
    ## 15     72    164

To see all the built-in data sets use

``` r
data()
```

### 9.2 Data frame functions

#### 9.2.1 Top 5 rows

``` r
head(state.x77)
```

    ##            Population Income Illiteracy Life Exp Murder HS Grad Frost
    ## Alabama          3615   3624        2.1    69.05   15.1    41.3    20
    ## Alaska            365   6315        1.5    69.31   11.3    66.7   152
    ## Arizona          2212   4530        1.8    70.55    7.8    58.1    15
    ## Arkansas         2110   3378        1.9    70.66   10.1    39.9    65
    ## California      21198   5114        1.1    71.71   10.3    62.6    20
    ## Colorado         2541   4884        0.7    72.06    6.8    63.9   166
    ##              Area
    ## Alabama     50708
    ## Alaska     566432
    ## Arizona    113417
    ## Arkansas    51945
    ## California 156361
    ## Colorado   103766

#### 9.2.2 Bottom 5 rows

``` r
tail(state.x77)
```

    ##               Population Income Illiteracy Life Exp Murder HS Grad Frost
    ## Vermont              472   3907        0.6    71.64    5.5    57.1   168
    ## Virginia            4981   4701        1.4    70.08    9.5    47.8    85
    ## Washington          3559   4864        0.6    71.72    4.3    63.5    32
    ## West Virginia       1799   3617        1.4    69.48    6.7    41.6   100
    ## Wisconsin           4589   4468        0.7    72.48    3.0    54.5   149
    ## Wyoming              376   4566        0.6    70.29    6.9    62.9   173
    ##                Area
    ## Vermont        9267
    ## Virginia      39780
    ## Washington    66570
    ## West Virginia 24070
    ## Wisconsin     54464
    ## Wyoming       97203

#### 9.2.3 Structure of the data frame

``` r
str(state.x77)
```

    ##  num [1:50, 1:8] 3615 365 2212 2110 21198 ...
    ##  - attr(*, "dimnames")=List of 2
    ##   ..$ : chr [1:50] "Alabama" "Alaska" "Arizona" "Arkansas" ...
    ##   ..$ : chr [1:8] "Population" "Income" "Illiteracy" "Life Exp" ...

#### 9.2.4 Summary of Statistical Data

``` r
summary(state.x77)
```

    ##    Population        Income       Illiteracy       Life Exp    
    ##  Min.   :  365   Min.   :3098   Min.   :0.500   Min.   :67.96  
    ##  1st Qu.: 1080   1st Qu.:3993   1st Qu.:0.625   1st Qu.:70.12  
    ##  Median : 2838   Median :4519   Median :0.950   Median :70.67  
    ##  Mean   : 4246   Mean   :4436   Mean   :1.170   Mean   :70.88  
    ##  3rd Qu.: 4968   3rd Qu.:4814   3rd Qu.:1.575   3rd Qu.:71.89  
    ##  Max.   :21198   Max.   :6315   Max.   :2.800   Max.   :73.60  
    ##      Murder          HS Grad          Frost             Area       
    ##  Min.   : 1.400   Min.   :37.80   Min.   :  0.00   Min.   :  1049  
    ##  1st Qu.: 4.350   1st Qu.:48.05   1st Qu.: 66.25   1st Qu.: 36985  
    ##  Median : 6.850   Median :53.25   Median :114.50   Median : 54277  
    ##  Mean   : 7.378   Mean   :53.11   Mean   :104.46   Mean   : 70736  
    ##  3rd Qu.:10.675   3rd Qu.:59.15   3rd Qu.:139.75   3rd Qu.: 81163  
    ##  Max.   :15.100   Max.   :67.30   Max.   :188.00   Max.   :566432

### 9.3 Create Data frames - Use the data.frame()

``` r
days <- c('M','T','W','Th','F')
temp <- c(5,3,6,3,7)
rain <- c(T,F,F,T,F)

df <- data.frame(Days=days, Temperature=temp, Rain=rain)
df
```

    ##   Days Temperature  Rain
    ## 1    M           5  TRUE
    ## 2    T           3 FALSE
    ## 3    W           6 FALSE
    ## 4   Th           3  TRUE
    ## 5    F           7 FALSE

**OR** You can directly use the names of the vectors and they would be used as column names by default.

``` r
df <- data.frame(days, temp, rain)
df
```

    ##   days temp  rain
    ## 1    M    5  TRUE
    ## 2    T    3 FALSE
    ## 3    W    6 FALSE
    ## 4   Th    3  TRUE
    ## 5    F    7 FALSE

The structure and summary of the data frame `df` is.

``` r
str(df)
```

    ## 'data.frame':    5 obs. of  3 variables:
    ##  $ days: Factor w/ 5 levels "F","M","T","Th",..: 2 3 5 4 1
    ##  $ temp: num  5 3 6 3 7
    ##  $ rain: logi  TRUE FALSE FALSE TRUE FALSE

``` r
summary(df)
```

    ##  days        temp        rain        
    ##  F :1   Min.   :3.0   Mode :logical  
    ##  M :1   1st Qu.:3.0   FALSE:3        
    ##  T :1   Median :5.0   TRUE :2        
    ##  Th:1   Mean   :4.8                  
    ##  W :1   3rd Qu.:6.0                  
    ##         Max.   :7.0

This is important during exploratory data analysis.

### 9.4 Indexing and Sorting data frames

#### 9.4.1 Index the first row of `df`

``` r
df[1,]
```

    ##   days temp rain
    ## 1    M    5 TRUE

#### 9.4.2 Index the first column of `df`

``` r
df[,1]
```

    ## [1] M  T  W  Th F 
    ## Levels: F M T Th W

**OR**

``` r
df$days         #This method returns a vector
```

    ## [1] M  T  W  Th F 
    ## Levels: F M T Th W

**OR**

``` r
df['days']      #This method returns a data frame
```

    ##   days
    ## 1    M
    ## 2    T
    ## 3    W
    ## 4   Th
    ## 5    F

Instead of putting the index of the columns, we can use the names of the columns

``` r
df[1:3, c('days','temp')]
```

    ##   days temp
    ## 1    M    5
    ## 2    T    3
    ## 3    W    6

#### 9.4.3 `subset()` function for doing a conditional subset

Subset all rows where `rain == TRUE`

``` r
subset(df, subset = rain == T)
```

    ##   days temp rain
    ## 1    M    5 TRUE
    ## 4   Th    3 TRUE

Subset all rows where `temp <= 22`

``` r
subset(df, subset = temp <= 22)
```

    ##   days temp  rain
    ## 1    M    5  TRUE
    ## 2    T    3 FALSE
    ## 3    W    6 FALSE
    ## 4   Th    3  TRUE
    ## 5    F    7 FALSE

The outputs are in data frame format.

#### 9.4.4 `order()` function

``` r
sorted.temp <- order(df['temp'])
sorted.temp
```

    ## [1] 2 4 1 3 5

This will output a vector of sorted temperature indexes. The default is ascending. We can use these indexes to sort the data frame.

``` r
df[sorted.temp,]
```

    ##   days temp  rain
    ## 2    T    3 FALSE
    ## 4   Th    3  TRUE
    ## 1    M    5  TRUE
    ## 3    W    6 FALSE
    ## 5    F    7 FALSE

To sort in descending order

``` r
desc.temp <- order(-df['temp'])
df[desc.temp,]
```

    ##   days temp  rain
    ## 5    F    7 FALSE
    ## 3    W    6 FALSE
    ## 1    M    5  TRUE
    ## 2    T    3 FALSE
    ## 4   Th    3  TRUE

**OR**

``` r
desc.temp <- order(-df$temp)
df[desc.temp,]
```

    ##   days temp  rain
    ## 5    F    7 FALSE
    ## 3    W    6 FALSE
    ## 1    M    5  TRUE
    ## 2    T    3 FALSE
    ## 4   Th    3  TRUE

To find the number of rows and number of columns use `nrow()` and `ncol()`

``` r
nrow(df)
```

    ## [1] 5

``` r
ncol(df)
```

    ## [1] 3

To get the rownames and column names use `rownames()` and `colnames()` function

``` r
colnames(df)
```

    ## [1] "days" "temp" "rain"

``` r
rownames(df)
```

    ## [1] "1" "2" "3" "4" "5"

### 9.5 Assigning cells a value

``` r
df[[1,'temp']] <- 48
df
```

    ##   days temp  rain
    ## 1    M   48  TRUE
    ## 2    T    3 FALSE
    ## 3    W    6 FALSE
    ## 4   Th    3  TRUE
    ## 5    F    7 FALSE

### 9.6 Referencing \[Cells, Columns, Rows\]

#### 9.6.1 Reference a cell in data frame using `[[]]`

``` r
df[[1,2]]
```

    ## [1] 48

**OR**

``` r
df[[1,'temp']]
```

    ## [1] 48

#### 9.6.2 Reference a row

``` r
df[3,]
```

    ##   days temp  rain
    ## 3    W    6 FALSE

#### 9.6.3 Reference a column

Let's start with assigning mtcars dataset to a variable `df`

``` r
df <- mtcars
```

To get the output in a vector format, there are 4 methods

**Method 1**

``` r
df$mpg
```

    ##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2
    ## [15] 10.4 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4
    ## [29] 15.8 19.7 15.0 21.4

**Method 2**

``` r
df[,'mpg']
```

    ##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2
    ## [15] 10.4 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4
    ## [29] 15.8 19.7 15.0 21.4

**Method 3**

``` r
df[,1]
```

    ##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2
    ## [15] 10.4 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4
    ## [29] 15.8 19.7 15.0 21.4

**Method 4**

``` r
df[['mpg']]
```

    ##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2
    ## [15] 10.4 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4
    ## [29] 15.8 19.7 15.0 21.4

To get the output in a data frame format

``` r
df['mpg']
```

    ##                      mpg
    ## Mazda RX4           21.0
    ## Mazda RX4 Wag       21.0
    ## Datsun 710          22.8
    ## Hornet 4 Drive      21.4
    ## Hornet Sportabout   18.7
    ## Valiant             18.1
    ## Duster 360          14.3
    ## Merc 240D           24.4
    ## Merc 230            22.8
    ## Merc 280            19.2
    ## Merc 280C           17.8
    ## Merc 450SE          16.4
    ## Merc 450SL          17.3
    ## Merc 450SLC         15.2
    ## Cadillac Fleetwood  10.4
    ## Lincoln Continental 10.4
    ## Chrysler Imperial   14.7
    ## Fiat 128            32.4
    ## Honda Civic         30.4
    ## Toyota Corolla      33.9
    ## Toyota Corona       21.5
    ## Dodge Challenger    15.5
    ## AMC Javelin         15.2
    ## Camaro Z28          13.3
    ## Pontiac Firebird    19.2
    ## Fiat X1-9           27.3
    ## Porsche 914-2       26.0
    ## Lotus Europa        30.4
    ## Ford Pantera L      15.8
    ## Ferrari Dino        19.7
    ## Maserati Bora       15.0
    ## Volvo 142E          21.4

**OR**

``` r
df[1]
```

    ##                      mpg
    ## Mazda RX4           21.0
    ## Mazda RX4 Wag       21.0
    ## Datsun 710          22.8
    ## Hornet 4 Drive      21.4
    ## Hornet Sportabout   18.7
    ## Valiant             18.1
    ## Duster 360          14.3
    ## Merc 240D           24.4
    ## Merc 230            22.8
    ## Merc 280            19.2
    ## Merc 280C           17.8
    ## Merc 450SE          16.4
    ## Merc 450SL          17.3
    ## Merc 450SLC         15.2
    ## Cadillac Fleetwood  10.4
    ## Lincoln Continental 10.4
    ## Chrysler Imperial   14.7
    ## Fiat 128            32.4
    ## Honda Civic         30.4
    ## Toyota Corolla      33.9
    ## Toyota Corona       21.5
    ## Dodge Challenger    15.5
    ## AMC Javelin         15.2
    ## Camaro Z28          13.3
    ## Pontiac Firebird    19.2
    ## Fiat X1-9           27.3
    ## Porsche 914-2       26.0
    ## Lotus Europa        30.4
    ## Ford Pantera L      15.8
    ## Ferrari Dino        19.7
    ## Maserati Bora       15.0
    ## Volvo 142E          21.4

Return multiple columns

``` r
head(df[c('mpg', 'cyl')])
```

    ##                    mpg cyl
    ## Mazda RX4         21.0   6
    ## Mazda RX4 Wag     21.0   6
    ## Datsun 710        22.8   4
    ## Hornet 4 Drive    21.4   6
    ## Hornet Sportabout 18.7   8
    ## Valiant           18.1   6

To add rows and columns to an existing data frame use the rbind() and cbind() functions To add a new column you can use `df$colName <- 2*previous columns`

Rename columns using `colnames(df) <- c("a","b","c","d","e","f")`

To rename a specific columns `colnames(df)[1] <- "New_col"`

### 9.7 Filtering data

#### 9.7.1 Filtering rows as per condition

``` r
mtcars[mtcars$mpg > 20, ]
```

    ##                 mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4      21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag  21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710     22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
    ## Merc 240D      24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
    ## Merc 230       22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
    ## Fiat 128       32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
    ## Honda Civic    30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
    ## Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
    ## Toyota Corona  21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
    ## Fiat X1-9      27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
    ## Porsche 914-2  26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
    ## Lotus Europa   30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## Volvo 142E     21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2

#### 9.7.2 Filtering with multiple conditions

``` r
mtcars[(mtcars$mpg > 20) & (mtcars$cyl == 6),]
```

    ##                 mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4      21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag  21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1

#### 9.7.3 `subset()` function for filtering

``` r
subset(mtcars, mpg > 20 & cyl == 6)
```

    ##                 mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4      21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag  21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1

The subset function works well since you don't have to type `mtcars$name_of_column` everytime.

### 9.8 Dealing with NA's

``` r
is.na(mtcars)
```

    ##                       mpg   cyl  disp    hp  drat    wt  qsec    vs    am
    ## Mazda RX4           FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Mazda RX4 Wag       FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Datsun 710          FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Hornet 4 Drive      FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Hornet Sportabout   FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Valiant             FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Duster 360          FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Merc 240D           FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Merc 230            FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Merc 280            FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Merc 280C           FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Merc 450SE          FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Merc 450SL          FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Merc 450SLC         FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Cadillac Fleetwood  FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Lincoln Continental FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Chrysler Imperial   FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Fiat 128            FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Honda Civic         FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Toyota Corolla      FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Toyota Corona       FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Dodge Challenger    FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## AMC Javelin         FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Camaro Z28          FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Pontiac Firebird    FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Fiat X1-9           FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Porsche 914-2       FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Lotus Europa        FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Ford Pantera L      FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Ferrari Dino        FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Maserati Bora       FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ## Volvo 142E          FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
    ##                      gear  carb
    ## Mazda RX4           FALSE FALSE
    ## Mazda RX4 Wag       FALSE FALSE
    ## Datsun 710          FALSE FALSE
    ## Hornet 4 Drive      FALSE FALSE
    ## Hornet Sportabout   FALSE FALSE
    ## Valiant             FALSE FALSE
    ## Duster 360          FALSE FALSE
    ## Merc 240D           FALSE FALSE
    ## Merc 230            FALSE FALSE
    ## Merc 280            FALSE FALSE
    ## Merc 280C           FALSE FALSE
    ## Merc 450SE          FALSE FALSE
    ## Merc 450SL          FALSE FALSE
    ## Merc 450SLC         FALSE FALSE
    ## Cadillac Fleetwood  FALSE FALSE
    ## Lincoln Continental FALSE FALSE
    ## Chrysler Imperial   FALSE FALSE
    ## Fiat 128            FALSE FALSE
    ## Honda Civic         FALSE FALSE
    ## Toyota Corolla      FALSE FALSE
    ## Toyota Corona       FALSE FALSE
    ## Dodge Challenger    FALSE FALSE
    ## AMC Javelin         FALSE FALSE
    ## Camaro Z28          FALSE FALSE
    ## Pontiac Firebird    FALSE FALSE
    ## Fiat X1-9           FALSE FALSE
    ## Porsche 914-2       FALSE FALSE
    ## Lotus Europa        FALSE FALSE
    ## Ford Pantera L      FALSE FALSE
    ## Ferrari Dino        FALSE FALSE
    ## Maserati Bora       FALSE FALSE
    ## Volvo 142E          FALSE FALSE

The above function will return a data frame of logicals: TRUE if missing, FALSE O/W.

``` r
any(is.na(mtcars))
```

    ## [1] FALSE

This will return a single logical value, False if no data is missing and True if atleast one data cell has missing values.

#### 9.8.1 To replace missing values in your entire data set use

``` r
df[is.na(df)] <- 0
```

#### 9.8.2 To replace missing values in a specific column with the mean, you can do:

``` r
mtcars$mpg[is.na(mtcars$mpg)] <- mean(mtcars$mpg)
```
