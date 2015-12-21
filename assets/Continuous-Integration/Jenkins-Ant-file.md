---
layout: code
title: Jenkins Ant file
filename: build.xml
---

{% highlight xml linenos %}
<?xml version="1.0" encoding="UTF-8"?>
<project name="CppApp" default="jenkins" basedir=".">
    <description>
        Jenkins - Ant file - Cpp Project
    </description>

    <target name="init">
        <tstamp/>
    </target>

    <target name="clean" description="Clean up" >
        <exec dir="./" executable="/usr/bin/make" failonerror="false">
            <arg value="clean"/>
        </exec>
    </target>

    <target name="compile" description="Compile the source files">
        <exec dir="./" executable="/usr/bin/make" failonerror="true">
        </exec>
    </target>

    <target name="compile-tests" description="Compile the tests files">
        <exec dir="./" executable="/usr/bin/make" failonerror="true">
            <arg value="unit_tests"/>
        </exec>
    </target>

    <target name="gtest" description="Run GTest" depends="compile-tests">
        <exec dir="./" executable="./unit_tests" failonerror="true">
            <arg line="--gtest_output='xml:./outputGTest.xml'"/>
        </exec>
    </target>

    <target name="cppcheck" description="Run cppcheck static code analysis" >
        <exec dir="./" executable="/usr/bin/cppcheck" failonerror="true">
            <arg line="--xml --xml-version=2 --enable=all --inconclusive --language=c++ ./src/"/>
            <redirector error="outputCppCheck.xml"/>
        </exec>
    </target>

    <target name="gcovr-xml" description="Run gcovr and generate coverage XML output">
        <exec dir="./" executable="/usr/local/bin/gcovr" failonerror="true">
            <arg line="--branches --xml-pretty -r ./src/"/>
            <redirector output="outputGcovr.xml"/>
        </exec>
    </target>

    <target name="gcovr-html" description="Run gcovr and generate coverage HTML output">
        <exec dir="./" executable="/usr/local/bin/gcovr" failonerror="true">
            <arg line="--branches -r ./src/ --html --html-details -o outputGcovrReport.html"/>
        </exec>
    </target>

</project>
{% endhighlight %}
