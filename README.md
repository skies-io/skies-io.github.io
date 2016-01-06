The Skies Tech Blog

DO NOT COMMIT ON THIS BRANCH (commit and push on 'source')

## How to publish an article

1. Add a md file in _post/ on the source branch
2. commit and push the source branch
3. Everytime a commit is made, buildbot fetch it, build the website and push it to master

This is needed because we have special jekyll plugins (tags, pagination) that cannot be used on github pages.
But we still want to keep the hosting on github pages.


## Draft mode

Set `"hidden": True` in the header of the article

## Articles' ideas

Found with a brainstorming with Dewep. Feel free to edit it.

    Protobuff
    Erasure code
    Politique de test et implementation
    Connecteur VM bug reseau
    Logstash nginx multigne mongodb
    Module FUSE
    Kyoto cabinet
    migration url joblu
    hashgoogle
    utilisation de git
    utilisation de vagrant
    articles angular (pour boucher)
    reseau mesh/ machine discovery
    slack (hooks, philosophie, own robots)
    transports de messages
    cpucounter
