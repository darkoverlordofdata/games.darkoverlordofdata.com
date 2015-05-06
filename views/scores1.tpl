{% extends 'layout.tpl' %}
{% block content %}

<!-- START THE FEATURETTES -->
{% for game in data %}
<div class="row featurette">
  <div class="col-md-7">
    <h2 class="featurette-heading">{{ game.application.id}}</h2>
    <p class="lead">{{ game.application.name }}
      <!--<img src="img/nw.png">-->
      <!--<a href="/nw/{{ game.slug }}">Download</a> packaged for <a href="http://nwjs.io/">Node WebKit</a>-->
    </p>
  </div>
  <div class="col-md-5">{{ game.score }}
  </div>
</div>
{% endfor %}
