# Helm chart repository for jupyterbook-pub-service

This is a bare Helm chart repository specifically for the jupyterbook-pub-service chart.

For more information, visit the [project's documentation](https://jupyterbook-pub-service.readthedocs.io/).

{% for chartmap in site.data.index.entries %}

## Releases: {{ chartmap[0] }}

| Version                               | Date            | App. version |
| ------------------------------------- | --------------- | ------------ |
| {%- assign sortedcharts = chartmap[1] | sort: 'created' | reverse %}   |

{%- for chart in sortedcharts %}
| [{{ chart.version }}]({{ chart.urls[0] }}) | {{ chart.created | date_to_long_string }} | {{ chart.appVersion }} |
{%- endfor %}
{%- endfor %}
