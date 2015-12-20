---
layout: post
title: Continuous Integration
subtitle: Comparison of different systems Continuous Integration (CI) free
authors:
  - aurelien
hidden: true # Draft
---

## Introduction

- Qu'est-ce que CI
- Intérêt
- A faire au début d'un projet
- Mise en place de tests units
- GitHub
- Nos besoins / technos
- Importance d'avoir des tests et de la CI

## Critères des solutions

- Linux
- Gratos
- Sur nos serveurs
- Hook GitHub
- Notifications/Publication sur Slack
- Compilation, units tests, code coverage, static code analysis, stats de perf, code duplication, complexity
- Rapports des résultats

- Schéma : Dévs -> GitHub -> {Build/Unit tests/Coverage/complexity/...} -> Rapports -> {Interface/Slack}

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
