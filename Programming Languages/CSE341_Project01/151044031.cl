(setq operator '("+" "-" "*" "/" "(" ")" "**")) ;;operator in G++
(setq  keywords '("and" "or" "not" "equal" "deffun" "set" "append" "concat" "for" "while" "if" )) ;;keywords in G++
(setq  binary '("true" "false" )) 
(setq integers '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")) ;;integer value in G++
(setq alpha '("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")) ;;latin alphabet for G++


(defun isoperator (param) ;; This function take character and check this character is in operator's list or not.
  
  (setq i 0)
  (setq resultOp '()) ;; empty list
  (loop
   
      (if (equal param (nth i operator)) ;; check parametre's chraracter and operator list element
      	(Progn
          (push param resultOp) ;; operator pushed in list
          (push "operator" resultOp) ;; "operator pushed in list"
           
          )
      	)

   
      (setq i (+ i 1))
      (when (> i (list-length operator)) (return resultOp)) ;; return list
    
  )
  
)


;; check for keywords
(defun iskeyword (param) ;;  This function take string and check this string is in keyword's list or not.
 
  (setq j 0)
  (setq resultKey '()) ;; empty list
  (loop 

   	(if (equal param (nth j keywords)) ;; check keyword's element and keyword list element
   		(Progn
          	(push param resultKey)  ;; keyword pushed in list
          	(push "keyword" resultKey) ;; keyword pushed in list
         
            )
      )

   		(setq j (+ j 1))
        
        (when (> j (list-length keywords)) (return resultKey))
  )
  
)
;; check for binary
(defun isbinary (param) ;;  This function take string and check this string is in binary's list or not.

  (setq j 0)
  (setq resultBinary '())
  (loop 

   	(if (equal param (nth j binary))
   		(Progn
          	(push param resultBinary) ;; binary pushed in list
          	(push "binary" resultBinary) ;; binary pushed in list
          
            )
      )

   		(setq j (+ j 1))
        
        (when (> j (list-length binary)) (return resultBinary))
  )
  
)


;; check for integers
	(defun isinteger (param) ;; This function take character and check this character is in integer's list or not.
		(setq paramToken (split param)) ;; tokenize for G++ Token for a letter
		(setq checkOther 0)
		(setq p 0)
		(setq resultOther '()) ;; empty list
		(loop 

			(setq r 0)
			(loop 
				
				(if (equal (nth p paramToken) (nth r integers))   ;; check integer's element and integer list element
					(setq checkOther (+ checkOther 1))
				)
				(setq r (+ r 1))
				
				(when (> r (list-length integers)) (return checkOther) )
			)
	
			(if (equal (- checkOther 1) (length paramToken)) ;; check integer's element and integer list element
					(Progn
			          	(push param resultOther)
			          	(push "integer" resultOther)
		            )
			)
			(setq p (+ p 1))
			(when (> p (list-length paramToken)) (return resultOther) )
		)

      )




(defun split (param) ;; This function take string list and parse to one character string list "Atatürk" -> "A" "t" "a" "t" "ü" "r" "k"

	(setq a 1)
	(setq tokens '())
	(loop 
		(setq x (subseq param (- a 1) a)) ;; take character by character in string
		(push x tokens)
	   
	   (setq a (+ a 1))
	   
	   (when (> a (length param)) (return (reverse tokens)))
	)

	)


;;check for Idendifier

	(defun isidendifier (param) ;; This function take character and check this character is in alpha's list or not.
		(setq paramToken (split param)) ;; tokenize for G++ Token for a letter
		(setq checkident 0)
		(setq k 0)
		(setq resultident '())
		(loop 

			(setq n 0)
			(loop 
				
				(if (equal (nth k paramToken) (nth n alpha)) ;; check idendifier's element and idendifier list element
					(setq checkident (+ checkident 1))
				)
				(setq n (+ n 1))
				
				(when (> n (list-length alpha)) (return checkident) )
			)
	
			(if (equal (- checkident 1) (length paramToken))  ;; check idendifier's element and idendifier list element
				(Progn
			          	(push param resultident)
			          	(push "idendifier" resultident)
		            )
			)
			(setq k (+ k 1))
			(when (> k (list-length paramToken)) (return resultident) )
		)

      )

 
(defun splitignorespace (param) ;; This function take string list and parse to one character string list " Mustafa   Kemal " -> "M" "u" "s" "t" "a" "f" "a" "K" "e" "m" "a" "l"

	(setq e 1)
	(setq q 0)
	(setq tokens '())
	(loop 
		(setq x (subseq param (- e 1) e)) ;; s
		(if (equal " " x) ;; ignore space 
			(Progn
				(setq x (subseq param q (- e 1))) ;; take character by character in string
				(setq q e)
				(if (not (equal x ""))
				(push x tokens)
				)
			)
		)
		(if (equal (length param) e)
			(Progn
				(setq x (subseq param q e)) 
				(setq q e)
				(if (not (equal x "")) ;; delete nil
				(push x tokens)
				)
			)
		)
	   
	   (setq e (+ e 1))
	   
	   (when (> e (length param)) (return (reverse tokens)))
	)

	)


	(defun stringer (strlist) ;; This function take string list and appen to one element string list with space "Mustafa" "Kemal" "Atatürk" -> "Mustafa Kemal Atatürk "
		(setq theStr "")
		(setq h 0)
		(loop 

			(setq theStr (concatenate 'string theStr (nth h strlist) " ") ) ;; append string to string
			(setq h (+ h 1))

			(when (> h (length strlist)) (return theStr))
		)

	)

	(defun file-get-contents (filename) ;; http://sodaware.sdf.org/notes/cl-read-file-into-string/ taken from here ;; get file line by line in string
		(with-open-file (stream filename)
		
		(loop for line = (read-line stream nil)
		
			while line
		
			collect line)
		)
		
		)


(defun replace-all (string part replacement &key (test #'char=)) ;; This function take string list, which will replace string and new data for replace  "Mustafa Ali Atatürk" "Ali" "Kemal" -> "Mustafa Kemal Atatürk "
																	;;http://cl-cookbook.sourceforge.net/strings.html taken from here

    (with-output-to-string (out)
      (loop with part-length = (length part)
            for old-pos = 0 then (+ pos part-length)
            for pos = (search part string
                              :start2 old-pos
                              :test test)
            do (write-string string out
                             :start old-pos
                             :end (or pos (length string)))
            when pos do (write-string replacement out)
            while pos))
    ) 



    (defun lexer(filename) ;; This is main function for lexer. Lexer collection of other function. And in lexer they will work together in specific algorithm. So this program could be lexer.


    	(setq resultLexer '()) ;; empty list
    	(setq gFile (stringer (file-get-contents filename))) ;; get code in file
    	(setq gFile (replace-all gFile ")" " ) ") ) ;; ))) --> )  )   )
    	(setq gFile (replace-all gFile "(" " ( ") ) ;; ((( --> (  (   (
    	(setq gFile (replace-all gFile "
" " ") ) ;, "\n" --> " "

      	(setq gList (splitignorespace gFile)) ;; tokenize for space
    
      ;; main loop for code in list-length
      (setq y 0)
      (loop 
        
        (setq gToken (nth y gList ))

		(if (equal gToken nil)
        	(setq gToken " ")
        )

  		 (if (not (equal (isoperator gToken) nil))
       (push   (isoperator gToken) resultLexer) ;; push operator in result list
       )
      
          (if (not(equal (iskeyword gToken)  nil)) ;;check for keywords
        	(push (iskeyword gToken) resultLexer ) ;; push keyword in result list
    		)


            (if (not(equal (isbinary gToken)  nil)) ;;check for binary
        	(push (isbinary gToken) resultLexer )  ;; push binary in result list
    		)

        (if (equal (iskeyword gToken) nil) ;;check for keywords if not is maybe binary
        	(Progn
        		
        		 (if (equal (isbinary gToken) nil) ;;check for binary if not is maybe idendifier
        			(Progn


        		 (if (not (equal (isidendifier gToken) nil)) ;;check for idendifier
			       (push    (isidendifier gToken) resultLexer) ;; push idendifier in result list
			     )

			     )
        			)
        	
        	 ) ;; check for Idendifiers
    	)

       
		 (if (not (equal (isinteger gToken) nil)) ;;check for integer
	       (push    (isinteger gToken) resultLexer)  ;; push integer in result list
	       )

    	
        

        (setq y (+ y 1))

        (when (> y (list-length gList)) (return (reverse resultLexer)))
    )	

    )
