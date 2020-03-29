
#lang racket
(require (planet dyoo/simply-scheme:1:2/simply-scheme) )

 (define (ball-val ball)
           (let ([W 1]
                 [R 10]
                 [G 15]
                 [B 20])
                (if (equal? ball 'R)
                    (display 10))
                (if (equal? ball 'W)
                    (display 1))
                (if (equal? ball 'G)
                    (display 15))
                (if (equal? ball 'B)
                    (display 20))))
        (ball-val 'G)

 (define (count-balls color bucket)
  (count (keep (lambda (c) (equal? color c)) bucket)))
  (count-balls 'W '(W R R R R G B B G W))

 (define (color-counts bucket)
  (let ([R (count-balls 'R bucket)]
        [W (count-balls 'W bucket)]
        [B (count-balls 'B bucket)]
        [G (count-balls 'G bucket)])
    (display (list R G W B))))

  (color-counts '(W R R R R G B B G W))

 (define (bucket-val bucket)
          (let ([R (count-balls 'R bucket)]
                [W (count-balls 'W bucket)]
                [G (count-balls 'G bucket)]
                [B (count-balls 'B bucket)])
            (let ([sum (+ (+ (* R 10) (* W 1)) (+ (* G 15) (* B 20)))])
              (display sum))))
  (bucket-val '(W R R R R G B B G W))

 (define (judge bucket_1 bucket_2)
          (let ([R1 (count-balls 'R bucket_1)]
                [W1 (count-balls 'W bucket_1)]
                [G1 (count-balls 'G bucket_1)]
                [B1 (count-balls 'B bucket_1)]
                [R2 (count-balls 'R bucket_2)]
                [W2 (count-balls 'W bucket_2)]
                [G2 (count-balls 'G bucket_2)]
                [B2 (count-balls 'B bucket_2)])
            (let ([sum1 (+ (+ (* R1 10) (* W1 1)) (+ (* G1 15) (* B1 20)))]
                  [sum2 (+ (+ (* R2 10) (* W2 1)) (+ (* G2 15) (* B2 20)))])
            (if (equal? sum1 sum2)
                (display "It\'s a Tie .. !"))
            (if (> sum1 sum2)
                (display "Bucket 1, Won .. !"))
            (if (< sum1 sum2)
                (display "Bucket 2, Won .. !")))))
    (judge '(R B G R G W B B R W) '(R B R G R W B B G W))
