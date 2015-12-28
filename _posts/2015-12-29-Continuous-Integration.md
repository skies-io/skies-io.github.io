---
layout: post
title: Continuous Integration
subtitle: Comparison of different systems Continuous Integration (CI) free
authors:
  - aurelien
hidden: true # Draft
---

## Introduction

A large project announced: teamwork, use of many libraries, many lines of code, and several mini-projects that will eventually be linked together. If we do not quickly install a Continuous Integration (CI) system it will be difficult to do later.

This system will allow us to verify the source code throughout the project in order to increase productivity and reliability by ensuring your code is always tested (both at the functional level, performance or quality of the code). For this, we will have to use and set up some tools.

Our projects are realized mainly in C++ and are hosted on GitHub repositories. We chose to create unit tests with the library "GoogleTest". This article does not detail the created of unit tests, but the various tools to recover the source code at each modification, the code analysis (static code analysis, complexity, code duplication), the test compilations, the launch of unit tests, the calculation of unit tests coverage, the application performance and finally the generation of reports on a single interface with the publication of results (on Slack or by email).

{% include image.html img="assets/Continuous-Integration/Introduction-CI-Schema.png" caption="CI schema" %}

We were looking for tools that can be installed on our own servers (Unix) and which are free.

## Jenkins

Of course, the first to be tested was Jenkins. It is the CI tool the most known and one of the most used. Its installation was fairly simple and fast.

The configuration is done quite easily once you know the analysis tools you want to use. In our case, we used "Google Test" for unit tests, "cppcheck" for static code analysis and "gcovr" to calculate the coverage rate. The different compilations are done through a "Makefile". This list of tasks is defined via an Ant configuration file. Then just install Jenkins plugins to retrieve and format the results ("Cobertura Plugin" for the output of "gcovr", "Cppcheck Plug-in" for "cppcheck",...).

You can find the Ant file used for our test here: [build.xml]({{ site.baseurl }}/assets/Continuous-Integration/Jenkins-Ant-file.html).

The installation, the configuration, and test execution are not too difficult with Jenkins. However, analysis of results and reports for developers were clearly not excellent. The Jenkins interface is old and is not ergonomic at all (although it works fine). We preferred to look for another CI system, more modern and ergonomic and keep this solution in a backup plan.

## Strider-CD

Strider-CD is an Open Source CI and Deployment platform. Its installation was really simple. I managed to clone my projects and I added all my commands from the web interface (those which were in our Ant file).

In a few minutes, I succeeded to run all my tests. However, the main issue in this CI is that there are nothing to analyze the reports; you only can set a list of commands, divided into 2 parts (tests and deploy).

Moreover, in spite of a quick installation, the interface was not perfect (some parts are not completed, there are some bugs and lack of features).

## BuildBot

Next system, BuildBot. It is an Open Source CI written in Python. Compared to the previous systems, the installation and configuration of this one are a bit more complex.

Indeed, unlike other tools where most configurations were filled with a GUI, BuildBot must be configured through a python file. It is inside that we define task lists/commands, define GitHub hook for calling a builder automatically, define admin access, ... Even if this is quite complex at first (also due to documentation slightly messy) the configuration is more permissive; Moreover, once we have understood each part to configure, it is fairly simple to adjust the tool to our problems.

However, there is no way to previewing reports. As Strider-CD (although BuildBot is more complete), the tool only allows the execution of tasks and not the analysis of results.

Finally, the interface is not very modern (like Jenkins), but it is possible to customize the HTML and CSS of the tool by overriding the template files.

## Nonfree software

I did not manage to find better tools that meet our criteria that they cited previously. Most modern tools are paid (and hosted directly on the server of the solutions).

But some seem really complete (while remaining much more ergonomic and easier to configure than Jenkins/Strider-CD/BuildBot). Some even offer free solutions, whether they are public repositories.

Although we have not tested these online tools, they can be useful to your criteria. Here are those who were able to hold our attention: TeamCity, Codeship, Bamboo, Drone.io, CircleCI, GitLab-CI and Travis-CI.

## Sonar

What we lacked was a tool that allowed us to analyse and format our results (unit tests, gcovr, static code analysis ...). But we got hold of Sonar.

Sonar does not execute a list of commands, not to run the unit tests, or to actualize automatically after a GitHub hook. However, it can read the results (XML files for example) and put them in shape, by coupling with the source code of the project. The interface is really well made, clear, and allows us to see the problems directly on each file (with the aggregation of all results).

We also used Sonar-CXX, a plugin for Sonar to manage the C++. It can read the reports of Valgrind to Cppcheck, RATS, gcovr, Vera++ ...

Sonar also made some further analysis of the code, such as its complexity or duplication rate.

## Our choice

Sonar is really well done, we decided to opt for this solution. However, requiring another tool for executing commands and send it the results, we decided to use BuildBot.

Thus, BuildBot executes our commands after receiving a GitHub hook (unit tests, cppcheck, gcovr, valgrind, ...) then takes care to call "sonar-runner" to send our results to Sonar.

Here are our two configuration files for these tools:

- BuildBot master settings: [master.cfg]({{ site.baseurl }}/assets/Continuous-Integration/BuildBot-Master-cfg.html)
- "Sonar-runner" settings to send the reports to Sonar (through the Sonar plugin-CXX): [sonar-project.properties]({{ site.baseurl }}/assets/Continuous-Integration/Sonar-Project-Properties.html)

Although the configuration BuildBot is not intuitive, it's the one with the fewest constraints, being really customizable. And even if this is not yet done, the liaison with Slack can be done easily.

{% include image.html img="assets/Continuous-Integration/Conclusion-CI-Schema.png" caption="CI schema" %}
