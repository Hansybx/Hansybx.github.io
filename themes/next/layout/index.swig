{% extends '_layout.swig' %}
{% import '_macro/sidebar.swig' as sidebar_template with context %}

{% block title %}{{ title }}{%- if theme.index_with_subtitle and subtitle %} - {{ subtitle }}{%- endif %}{% endblock %}

{% block class %}index posts-expand{% endblock %}

{% block content %}

  {#<div class="posts-expand">#}
    {#{%- for post in page.posts.toArray() %}#}
      {#{{ partial('_macro/post.swig', {post: post, is_index: true}) }}#}
    {#{%- endfor %}#}
  {#</div>#}
  <div class="poem" style="text-align:center">
	  <p>那时我们有梦</p>
	  <p>关于文学</p>
	  <p>关于爱情</p>
	  <p>关于穿越世界的旅行</p>
	  <p>如今我们深夜饮酒</p>
	  <p>杯子碰到一起</p>
	  <p>都是梦破碎的声音</p>
	  <p>《波兰来客》</p>
  </div>
  {% include '_partials/pagination.swig' %}

{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
