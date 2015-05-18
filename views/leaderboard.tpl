{% extends 'layout.tpl' %}
{% block content %}

<!-- START THE FEATURETTES -->
<div class="row featurette">
  <h2 class="featurette-heading">{{ name }}</h2>
  <table class="table">
    <thead>
    <tr>
      <th>Member</th>
      <th>Rank</th>
      <th>Score</th>
    </tr>
    </thead>
    <tbody>
    {% for leader in leaderboard %}
      <tr>
        <td>{{ leader.member }}</td>
        <td>{{ leader.rank }}</td>
        <td>{{ leader.score }}</td>
      </tr>
    {% endfor %}
    </tbody>
  </table>
</div>
{% endblock %}