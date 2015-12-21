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

- Assez rapide à mettre en place
- Utilisation de cppcheck/gcovr
- Rapports pas très compréhensible, interface vieille, non moderne, pas ergo
- Solution fonctionnelle mais pas moderne, solution de secours
- Solution reconnue/sûre

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
