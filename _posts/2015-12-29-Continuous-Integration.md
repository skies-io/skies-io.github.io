---
layout: post
title: Continuous Integration
subtitle: Comparison of different free Continuous Integration systems (CI)
authors:
  - aurelien
hidden: true # Draft
---

## Introduction

A large project is announced: teamwork, use of many libraries, many lines of code, and several sub projects that will be eventually linked together. If we do not quickly install a Continuous Integration (CI) system it will be difficult to do later.

This system will allow us to verify the source code all through the project in order to increase productivity and reliability by ensuring our code is always tested (both at the functional level, performance or the quality of the code). For that, we have to use and setting up some tools.  

Our projects are mainly realized in C++ and are hosted on GitHub repositories. We chose to create unit tests with the library "GoogleTest". This article does not cover the creation of unit tests but the various tools to orchestrate and industrialize source code analysis : from recovering and compiling the source code at each modification up to the the generation of reports on a single interface with the publication of results (on Slack or by email) through static code analysis, complexity, code duplication, executing unit tests, computing code coverage, and finally testing the application performance.

{% include image.html img="assets/Continuous-Integration/Introduction-CI-Schema.png" caption="CI schema" %}

We were looking for tools that can be installed on our own servers (Unix) and which are free.

## Jenkins

Of course, the first to be tested was Jenkins. It is the most known CI tool and one of the most used. Its installation was fairly simple and fast.

The configuration is done quite easily once you know the analysis tools you want to use. In our case, we used "Google Test" for unit tests, "cppcheck" for static code analysis and "gcovr" to calculate the coverage rate. The different compilations are done through a "Makefile". This list of tasks is defined through an Ant configuration file. Then we just have to install Jenkins plugins to retrieve and format the results (i.e.: "Cobertura Plugin" for the output of "gcovr", "Cppcheck Plug-in" for "cppcheck"...).

You can find the Ant file used for our test here: [build.xml]({{ site.baseurl }}/assets/Continuous-Integration/Jenkins-Ant-file.html).

The installation, the configuration, and test execution are not too difficult with Jenkins. However, analysis of results and reports for developers were clearly not pleasant. The Jenkins interface is old and not ergonomic at all although it works fine. We preferred to look for another CI system, more modern and ergonomic and keep this solution as a backup plan.

## Strider-CD

Strider-CD is an Open Source CI and Deployment platform. Its installation was really simple. I managed to clone my projects and to add all my commands from the web interface (those which were in our Ant file).

In a few minutes, I was able to successfully execute all my tests. However, the main issue with this CI is that there is nothing to analyze the reports; you can only set a list of commands, divided into 2 parts: tests and deploy.

Moreover, in spite of a quick installation, the interface is not perfect: some parts are not finished, buggy and a lack of features is present.

## BuildBot

Next system, BuildBot. It is an Open Source CI written in Python. Compared to the previous systems, the installation and configuration of this one are a bit more complex.

Indeed, unlike other tools where most configurations were filled with a GUI, BuildBot must be configured through a python file. It is inside that we define task lists, GitHub hook for calling a builder automatically, admin access, and more ... Even if it seems quite complex at first (the untidy documentation does not help) the configuration is more permissive; Moreover, once you have understood each part to configure, it is fairly simple to adjust the tool to your problems.

However, there is no way to previewing reports. As Strider-CD, the tool only allows the execution of tasks and not the analysis of results.

Finally, the interface is not very modern like Jenkins, but it is possible to customize the HTML and CSS of the tool by overriding the template files.

## Nonfree software

I did not manage to find better tools that meet our criteria that they cited previously. Most modern tools are charged (and hosted in the cloud).

But some of them seem really complete while remaining much more ergonomic and easier to configure than Jenkins/Strider-CD/BuildBot. Some even offer free solutions for your public repositories.

Although we have not tested these online tools, they can be useful to your criteria. Here are those who were able to hold our attention: TeamCity, Codeship, Bamboo, Drone.io, CircleCI, GitLab-CI and Travis-CI.

## Sonar

What we lacked was a tool that allowing us to analyse and format our results (unit tests, gcovr, static code analysis ...). We finally found Sonar.

Sonar does not execute a bunch of commands like the previous tools. However, it can read the results (XML files for example) and format them by association with the source code of the project. The interface is really well made, clear, and allows us to see the problems directly on each file (with the aggregation of all results).

We also used Sonar-CXX, a plugin for Sonar to manage the C++. It can read the reports of Valgrind, Cppcheck, RATS, gcovr, Vera++ ...

Sonar also made some further analysis of the code, such as its complexity or duplication rate.

## Our choice

Sonar is really well done, we decided to opt for this solution. However, it requiring another tool for executing commands and sending it the results, so we also decided to use BuildBot.

Thus, BuildBot executes our commands (unit tests, cppcheck, gcovr, valgrind, ...) after receiving an event from GitHub (with our hook) then it takes care to call "sonar-runner" to send our results to Sonar.

Here are our configuration files for these tools:

- BuildBot master settings: [master.cfg]({{ site.baseurl }}/assets/Continuous-Integration/BuildBot-Master-cfg.html)
- "Sonar-runner" settings to send the reports to Sonar (through the Sonar plugin-CXX): [sonar-project.properties]({{ site.baseurl }}/assets/Continuous-Integration/Sonar-Project-Properties.html)

Although the configuration of BuildBot is not intuitive, it is the one with the fewest constraints. And even if this is not done yet, the interconnection with Slack can be made easily.

{% include image.html img="assets/Continuous-Integration/Conclusion-CI-Schema.png" caption="CI schema" %}
