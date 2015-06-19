{:user
 {:plugins      [[lein-ancient "0.6.7"]
                 [jonase/eastwood "0.2.1"]
                 [cider/cider-nrepl "0.9.1-SNAPSHOT"]
                 [refactor-nrepl "1.1.0-SNAPSHOT"]
                 [quickie "0.3.10"]]
  :dependencies [[org.clojure/tools.nrepl "0.2.10"]]
  
  :repl-options
  {:init (do (load-file (.getAbsolutePath (clojure.java.io/file (System/getenv "HOME") ".lein/user.clj")))
             (user/inject-repl-utils))}}
 
 :repl
 {:dependencies [[org.clojars.gjahad/debug-repl "0.3.3"]
                 [org.clojure/tools.namespace "0.2.10"]
                 [im.chit/vinyasa "0.2.0"]
                 [spyscope "0.1.5"]]}}
