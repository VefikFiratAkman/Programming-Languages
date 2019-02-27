

;; 151044031.lisp
;; Project 2 Parser in Lisp
;; DIRECTIVE: identify
;; Vefik Fırat Akman 151044031

;; Global variablelar 
(setq input '()) ;;inputlari almak icin
(setq kirkpuan '()) ;; kirkpuanlik identy icin liste
(setq ou '()) ;; inputlarin düzenlenmis outputu icin



(defun make-list-from-input (x process output) ;; lexer outputu olarak gelen input listesini parantezlerine gore nested bir listeye ceviriyor.
	;; '(("o" "(") ("o" "+") ("o" "(") ("o" "+") ("o" "(") ("o" "+") ("o" "a") ("o" "b") ("o" ")") ("o" "c") ("o" ")") ("o" "d") ("o" ")")) --->>> ornek input
	;; ((("o" "(") ("o" "+") (("o" "(") ("o" "+")  (("o" "(") ("o" "+") ("o" "a") ("o" "b") ("o" ")") ) ("o" "c") ("o" ")") ) ("o" "d") ("o" ")") )) --->>> ornek inputun outputu

	(if (equal (car input) nil) (Progn  (return-from make-list-from-input process) ) ) ;; recursion stop condition empty list
	
	(cond
			( 	(equal (nth 1 (car input)) ")")  ;; recursion stop condition listenin kapanması 
				(Progn (setq process (reverse process)) (push (car input) process ) (setq process (reverse process)) (setq input (cdr input)) (return-from make-list-from-input process))	) 

			( 	(equal (nth 1 (car input)) "(")	 ;; her parantez acma gelince yeni temp ile yeni liste olusturup bir alt recursiona yolluyor 
				(Progn (setq temp '()) (setq temp (reverse temp)) (push (car input) temp) (setq temp (reverse temp)) (setq input (cdr input)) 
					 (append (list(append temp (make-list-from-input input (cdr temp) process) ) )  (make-list-from-input input (cdr temp) process) ) ) ) 

			( 	(not(equal (nth 1 (car input)) "(")) ;; parantezler disinda gelenleri o an ki process listesine ekliyor
				(Progn (setq process (reverse process)) (push (car input) process ) (setq process (reverse process)) (setq input (cdr input)) (append process (make-list-from-input input (cdr process) output) )  ) 	)

	) 

;;calisma mantigi su sekilde:
;;o an ki process ve output basta bos. bir parantez acma geldiginde o an ki processi alt recursiona output olarak ve o an olusan tempi process olarak yolluyor
;;en alta ulastiginda o an ki temp ile outputu toplayarak donmeye basliyor. o sirada output ust recursionda ki temp oluyor.
;;en son tam olarak toplanmis ve bitmis oluyor

)

;;recursion bir sekilde calisan make-list-input fonksiyonunun ciktilarini tutabilmek adina kapsayici fonksiyon
(defun takeparser ()

	(setq x '()) ;; onemsiz bos variable
	(setq y '()) ;; onemsiz bos variable
	(setq z '()) ;; onemsiz bos variable

	(setq ou (make-list-from-input x y z )) ;; make-list-from-inputtan donenleri aliyor.

)



;; identy yapmak icin tum durumlarin toplandigi fonksiyon
;; durumlara göre gereken alt fonksiyonlari cagiriyor
;; identy islemi burada gerceklesiyor
(defun checker (liste) 


	(if (equal (car(cdr (car (car  ou)))) nil)  (return-from checker liste)  ) ;; recursion stop condition empty list

	(setq tempp '())

 	(if (equal "set" (car(cdr (car (car  ou)))) ) 
 		(if (checkset  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPI -> (set ID EXPI)"  tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.


 	(if (equal "+" (car(cdr (car (car  ou)))) ) 
 		(if (checkexpiforop  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPI -> (+ EXPI EXPI)" tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder. 

 	(if (equal "-" (car(cdr (car (car  ou)))) ) 
 		(if (checkexpiforop  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPI -> (- EXPI EXPI)"  tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.

 	(if (equal "/" (car(cdr (car (car  ou)))) ) 
 		(if (checkexpiforop  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPI -> (/ EXPI EXPI)"  tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.

 	(if (equal "*" (Car(cdr (car (car  ou)))) ) 
 		(if (checkexpiforop  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPI -> (* EXPI EXPI)"  tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.

 	(if (equal "and" (Car(cdr (car (car  ou)))) ) 
 		(if (checkexpb  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPB -> (and EXPB EXPB)"  tempp)) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.

 	(if (equal "or" (Car(cdr (car (car  ou)))) ) 
 		(if (checkexpb  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPB -> (or EXPB EXPB)"  tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.

	(if (equal "not" (Car(cdr (car (car  ou)))) ) 
 		(if (checkexpb  (car (car (cdr (car ou)))) (setq pp "") ) (push "EXPB -> (not EXPB)"  tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.

	(if (equal "equal " (Car(cdr (car (car  ou)))) ) 
 		(if (checkexpb  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPB ->  (equal EXPB EXPB)"  tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.

	(if (equal "equal " (Car(cdr (car (car  ou)))) ) 
 		(if (checkexpb  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPB -> (equal EXPI EXPI)"  tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.

	(if (equal "BinaryValue" (car (car (car  ou))) ) 
 		(if (checkexpb  (car (car (cdr (car ou)))) (setq pp "") ) (push "EXPB -> BinaryValue"  tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.

	(if (equal "identifier" (car (car (car  ou))) ) 
	 		(if (checkexpione  (car (car (cdr (car ou)))) ) (push "EXPI -> ID | (ID EXPLISTI) | VALUES"   tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.


 	(if (equal "deffun" (car(cdr (car (car  ou)))) ) 
 		(if (checkexpi  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPI -> (deffun ID IDLIST EXPLISTI)" tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.


	(if (equal "identifier" (car (car (car  ou))) ) 
	 		(if (checkexpione  (car (car (cdr (car ou)))) ) (push "(ID EXPLISTI)"   tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.

	(if (equal "defvar" (car(cdr (car (car  ou)))) ) 
 		(if (checkexpi  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPI -> (defvar ID EXPI)" tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.



 	(if (equal "if" (car(cdr (car (car  ou)))) ) 
 		(if (checkexpi  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPI -> (if EXPB EXPLISTI)" tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.


 	(if (equal "if" (car(cdr (car (car  ou)))) ) 
 		(if (checkexpitree  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) (cdr (cdr (car ou))) ) (push "EXPI -> (if EXPB EXPLISTI EXPLISTI)" tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.


	(if (equal "while" (car(cdr (car (car  ou)))) ) 
 		(if (checkexpi  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPI -> (while (EXPB) EXPLISTI)" tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.

	(if (equal "for" (car(cdr (car (car  ou)))) ) 
 		(if (checkexpi  (car (car (cdr (car ou)))) (cdr (cdr (car ou))) ) (push "EXPI -> (for (ID EXPI EXPI) EXPLISTI)" tempp) ) ) ;; inputun identy sorgusu yapiliyor.True ise bu durumda ki elemandır. Gecici listeye eklenir. False ise devam eder.



	(if (equal "(" (car(cdr (car (car  ou)))) )  (push "; DIRECTIVE: identify
START -> INPUT
INPUT -> EXPI | EXPLISTI"  liste) 
 ) ;; ilk eleman parantex acma olmasi gerekiyor. Bu sirada baslangic sartlari dosyaya yazdirilacak listeye ekleniyor.

	(setq ou (list (cdr (car ou)))) ;; liste recursion icin basinda ki eleman silinerek kücültülüp isleme devam ediliyor. Cunku stop condition inputun empty olmasiydi
	(append liste (checker tempp)) ;; recursion cagriliyor. donenler append ile toplaniyor.

)
;; Durumlara ozel identy icin check fonksiyonlari baslangici
(defun checkexpb (p1 p2)
	(if (and (checkexpin p1)  (checkexpin p2) ) ( return-from checkexpb t) (return-from checkexpb nil)) )
(defun checkset (id expi)
	(if (and (equal id "identifier") (checkexpiforop
	 expi)) ( return-from checkset t) (return-from checkset nil)))
(defun checkexpin (expb)
	(return-from checkexpin t))
(defun checkexpitree (exp1 exp2 exp3)
	(return-from checkexpitree t))
(defun checkexpiforop (expi expi2)
	(return-from checkexpiforop t))
(defun checkexpi (expi expi2)
	(return-from checkexpi t))
(defun checkexpione (expi)
	(return-from checkexpione t))
;; Durumlara ozel identy icin check fonksiyonlari sonu


(defun yazar (lst) ;; identyden gecmis identy tanimlari ile dolu kirkpuan listesini 151044031.tree ye basmak icin kullaniliyor
	;; Not dosya varsa append yapacagi icin ikinciye calistiginde aynı outputu dosyanin icine tekrar ekler.

	(setq file-name "151044031.tree") ;; filename odevde belirtilen formatta burada yazilmistir.

	(if (equal lst nil) ()) ;; recursion stop condition empty list


	(Setq e (car lst)) ;; listenin elemanlarini tek tek aliyor. Format keywordu ile eleman eleman dosyaya yazabilmek icin

	(if (not(equal lst nil))

		(Progn

			(with-open-file (str file-name
                     :direction :output
                     :if-exists :append ;;dosya varsa append yapiyor. Notta belirtmistim
                     :if-does-not-exist :create) ;; dosya yoksa olusturuyor.
   			(format str "~A~%" e)) ;;eleman eleman dosyaya yaziliyor
			(yazar (cdr lst)) ;; recursion cagrisi listenin ilk elemanini kirparak yapiliyorç

		)

	)
  
 )



(defun parser (param) ;; odevde istenilen fonksiyon. parser icin.
	
	(setq input param) ;; parametre olarak gelen inputu kodumda kullandığım input listesine aktarıyorum.
	(takeparser) ;; parser fonskiyonumun ilk asamasini otomatik olarak calistiyorum.
	(setq bos '()) ;; bos bir variable aciyorum call yapabilmek icin.
	(setq kirkpuan (checker bos)) ;; icinş identy elemanlarla doldurmak istedigim kirkpuan listemi checkerdan donenlerle set ediyorum.
	(yazar kirkpuan) ;; kirkpuan listemi eleman eleman istenildigi formatta 151044031.tree isminde ki dosyaya yazdiriyorum.
	kirkpuan ;; listem islem bitince ekranda da gorunsun diye burada listemi cagiriyorum.

)

;; Vefik Firat Akman 151044031
;; DIRECTIVE: identify
;; Project 2 Parser in Lisp
;; 151044031.lisp