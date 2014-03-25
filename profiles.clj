{:user
 {:dependencies
  [[org.clojars.gjahad/debug-repl "0.3.3"]
   [im.chit/vinyasa "0.1.8"]
   [spyscope "0.1.4"]]
  :plugins [[lein-ancient "0.5.5"]
            [jonase/eastwood "0.1.1"]]
  :injections [(require 'vinyasa.inject)
               (require 'spyscope.core)
               (require 'alex-and-georges.debug-repl)
               (vinyasa.inject/inject 'clojure.core '>
                                      '[[clojure.repl doc source]
                                        [clojure.pprint pprint pp]
                                        [alex-and-georges.debug-repl debug-repl]])]}}
