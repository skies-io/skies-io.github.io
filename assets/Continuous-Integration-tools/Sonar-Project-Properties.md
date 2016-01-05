---
layout: code
title: Sonar Project Properties
filename: sonar-project.properties
---

{% highlight INI linenos %}
# https://github.com/SonarOpenCommunity/sonar-cxx/tree/master/sonar-cxx-plugin/src/samples/SampleProject2

sonar.projectKey=CxxPlugin:SkiesSmartStorage
sonar.projectName=SkiesSmartStorage
sonar.projectVersion=1.0.0
sonar.language=c++

sonar.sources=src
sonar.tests=tests

sonar.cxx.cppcheck.reportPath=report-cppcheck.xml
sonar.cxx.coverage.reportPath=report-gcovr.xml
sonar.cxx.valgrind.reportPath=report-valgrind.xml
sonar.cxx.xunit.reportPath=report-xunit.xml

sonar.cxx.includeDirectories=/usr/include,include,src
{% endhighlight %}
