---
layout: post
title: Continuous Integration tools
subtitle: How we built our CI Platform
authors:
  - aurelien
---

## Introduction

Working on a large project with a team is not an easy task. A large project generally involves many lines of code in different languages with many libraries and sub projects dependencies. Developers work simultaneously on multiple parts of the software and it can become a nightmare to produce a stable and clean build.

That's when *Continuous Integration* (*CI*) comes into play. It's development practice requiring developers to push code on a daily basis in a common branch and execute a list of commands to test and build the project. A more exhaustive definition that we like can be found on [*Thoughtworks*](https://www.thoughtworks.com/continuous-integration) provides.

It seems really important to us to spend some time at the beginning of the project to build a platform supporting this development practice in order to detect errors early and to reduce the technical debt. We want to increase our productivity and our product's reliability by ensuring that every aspect of the codebase is always tested (functional level, speed of execution, network performance, quality of the code). And for that, we have to use and set up some tools.

Our projects are mainly realized in *C++* and are hosted on *GitHub* repositories. We have chosen to create unit tests with the library [*GoogleTest*](https://github.com/google/googletest).

However, this article does not cover the creation of unit tests but describes the various tools to orchestrate and industrialize source code analysis. It goes from fetching and compiling the source code at each modification up to the generation of reports on a single interface with the publication of results on [*Slack*](https://slack.com) or by *email*.
We also go through:

- static code analysis
- complexity
- code duplication
- executing unit tests
- computing code coverage
- testing the application performance

We were looking for tools that meet the following criteria:

- open source license
- running on *unix*
- compatible with *GIT*
- supporting multiple programming languages (*C++*, *Python*, *Javascript* and more to come)
- maintained and documented
- used by established companies

Here is our candidates.

## Jenkins

Of course, the first to be tested was [*Jenkins*](https://jenkins-ci.org) (*MIT license*). It is the most known *CI* tool and one of the most used (*eBay*, *Google*, *Facebook*, *NetFlix*, *Yahoo* and many others). Its installation was fairly simple and fast.

The configuration is done quite easily once you know the analysis tools you want to use. In our case, we used [*GoogleTest*](https://github.com/google/googletest) for unit tests, [*cppcheck*](http://cppcheck.sourceforge.net) for static code analysis and [*gcovr*](http://gcovr.com) to calculate the coverage rate. The different compilations are done through a *Makefile*. This list of tasks is defined through an *Ant* configuration file. Then we just have to install *Jenkins* plugins to retrieve and format the results (*Cobertura Plugin* for the output of *gcovr* and *Cppcheck Plug-in* for *cppcheck*).

You can find the *Ant* file used for our test here: [*build.xml*]({{ site.baseurl }}/assets/Continuous-Integration/Jenkins-Ant-file.html).

The installation, the configuration, and test execution are not too difficult with *Jenkins*. However, analysis of results and reports for developers were clearly not pleasant. The *Jenkins* interface is old and not ergonomic at all although it works fine. We preferred to look for another *CI* system, more modern and ergonomic and keep this solution as a backup plan.

## Strider-CD

[*Strider-CD*](http://stridercd.com) is an open source *CI* and deployment platform. Its installation was really simple. I managed to clone my projects and to add all my commands from the web interface (those which were in our *Ant* file).

In a few minutes, I was able to successfully execute all my tests. However, the main issue with this *CI* is that there is nothing to analyze the reports; you can only set a list of commands, divided into 2 parts: tests and deploy.

Moreover, in spite of a quick installation, the interface is not perfect: some parts are not finished, buggy and there is a lack of features.

## BuildBot

The next tool to be tested is [*BuildBot*](http://buildbot.net) (*GPL license*). It is an Open Source *CI* written in *Python*. Compared to the previous systems, the installation and configuration of this one are a bit more complex.

Indeed, unlike other tools where most configurations were filled with a *GUI*, *BuildBot* must be configured through a *Python* file. It is inside that we define task lists, *GitHub* hook for calling a builder automatically, admin access, and more ... Even if it seems quite complex at first (the untidy documentation does not help) the configuration is more permissive; moreover, once you have understood each part to configure, it is fairly simple to adjust the tool to your problems.

However, there is no way to previewing reports. As *Strider-CD*, the tool only allows the execution of tasks and not the analysis of results.

Finally, the interface is not very modern like *Jenkins*, but it is possible to customize the *HTML* and *CSS* of the tool by overriding the template files.

{% include image.html img="assets/Continuous-Integration/BuildBot-preview.png" caption="BuildBot preview" %}

## PaaS products

Being in 2016, we could not overlook *PaaS* products offering *Continuous Integration* but ultimately we chose not to use them.

Why?

These tools are:

 - offering a great *UI*
 - easier and faster to set up

But:

- they offer less flexibility and features (for instance, many of them do not support pull requests or log compressions)
- we do not want to depend on 3rd party tools for such crucial parts and have our code accessible on remote servers
- some of them (like *Hosted-CI*) are just a hosted *Jenkins* server
- they are quite expensive (*Travis-CI* starts at $139/month) for non open source projects

Some might argue that hosting, installing, configuring and running a *Jenkins* server (or equivalent) is way more expensive but we really want to maintain control over our *CI*.

Although we have not tested extensively these online tools, they could still be useful to you, depending on your needs and criteria. Here are those which were able to hold our attention: [*TeamCity*](https://www.jetbrains.com/teamcity/), [*Codeship*](https://codeship.com/), [*Bamboo*](https://www.atlassian.com/software/bamboo/), [*Drone.io*](https://drone.io), [*CircleCI*](https://circleci.com), [*GitLab-CI*](https://about.gitlab.com/gitlab-ci/) and [*Travis-CI*](https://travis-ci.com).

## SonarQube

What we lacked was a tool that allowing us to analyse and format our results (unit tests, code coverage, static code analysis). We finally found [*SonarQube*](http://www.sonarqube.org/).

*Sonar* does not execute a bunch of commands like the previous tools. However, it can read the results (*XML* files for example) and format them by association with the source code of the project. The interface is really well made, clear, and allows us to see the problems directly on each file (with the aggregation of all results).

We also used [*Sonar-CXX*](https://github.com/SonarOpenCommunity/sonar-cxx), a plugin for *Sonar* to manage the *C++*. It can read the reports of [*Valgrind*](http://valgrind.org), [*cppcheck*](http://cppcheck.sourceforge.net), [*RATS*](https://code.google.com/p/rough-auditing-tool-for-security/), [*gcovr*](http://gcovr.com), [*Vera++*](https://bitbucket.org/verateam/vera/overview) ...

*Sonar* also made some further analysis of the code, such as its complexity or duplication rate. The advantage of using *SonarQube* is to have a global visibility over the source code; if the problems are put forward, it is easier to correct them.

{% include image.html img="assets/Continuous-Integration/Sonar-preview.png" caption="Sonar preview" %}

## Our stack

We have decided to use *BuildBot* and *Sonar* for our *Continuous Integration* platform.

*BuildBot* executes our commands (unit tests, *cppcheck*, *gcovr*, *valgrind*) after receiving an event from *GitHub* (with our hook) and pass the results to *Sonar* (through a script called *sonar-runner*).

Here are our configuration files for these tools:

- *BuildBot* master settings: [master.cfg]({{ site.baseurl }}/assets/Continuous-Integration/BuildBot-Master-cfg.html)
- *Sonar-runner* settings to send the reports to *Sonar* (through the *Sonar plugin-CXX*): [sonar-project.properties]({{ site.baseurl }}/assets/Continuous-Integration/Sonar-Project-Properties.html)

Although the configuration of *BuildBot* is not intuitive, it is one of the tool with the fewest constraints. Here is what the architecture looks like:

{% include image.html img="assets/Continuous-Integration/Conclusion-CI-Schema.png" caption="CI schema" %}

## What's next?

For now, this stack meets our needs. We are going to closely monitor the build time and the failure rates of our builds and see if *BuildBot*'s performances are up to the task.

We are also planning to integrate the code review tool [*Gerrit*](http://www.gerritcodereview.com) in our workflow to improve the quality of our code.
