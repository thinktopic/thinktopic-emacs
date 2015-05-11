{:user
 {:plugins      [[lein-ancient "0.6.7"]
                 [jonase/eastwood "0.2.1"]
                 [cider/cider-nrepl "0.9.0-SNAPSHOT"]
                 [refactor-nrepl "1.1.0-SNAPSHOT"]
                 [quickie "0.3.10"]]
  :dependencies [[org.clojure/tools.nrepl "0.2.10"]]}
 
 :repl
 {:dependencies [[org.clojars.gjahad/debug-repl "0.3.3"]
                 [org.clojure/tools.namespace "0.2.10"]
                 [im.chit/vinyasa "0.2.0"]
                 [spyscope "0.1.5"]]
  :injections   [(load-file (.getAbsolutePath (clojure.java.io/file (System/getenv "HOME") ".lein/user.clj")))
                 (require 'vinyasa.inject)
                 (require 'spyscope.core)
                 (require 'alex-and-georges.debug-repl)
                 (vinyasa.inject/inject 'clojure.core '>
                                        '[[clojure.repl doc source pst]
                                          [clojure.pprint pprint pp]
                                          [alex-and-georges.debug-repl debug-repl]
                                          [clojure.tools.namespace.repl refresh refresh-all]
                                          [user run-test spy]
                                          ])]}}
