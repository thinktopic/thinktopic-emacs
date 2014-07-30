JAVA6_HOME=/usr/lib/jvm/jdk1.6.0_45
export JAVA6_HOME
JAVA8_HOME=/usr/lib/jvm/jdk1.8
export JAVA8_HOME

SOLR_JAVA_HOME=$JAVA6_HOME
export SOLR_JAVA_HOME
ANALYTICS_JAVA_HOME=$JAVA6_HOME
export ANALYTICS_JAVA_HOME

ALM_JAVA_HOME=$JAVA8_HOME
export ALM_JAVA_HOME

JAVA_HOME=$JAVA6_HOME
export JAVA_HOME

_buildfile_present() {
     [ -f "buildfile" ]
 }

 _buildfile_using_java8() {
     grep -q '1.8' buildfile
 }

buildr() {
    buildr_java_home=$JAVA6_HOME
    if _buildfile_present && _buildfile_using_java8; then
        buildr_java_home=$JAVA8_HOME
    fi
    JAVA_HOME=$buildr_java_home bundle exec \buildr $@
}

export -f buildr
