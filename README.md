# brainf_ck-hs
A Haskell interpreter for the brainf_ck language

Inspired By: https://www.hackerrank.com/challenges/brainf-k-interpreter-fp

## Objective
Given a valid BrainF__k program and an input string, you have to print the result of the program when executed. All those characters of the program which does not represent a valid command can be considered as comment and should be ignored.

You have to print the output for first 105 operations. If program executes more than 105 operations then you have stop execution and print "PROCESS TIME OUT. KILLED!!!" (without quotes) in the next line.

## Input 
First line will contain two space separated integers, n m, which represent number of characters in input to BrainF__k program and number of lines in the program, respectively. Next line contains n+1 characters which represents the input for the BrainF__k program. This line ends with character '$' which represent the end of input. Please ignore this in input. Then follows m lines which is the BrainF__k program.

## Output 
You have to print the output of program as mentioned in Objective. For programs with more than 100000 operations, print the output till then followed by "PROCESS TIME OUT. KILLED!!!" in the next line.

## Constraints 
* 0 <= n <= 150 
* 1 <= m <= 150 
* Length of Brain__k program will not exceed 5000.

## Notes:

* Initally all memory locations contain 0. A location can store integer in range [0 .. 255].
* At the start of program, data pointer is at memory location 0. It is guaranteed that data pointer will never point to a negative memory index during the execution of program.
* Number of read operations will not exceed input string length.
* Program will not have a mis-matched bracket ([ or ]).

