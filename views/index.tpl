{% extends 'layout.tpl' %}
{% block content %}

<!-- START THE FEATURETTES -->
    {% for g in games %}
        <div class="row featurette">
            <div class="col-md-7">
                <h2 class="featurette-heading"><a href="/game/{{ g.slug }}">Asteroids</a></h2>
                <p class="lead">{{ g.description }}
                    <!--<img src="img/nw.png">-->
                    <!--<a href="/nw/{{ g.slug }}">Download</a> packaged for <a href="http://nwjs.io/">Node WebKit</a>-->
                </p>
            </div>
            <div class="col-md-5"><a href="/game/{{ g.slug }}">
                <img class="featurette-image img-responsive img-rounded center-block" src="assets/{{ g.slug }}.png" alt="{{ g.name }}">
            </a>
            </div>
        </div>
    {% endfor %}

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-12">
        <h2 class="featurette-heading text-center">
          <span class="text-muted">
            <a href="/about#katra">katra</a> &middot;
            Games from the Dawn of Time
          </span>
        </h2>
      </div>
      </div>
    </div>

    <hr class="featurette-divider">

    {% for k in katras %}
        <div class="row featurette">
            <div class="col-md-7 {% cycle 'col-md-push-5', ''  %}">
                <h2 class="featurette-heading"><a href="/katra/{{ k.slug }}">{{ k.title }}.</a></h2>
                <p class="lead">{{ k.description }}</p>
            </div>
            <div class="col-md-5 {% cycle 'col-md-pull-7', '' %}"><a href="/katra/{{ k.slug }}">
                <img class="featurette-image img-responsive img-rounded center-block" src="/assets/{{ k.slug }}.png" alt="Generic placeholder image">
            </a>
            </div>
        </div>

        <hr class="featurette-divider">
    {% endfor %}
{% endblock %}