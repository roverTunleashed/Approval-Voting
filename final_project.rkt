#lang racket
;;Count the vote for an individual candidate
;;currying used because filter requires 2 inputs, but map only requires one
;;filter out the empty lists then get the length of ballot 
(define (count v ballots)
  (cons v (length (filter ((curry check?) '()) (map ((curry filter) ((curry equal?) v)) ballots)))))  
;;Count the vote for all candidates
(define (countBallots candidates ballots)
  (cond [(empty? candidates) '()]
        [else (append (list (count (first candidates) ballots)) (countBallots (rest candidates) ballots))]))
;;Count empty ballots with "none"
(define (countEmptyBallots lst)
  (cond [(empty? lst) 0]
        [(equal? (first lst) "none") 
         (+ 1 (countEmptyBallots (rest lst)))]
        [else (countEmptyBallots (rest lst))]))
;;print the ballots with the format 'candidate: vote'
(define (printBallots lst)
  (cond [(empty? lst) (printf "\n")]
        [else (printf "~a: ~a\n" (car (first lst)) (cdr (first lst)))
              (printBallots (rest lst))]))

;;Determining if the ballot is full
(define (countFullBallots len lst)
  (cond [(empty? lst) 0]
        [(equal? len (length (first lst)))
         (+ 1 (countFullBallots len (rest lst)))] ;;if the length of the ballot is the same as the candidate, its full 
        [else (countFullBallots len (rest lst))]))
;;used to filter out everything that I don't need
(define (check? a b)
  (cond [(equal? a b) #f]
        [else #t]))

;;function to read in the file
(define (read-file file)
  (file->lines file))
;;Intro line
(printf "What is the name of the ballot file?\n")

(define file (read-line))
(define text (read-file file))

(printf "Total # of ballots: ~v" (length text))
(printf "\n")
;;map takes in 1 input, but filter needs 2 so I have to curry
;;using my check? function, I filter out everything that has a space, keeping only items that don't equal space
;;remove* '("none" removes none from the list of strings
;;map string-> list turns each string in the list of strings to a list, which matches the list of list in the first part of the function
(define ballots (map remove-duplicates (map ((curry filter) ((curry check?) #\space)) (map string->list (remove* '("none") text)))))
;;combine into 1 string and remove duplicates to get the candidate
(define candidates (remove-duplicates (flatten ballots)))
;;print the ballots and ensure they are in the right order 
(printBallots (sort (countBallots candidates ballots) (lambda (a b) (> (cdr a) (cdr b))))) ;;cdr returns the second element

(printf "Empty: ") (countEmptyBallots text)
(printf "Full: " ) (countFullBallots (length candidates) ballots)

