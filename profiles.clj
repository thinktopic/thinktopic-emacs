o{:user
 {:plugins [[lein-ancient "0.5.5"]
            [jonase/eastwood "0.1.1"]
            [cider/cider-nrepl "0.7.0-SNAPSHOT"]]}
 :repl
 {:dependencies [[org.clojars.gjahad/debug-repl "0.3.3"]
                 [im.chit/vinyasa "0.1.8"]
                 [spyscope "0.1.4"]]
  :repl-options {:nrepl-middleware
                 [cider.nrepl.middleware.classpath/wrap-classpath
                  cider.nrepl.middleware.complete/wrap-complete
                  cider.nrepl.middleware.info/wrap-info
                  cider.nrepl.middleware.inspect/wrap-inspect
                  cider.nrepl.middleware.stacktrace/wrap-stacktrace]}
  :injections [(require 'vinyasa.inject)
               (require 'spyscope.core)
               (require 'alex-and-georges.debug-repl)
               (vinyasa.inject/inject 'clojure.core '>
                                      '[[clojure.repl doc source]
                                        [clojure.pprint pprint pp]
                                        [alex-and-georges.debug-repl debug-repl]])]}}
