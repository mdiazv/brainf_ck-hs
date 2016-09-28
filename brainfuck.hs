module Main where

import Control.Monad
import Data.Char

main = do
	[n, m] <- fmap (map read.words) getLine
	input <- getLine
	code <- replicateM m getLine
--	putStrLn $ show (compile code)
	putStrLn $ execute (compile code) (take n input)

data Expression =
	Increment | Decrement | Read | Write | MoveRight | MoveLeft | Loop [Expression]
	deriving (Show, Eq)

compile :: [String] -> [Expression]
compile code = fst $ compile' (concat code) []

compile' [] ast = (reverse ast, [])
compile' (c:cs) ast = case c of
	'+' -> compile' cs (Increment:ast) 
	'-' -> compile' cs (Decrement:ast) 
	',' -> compile' cs (Read:ast) 
	'.' -> compile' cs (Write:ast) 
	'>' -> compile' cs (MoveRight:ast) 
	'<' -> compile' cs (MoveLeft:ast) 
	'[' -> let (body, next) = compile' cs []
	       in compile' next (Loop (reverse body):ast)
	']' -> (ast, cs)
	_   -> compile' cs ast

execute :: [Expression] -> String -> String
execute ast input = let (output, _, _) = execute' ast input ([], 0, []) []
                    in output

execute' [] input mem output = (reverse output, input, mem)
execute' (c:cs) input mem output = case c of
	Increment -> execute' cs input (memIncrement mem) output
	Decrement -> execute' cs input (memDecrement mem) output
	Read      -> execute' cs (tail input) (memSet mem $ (ord . head) input) output
	Write     -> execute' cs input mem (memValue mem:output)
	MoveRight -> execute' cs input (memRight mem) output
	MoveLeft  -> execute' cs input (memLeft mem) output
	Loop []   -> (output, input, mem)
	Loop body -> if memRawValue mem == 0
				 then execute' cs input mem output
				 else let (loopOutput, loopInput, loopMem) = execute' body input mem output
					  in execute' (Loop body:cs) loopInput loopMem loopOutput

memIncrement (prev, x, next) = (prev, x+1, next)
memDecrement (prev, x, next) = (prev, x-1, next)
memSet (prev, _, next) x = (prev, x, next)
memValue (_, x, _) = chr x
memRawValue (_, x, _) = x
memRight(prev, x, []) = ((x:prev), 0, [])
memRight(prev, x, (n:ns)) = ((x:prev), n, ns)
memLeft([], x, next) = error "Cannot go to negative mem positions"
memLeft((p:ps), x, next) = (ps, p, (x:next))
