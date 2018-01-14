(define (find s predicate)
(cond
		((null? s) #f)
		((predicate (car s)) (car s))
		(else (find (cdr-stream s) predicate))
	)
)

(define (scale-stream s k)
  (cons-stream (* (car s) k) (scale-stream (cdr-stream s) k))
)

(define (has-cycle s)
  (define (check elem lst)
    (cond
      ((null? lst) #f)
      ((eq? elem (car lst)) #t)
      (else (check elem (cdr lst)))
    )
  )

  (define (memo lst prev)
    (cond
      ((null? lst) #f)
      ((check lst prev) #t)
      (else (memo (cdr-stream lst) (cons lst prev) ))
    )
  )

  (memo s nil)
)
(define (has-cycle-constant s)
  'YOUR-CODE-HERE
)
