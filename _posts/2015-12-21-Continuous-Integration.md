---
layout: post
title: Continuous Integration
subtitle: Comparison of different systems Continuous Integration (CI) free
authors:
  - aurelien
hidden: true # Draft
---

## Introduction

A large project announced: teamwork, use of many libraries, many lines of code, several mini-projects that will eventually be linked together... If we do not quickly install a Continuous Integration (CI) system it will be difficult to do later.

This system will allow us to verify the source code throughout the project in order to always be sure not to do regressions (both at the functional level, performance or quality of the code). For this, we will have to use and set up some tools.

Our projects are realized mainly in C++ and are hosted on GitHub repositories. We chose to create unit tests with the library "GoogleTest". This article does not detail the created of unit tests, but the various tools to recover the source code at each modification, the code analysis (static code analysis, complexity, code duplication), the test compilations, the launch of unit tests, the calculation of unit tests coverage, the application performance and finally the generation of reports on a single interface with the publication of results (on Slack or by email).

{% include image.html img="assets/Continuous-Integration/Introduction-CI-Schema.png" caption="CI schema" %}

We were looking for tools that can be installed on our own servers (Unix) and which are free.

## Jenkins

Of course, the first to be tested was Jenkins. It is the CI tool the most known and one of the most used. Its installation was fairly simple and fast.

The configuration is done quite easily once you know the analysis tools you want to use. In our case, we used "Google Test" for unit tests, "cppcheck" for static code analysis and "gcovr" to calculate the coverage rate. The different compilations are done through a "Makefile". This list of tasks is defined via an Ant configuration file. Then just install Jenkins plugins to retrieve and format the results ("Cobertura Plugin" for the output of "gcovr", "Cppcheck Plug-in" for "cppcheck",...).

You can find the Ant file used for our test here: [build.xml]({{ site.baseurl }}/assets/Continuous-Integration/Jenkins-Ant-file.html).

The installation, the configuration, and test execution is not too difficult with Jenkins. However, analysis of results and reports for developers were clearly not excellent. The Jenkins interface is old and is not ergonomic at all (although it works fine). We preferred to look for another CI system, more modern and ergonomic, and keep this solution in backup plan.

## Strider-CD

- Pres
- Wrapper de commandes only
- Rapide à mettre en place
- Plusieurs bugs
- Impossible de visualiser les rapports
- Pas assez flexible
- Pas très reconnu

## Non free software

- Online/Hosted
- Free only for public repositories

- TeamCity
- Codeship
- Bamboo
- Drone.io
- CircleCI
- GitLab-CI
- Travis-CI

## BuildBot

- Pres
- Tres flexible, plusieurs listes de commandes
- Hook GitHub
- Installation et configuration complexes, pas user friendly
- Pas de moyen de visualiser les rapports
- Solution sûre/reconnue

## Sonar

- Visualiseur de rapports
- Calculs de la complexity du code ou du taux de duplication
- N'est pas fait pour lancer les tests units
- Possible du coup de le linker à Jenkins/Strider-CD/BuildBot, qu'ils pourraient envoyer les rapport à Sonar
- Plugin CXX pour lire les rapports gcovr/static analysis/...

## Notre choix

- Utilisation de Sonar, avec un autre outil permettant d'exécuter toutes les tâches
- BuildBot était le plus flexible, reconnu, et plus ergonomique que Jenkins
- Une fois comprise, la configuration est même simple via BuildBot que Jenkins, et plus permissive
- Même si ce n'est pas encore fait, la liaison avec Slack pourra se faire aisément

- Schéma :
Dév -> GitHub -> Hook GitHub -> BuildBot Master
<-> BuildBot Slave (build, cppcheck, gcovr, ...)
-> Sonar
-> Publication des résultats (Slack/Emails/...)
--> Dev
