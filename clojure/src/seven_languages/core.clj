(ns seven-languages.core)

; day1
(defn big? "returns true if st longer than n" [st n]
  (>= (count st) n))

(defn collection-type? [col]
  (if (list? col) :list
    (if (vector? col) :vector
      (if (map? col) :map)
    )
  )
)

;day2
(defmacro unless [test body else]
  (list 'if (list 'not test) body else))


(defprotocol Stack
  (spop [_])
  (push [_ o]))

(defrecord SimpleStack [vector] Stack
  (spop [_] (SimpleStack. (pop vector)))
  (push [_ o] (SimpleStack. (conj vector o)))
)

(defprotocol Queue
  (dequeue [_])
  (enqueue [_ o]))

(defrecord SimpleQueue [vector] Queue
  (dequeue [_] (SimpleQueue. (rest vector)))
  (enqueue [_ o] (SimpleQueue. (conj vector o)))
)

;day3

;http://blog.marrowboy.co.uk/2011/10/21/worker-queues-in-clojure/

(def account (ref 0))

(defn credit [a amount] (dosync (alter a + amount)) )
(defn withdraw [a amount] (dosync (alter a - amount)) )

;http://stackoverflow.com/questions/2760017/producer-consumer-with-qualifications

(def waiting_room (ref []))
(def waiting_room_size 3)
(def open? (atom true))


(def haircuts (atom 0))

(defn customers []
  (future
    (while @open?
;      (println "[Customer] Waiting Room:" @waiting_room)
      (dosync
        (if (< (count(ensure waiting_room)) waiting_room_size)
            (alter waiting_room conj :customer)
;            (println "[Customer] No available chair")
        )
      )
      (Thread/sleep (+ 10 (rand-int 21)))
    )
  )
)

(defn barber []
  (future
    (while @open?
      (dosync
        (when-not (empty?(ensure waiting_room))
;            (println "[Barber] Cutting hair")
            (alter waiting_room rest)
            (Thread/sleep 20)
            (swap! haircuts inc)
        )
      )
;      (Thread/sleep 10)
    )
  )
)

(defn go []
  (Thread/sleep 5000)
  (swap! open? not)
)

(defn sleeping_barber []
    (reset! open? true)
    (reset! haircuts 0)
    (customers)
    (barber)
    (go)
    (println "Happy Customers:" @haircuts)
)