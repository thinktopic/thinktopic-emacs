(ns user
  (:require [clojure.pprint :as pprint]
            [clojure.test :as test]
            [vinyasa.inject]
            [spyscope.core]
            [alex-and-georges.debug-repl]))


(defmacro run-test
  "Runs the test, with the namespace fixtures."
  [test-fn]
  `(let [once-fixture-fn# (test/join-fixtures (:clojure.test/once-fixtures (meta ~*ns*)))
         each-fixture-fn# (test/join-fixtures (:clojure.test/each-fixtures (meta ~*ns*)))]
     (once-fixture-fn#
      #(each-fixture-fn# ~test-fn))))

(defn spy [m]
  (pprint/pprint m)
  m)

(defn inject-repl-utils []
  (vinyasa.inject/inject 'clojure.core '>
                         '[[clojure.repl doc source pst]
                           [clojure.pprint pprint pp]
                           [alex-and-georges.debug-repl debug-repl]
                           [clojure.tools.namespace.repl refresh refresh-all]
                           [user run-test spy]
                           ]))
