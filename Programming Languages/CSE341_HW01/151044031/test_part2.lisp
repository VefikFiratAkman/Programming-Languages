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
(defun merge-list ( list1 list2 )
;; this function performs the action of append function.
	(if (null list2)
   		(return-from merge-list list1)
   	) ;; Recursion break statement. Recursion will be break if only if this statement is true.

   
	(setq temp (reverse list1)) ;; Take reverse of main list and set to temp list
	(push (car list2) temp) ;; Push first element of second list to temp list's start place.
	(setq list1 ( reverse temp)) ;; reverse temp list again and set to main list. 
	(setq list2 (cdr list2)) ;; remove list2 first element


	( merge-list  list1 list2 )
)


;; MAIN FUNCTION
(defun main ()
  (with-open-file (stream #p"input_part2.csv")
    (loop :for line := (read-csv-line stream) :while line :collect
      (format t "~a~%" 
      ;; CALL YOUR (MAIN) FUNCTION HERE
        (merge-list (read-from-string (nth 0 line)) (read-from-string (nth 1 line)))
      )
    )
  )
)

;; CALL MAIN FUNCTION
(main)
