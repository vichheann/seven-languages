(ns seven-languages.test.core
  (:use [seven-languages.core])
  (:use [clojure.test])
  (:import [seven_languages.core SimpleStack SimpleQueue]))

(deftest isbigger
  (is (= true (big? "" 0)) "empty string")
  (is (= true (big? "clojure is a functionnal language" 0)) "always true with 0")
  (is (= false (big? "clojure is a functionnal language" 50)) "main test"))

(deftest what-is-collection-type
  (is (= :list (collection-type? ())) ":list" )
  (is (= :vector (collection-type? [])) ":vector")
  (is (= :map (collection-type? {})) ":map"))

(deftest unless-else
  (is (thrown-with-msg? Exception #"Pass here"
                  (unless false (throw (Exception. "Pass here"))
                                (throw (Exception. "Wrong")))) "should pass"
  )
  (is (thrown-with-msg? Exception #"Pass here"
                  (unless true (throw (Exception. "Wrong"))
                                (throw (Exception. "Pass here")))) "should not pass"
  )
)

(deftest stack
  (def s (SimpleStack. [1,2,3,4]))
  (is (= [1,2,3] (:vector (spop s))))
  (is (= [1,2,3,4,5] (:vector (push s 5 ))))
)

(deftest queue
  (def q (SimpleQueue. [1,2,3,4]))
  (is (= [2,3,4] (:vector (dequeue q))))
  (is (= [1,2,3,4,5] (:vector (enqueue q 5 ))))
)

(deftest account_ref
  (credit account 200)
  (is (= 200 @account))
  (withdraw account 200)
  (is (= 0 @account))
)