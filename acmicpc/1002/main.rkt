(define (calc-distance x1 y1 x2 y2)
  (let ((dx (- x1 x2))
        (dy (- y1 y2)))
    (sqrt (+ (* dx dx) (* dy dy)))))

(define (calc-turret-intersection-count distance r1 r2)
  (let ((sum-radius (+ r1 r2))
        (max-radius (max r1 r2))
        (min-radius (min r1 r2)))
    (cond
     ((and (= distance 0) (= r1 r2)) -1)
     ((<= distance max-radius) (cond
                                ((< (+ distance min-radius) max-radius) 0)
                                ((= (+ distance min-radius) max-radius) 1)
                                ((> (+ distance min-radius) max-radius) 2)))
     (else (cond
            ((= sum-radius distance) 1)
            ((> sum-radius distance) 2)
            ((< sum-radius distance) 0))))))

(define (turret-run x1 y1 r1 x2 y2 r2)
  (let ((distance (calc-distance x1 y1 x2 y2)))
    (calc-turret-intersection-count distance r1 r2)))


(define (main-turret count)
  (cond
   ((= count 0) '())
   (else
    (let ((x1 (read))
          (y1 (read))
          (r1 (read))
          (x2 (read))
          (y2 (read))
          (r2 (read)))
      (write (turret-run x1 y1 r1 x2 y2 r2))
      (newline))
    (main-turret (- count 1)))))

(define (main)
  (let ((test-case-count (read)))
    (main-turret test-case-count)))

(main)
;;(turret-run 0 0 13 40 0 37)
;;(turret-run 0 0 3 0 7 4)
;;(turret-run 1 1 1 1 1 5)
