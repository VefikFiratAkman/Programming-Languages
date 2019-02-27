(load "csv-parser.lisp")
(in-package :csv-parser)

;; (read-from-string STRING)
;; This function converts the input STRING to a lisp object.
;; In this code, I use this function to convert lists (in string format) from csv file to real lists.

;; (nth INDEX LIST)
;; This function allows us to access value at INDEX of LIST.
;; Example: (nth 0 '(a b c)) => a

;; !!! VERY VERY VERY IMPORTANT NOTE !!!
;; FOR EACH ARGUMENT IN CSV FILE
;; USE THE CODE (read-from-string (nth ARGUMENT-INDEX line))
;; Example: (mypart1-funct (read-from-string (nth 0 line)) (read-from-string (nth 1 line)))

;; DEFINE YOUR FUNCTION(S) HERE

(defun list-leveller (liste)
;;This function converts a list of nested lists into a single layer list.

	(if (null liste)
   		(return-from list-leveller liste)
   	) ;; Recursion break statement. Recursion will be break if only if this statement is true.

	(cond
		((atom (car liste)) (cons (car liste) (list-leveller (cdr liste))))
		(t (append (list-leveller (car liste)) (list-leveller (cdr liste)))) 
	);; İn this condition, Function can understand next element is nested list or item.
  ;; And it takes a different action for each situation.


)

;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part1.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%" 
      ;; CALL YOUR (MAIN) FUNCTION HERE
        (list-leveller (read-from-string (nth 0 line)))
      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)





