(define (fibonacci n)
  (fibonacci-core 0 1 n))

(define (fibonacci-core prev1 prev2 counter)
  (cond
   ((<= counter 0) prev1)
   (else (fibonacci-core prev2 (+ prev1 prev2) (- counter 1)))))

(define (display-sol a b)
  (write a)
  (display " ")
  (write b)
  (newline))

(define (main-fibonacci count)
  (cond
   ((= count 0) '())
   (else
    (let ((num (read)))
      (cond
       ((= num 0) (display-sol (fibonacci 1) (fibonacci 0)))
       (else (display-sol (fibonacci (- num 1))
                          (fibonacci (- num 0))))))
    (main-fibonacci (- count 1)))))

(define (main)
  (let ((test-case-count (read)))
    (main-fibonacci test-case-count)))

(main)
;;(write (fibonacci 0))
;;(write (fibonacci 1))
;;(write (fibonacci 3))
