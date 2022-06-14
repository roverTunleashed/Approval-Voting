--final_report.hs

import Data.List

--Final Project implementation from Nov 19th lecture using elements of top-down and bottom-up thinking

--Recursive remove duplicates function
removeDups :: Eq a => [a] -> [a]
removeDups []     = []
removeDups (x:xs) = if x `elem` xs --if x is present in the list 
                    then removeDups xs
                    else x : removeDups xs
--Count function
count :: Eq a => a -> [a] -> Int
count v xs = length (filter (==v) xs)

countFullBallots :: [String] -> Int -> Int 
countFullBallots xs v | length xs == 0 = 0
                      | length (head xs) == v = (countFullBallots (drop 1 xs) v) + 1
                      | otherwise = countFullBallots (drop 1 xs) v

removeSpace :: String -> String
removeSpace []     = []
removeSpace (x:xs) = if x == ' '
                     then removeSpace xs
                     else x : removeSpace xs

removeNone:: [String] -> [String]
removeNone[]     = []
removeNone(x:xs) = if x == "none"
                   then "" : removeNone xs
                   else x : removeNone xs 
--Printing candidates
printCandidates [] = return ()
printCandidates (x:xs) = do
                         putStrLn ([fst x] ++ ": " ++ show (snd x))
                         printCandidates xs

--Approval voting
approvalCount :: [String] -> [(Char, Int)]
approvalCount ballots = map (\(x,y) -> (y,x)) results
                        where 
                           allVotes   = concat (map removeDups ballots)
                           candidates = removeDups allVotes
                           rawCounts  = [(count c allVotes, c) | c<-candidates]
                           results    = reverse (sort rawCounts)

--Source for lines: http://zvon.org/other/haskell/Outputprelude/lines_f.html 
main = do
    putStrLn "What is the name of the ballot file?"
    --Read file
    fileName <- getLine
    input <- readFile fileName

    let empty = count "none" $ lines input
    --need to remove duplicates, "nones" and spaces
    let ballots = map removeSpace $ removeDups $ removeNone $ lines input
    --combine into one string and remove duplicates to get candidates 
    let candidates = removeDups(concat (map removeDups ballots))
    --if the length of a ballot is the same as the length of candidates, it must be ful
    let full = countFullBallots ballots (length candidates) 

    putStrLn ("\n" ++ "Total # of ballots: " ++ show (length ballots) ++ "\n")
    printCandidates (approvalCount ballots)

    putStrLn ("\n" ++ "empty: "  ++ show empty) 
    putStrLn ("full: " ++ show full)
