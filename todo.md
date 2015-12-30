SCHEMA/GRAPHISMES
- screenshots (sonar)

CI TOOLS
- dire par qui il est maintenu s'ils sont connus (genre apache fondation) et qui l'utilise (gage de credibilité)
- Sonar
    -> interet aussi d'avoir une visibilite globale sur notre base de code
    -> si les problemes sont mis en avant on peut plus facilement les traiter (par exemple via l'analyseur de code static)

INTRODUCTION
- mieux expliquer le enjeux dans l'introduction
- utiliser plus de bullet list lors des enumerations afin de rendre le texte plus digeste/lisible (quand tu decris c'est quoi un gros projet, notre stack, etc)
- caser les mots "technical debt" (dette logicielle) et maintainable car c'est tout l'enjeu de la CI
- mieux expliquer nos criteres concernant le choix des outils :
    -> running on UNIX, free
    -> maintained project and up to date project
    -> documented
    -> adopted by well etablished company
    -> compatible with git
    -> supporting several languages and interacting with various tool
- pas utiliser le mot "free" mais plutot parler de licenses proprietaires ou libre (MIT, GPL)
- preciser que les avantages d'avoir une CI platform c'est de perdre un peu de temps a mettre ca en place au debut pour en gagner bcp par la suite
    que c'est un argument de vente auxquels les clients peuvent etre sensibles (preuve qu'il y a des process)

PAAS TOOLS
- expliquer pourquoi on a decide de partir sur une solution maison heberger sur nos serveurs plutot que du hosted CI comme c'est la mode en ce moment
    -> evoquer le manque de liberte
    -> prix trop eleve pour une jeune start up comme nous
    -> manque de certaines features cles sur certaines plate formes

CONCLUSION
- prochaine etape de la CI sera de mettre en place du code review histoire de faire une ouverture ? (genre gerrit de Google)
- dire aussi que nous sommes qu'au debut mais qu'on va monotirer le temps de build et le failure rate de ces builds oud eploiement
    et que si les performances de buildbot sont pas satisfaisantes on repassera ptet sur jenkins (fin qu'on va se baser sur des metriques quoi)
