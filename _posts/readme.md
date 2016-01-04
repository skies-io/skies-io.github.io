---
layout: post
title: Continuous Integration Platform
subtitle: How we built our CI Platform
authors:
  - aurelien
hidden: true # Draft
---

## Headers

- Authors: list of the authors, defined in *_data/authors.yml*.
- "hidden": True if draft

## Images

{% include image.html img="assets/Continuous-Integration/Introduction-CI-Schema.png" caption="CI schema" %}

## File

Create "/assets/my-dir/my-file.md"

Link: [{{ site.baseurl }}/assets/my-dir/my-file.html]({{ site.baseurl }}/assets/my-dir/my-file.html).

If code, with these kind of headers:

{% highlight yml linenos %}
layout: code
title: Jenkins Ant file
filename: build.xml
{% endhighlight %}
