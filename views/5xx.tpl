{% extends 'layout.tpl' %}
{% block content %}
<div class="row">
    <h4 class="alert alert-block alert-warn %>">
        <h3>{{ error.statusCode }}: {{ error.error }}</h3>
        <h4>
            {{ message }}
        </h4>
    </div>
</div>
{% endblock %}