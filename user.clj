(ns user
  (:require [clojure.test :as test]))

(defmacro run-test
  "Runs the test, with the namespace fixtures."
  [test-fn]
  `(let [once-fixture-fn# (test/join-fixtures (:clojure.test/once-fixtures (meta ~*ns*)))
         each-fixture-fn# (test/join-fixtures (:clojure.test/each-fixtures (meta ~*ns*)))]
     (once-fixture-fn#
      #(each-fixture-fn# ~test-fn))))
