{{ open_graph() }}

{%- if theme.rss === '' and config.feed and config.feed.path %}
  {%- set theme.rss = config.feed.path %}
{%- endif %}
{%- if theme.rss %}
  <link rel="alternate" href="{{ url_for(theme.rss) }}" title="{{ title }}" type="application/atom+xml">
{%- endif %}

{%- if theme.canonical %}
  {%- set without_index = url.replace('index.html', '') %}
  {%- set without_html = without_index.replace('.html', '') %}
  <link rel="canonical" href="{{ without_html }}">
{%- endif %}

{# Exports some front-matter variables to Front-End #}
<script id="page-configurations">
  CONFIG.page = {
    sidebar: {{ page.sidebar | json_encode }},
    isHome: {{ is_home() }},
    isPost: {{ is_post() }},
    isPage: {{ is_page() }},
    isArchive: {{ is_archive() }}
  };
</script>
