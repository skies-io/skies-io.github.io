---
layout: code
title: BuildBot Master configurations file
filename: master.cfg
---

{% highlight python linenos %}
# -*- python -*-

from buildbot.plugins import *

c = BuildmasterConfig = {}

####### BUILDSLAVES

c['slaves'] = [buildslave.BuildSlave("slave", "S2n6zzCzKeuTChsmbpW7")]

c['protocols'] = {'pb': {'port': 9989}}

####### CHANGESOURCES

c['change_source'] = []

####### SCHEDULERS

c['schedulers'] = []
c['schedulers'].append(schedulers.SingleBranchScheduler(name="all", change_filter=util.ChangeFilter(branch='master'), treeStableTimer=None, builderNames=["runtests"]))
c['schedulers'].append(schedulers.ForceScheduler(name="force", builderNames=["runtests"]))

####### BUILDERS

factory = util.BuildFactory()

factory.addStep(steps.Git(repourl='git@github.com:skies-io/repository.git', branch='master', mode='incremental'))
factory.addStep(steps.ShellCommand(command=["make", "clean"]))
factory.addStep(steps.ShellCommand(command=["make", "unit_tests"]))
factory.addStep(steps.ShellCommand(command="cppcheck -v --xml --xml-version=2 --enable=all --inconclusive --language=c++ -Iinclude/ src/ 2> report-cppcheck.xml"))
factory.addStep(steps.ShellCommand(command=["valgrind", "--xml=yes", "--xml-file=report-valgrind.xml", "./unit_tests", "--gtest_output=xml:report-xunit.xml"]))
factory.addStep(steps.ShellCommand(command="gcovr -x -r . > report-gcovr.xml"))
factory.addStep(steps.ShellCommand(command=["/opt/sonar-runner/bin/sonar-runner", "-X"]))

c['builders'] = []
c['builders'].append(util.BuilderConfig(name="runtests", slavenames=["slave"], factory=factory))

####### STATUS TARGETS

c['status'] = []

from buildbot.status import html
from buildbot.status.web import authz, auth

authz_cfg=authz.Authz(auth=auth.BasicAuth([("admin", "S2n6zzCzKeuTChsmbpW7")]), forceBuild = 'auth', forceAllBuilds = 'auth')
github = {'github': {'secret': "692cf6d5b41c53a7a62c7f323c91038a5ac34f784eb11e92670c425e", 'strict': True}}
c['status'].append(html.WebStatus(http_port=8010, authz=authz_cfg, change_hook_dialects=github))

####### PROJECT IDENTITY

c['title'] = "Skies Smart Storage"
c['titleURL'] = "https://github.com/skies-io/repository/"
c['buildbotURL'] = "http://127.0.0.1:8010/"

####### DB URL

c['db'] = {'db_url': "sqlite:///state.sqlite"}
{% endhighlight %}
