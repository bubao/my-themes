  {%- set headlessPost = Array.prototype.indexOf.call(['quote', 'picture'], post.type) > -1 %}

  {%- set post_class = 'post post-type-' + post.type | default('normal') %}
  {%- if post_extra_class > 0 %}
    {%- set post_class = post_class + ' ' + post_extra_class | default('') %}
  {%- endif %}
  {%- if post.sticky > 0 %}
    {%- set post_class = post_class + ' post-sticky' %}
  {%- endif %}

  {%- if theme.reading_progress.enable && not is_index %}
    <div class="reading-progress-bar"></div>
  {%- endif %}

  {%- if !post.image || !is_index %}
    <article class="{{ post_class }}" itemscope itemtype="http://schema.org/Article">
      {##################}
      {### POST BLOCK ###}
      {##################}
      <div class="post-block">
        <link itemprop="mainEntityOfPage" href="{{ config.url }}{{ url_for(post.path) }}">

        <span hidden itemprop="author" itemscope itemtype="http://schema.org/Person">
          <meta itemprop="name" content="{{ author }}">
          <meta itemprop="description" content="{{ description }}">
          <meta itemprop="image" content="{{ url_for( theme.avatar.url | default(theme.images + '/avatar.gif') ) }}">
        </span>

        <span hidden itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
          <meta itemprop="name" content="{{ title }}">
        </span>
        
        {%- if not headlessPost %}
          <header class="post-header">

            {# Not to show title for quote posts that do not have a title #}
            {%- if not (is_index and post.type === 'quote' and not post.title) %}
              <{%- if theme.seo %}h2{% else %}h1{%- endif %} class="post-title{%- if post.direction && post.direction.toLowerCase() === 'rtl' %} rtl{%- endif %}" itemprop="name headline">{#
              #}{# Link posts #}{#
              #}{%- if post.link %}
                  {%- if post.sticky > 0 %}
                    <span class="post-sticky-flag" title="{{ __('post.sticky') }}">
                      <i class="fa fa-thumb-tack"></i>
                    </span>
                  {%- endif %}
                  {%- set postTitleIcon = '<i class="fa fa-external-link"></i>' %}
                  {%- set postText = post.title or post.link %}
                  {{ next_url(post.link, postText + postTitleIcon, {class: 'post-title-link post-title-link-external', itemprop: 'url' }) }}
                {% elif is_index %}
                  {%- if post.sticky > 0 %}
                    <span class="post-sticky-flag" title="{{ __('post.sticky') }}">
                      <i class="fa fa-thumb-tack"></i>
                    </span>
                  {%- endif %}
                  {{ next_url(post.path, post.title | default(__('post.untitled')), {class: 'post-title-link', itemprop: 'url' }) }}
                {% else -%}
                  {{- post.title -}}
                  {% include '../_partials/post-edit.swig' %}
                {%- endif %}
              </{%- if theme.seo %}h2{% else %}h1{%- endif %}>
            {%- endif %}

            <div class="post-meta">

              {%- set date_diff = date(post.date) != date(post.updated) %}
              {%- set time_diff = time(post.date) != time(post.updated) %}
              {%- set datetime_diff = date_diff or time_diff %}

              {%- if theme.post_meta.created_at %}
                <span class="post-meta-item">
                  <span class="post-meta-item-icon">
                    <i class="fa fa-calendar-o"></i>
                  </span>
                  <span class="post-meta-item-text">{{ __('post.posted') }}</span>

                  {%- if !date_diff && time_diff && theme.post_meta.updated_at.enable && theme.post_meta.updated_at.another_day %}
                    {%- set create_title = __('post.created') + __('symbol.colon') + full_date(post.date) + ' / ' + __('post.modified') + __('symbol.colon') + time(post.updated) %}
                  {% else %}
                    {%- set create_title = __('post.created') + __('symbol.colon') + full_date(post.date) %}
                  {%- endif %}

                  <time title="{{ create_title }}" itemprop="dateCreated datePublished" datetime="{{ moment(post.date).format() }}">{#
                  #}{{ date(post.date) -}}
                  </time>
                </span>
              {%- endif %}

              {%- if theme.post_meta.updated_at.enable && datetime_diff %}
                {%- set display_updated = !theme.post_meta.updated_at.another_day || theme.post_meta.updated_at.another_day && date_diff %}

                {%- if display_updated or !theme.post_meta.created_at %}
                  <span class="post-meta-item">
                    <span class="post-meta-item-icon">
                      <i class="fa fa-calendar-check-o"></i>
                    </span>
                    <span class="post-meta-item-text">{{ __('post.edited') }}</span>
                    <time title="{{ __('post.modified') + __('symbol.colon') + full_date(post.updated) }}" itemprop="dateModified" datetime="{{ moment(post.updated).format() }}">{#
                    #}{{ date(post.updated) -}}
                    </time>
                  </span>
                {%- endif %}
              {%- endif %}

              {%- if post.categories and post.categories.length and theme.post_meta.categories %}
                <span class="post-meta-item">
                  <span class="post-meta-item-icon">
                    <i class="fa fa-folder-o"></i>
                  </span>
                  <span class="post-meta-item-text">{{ __('post.in') }}</span>
                  {%- for cat in post.categories %}
                    <span itemprop="about" itemscope itemtype="http://schema.org/Thing">{#
                    #}<a href="{{ url_for(cat.path) }}" itemprop="url" rel="index">{#
                      #}<span itemprop="name">{{ cat.name }}</span>{#
                    #}</a>{#
                  #}</span>

                    {%- set cat_length = post.categories.length %}
                    {%- if cat_length > 1 and loop.index !== cat_length %}
                      {{ __('symbol.comma') }}
                    {%- endif %}
                  {%- endfor %}
                </span>
              {%- endif %}

              {# LeanCloud PageView #}
              {%- if theme.leancloud_visitors.enable or (theme.valine.enable and theme.valine.appid and theme.valine.appkey and theme.valine.visitor) %}
                <span id="{{ url_for(post.path) }}" class="post-meta-item leancloud_visitors" data-flag-title="{{ post.title }}" title="{{ __('post.views') }}">
                  <span class="post-meta-item-icon">
                    <i class="fa fa-eye"></i>
                  </span>
                  <span class="post-meta-item-text">{{ __('post.views') + __('symbol.colon') }}</span>
                  <span class="leancloud-visitors-count"></span>
                </span>
              {%- endif %}

              {%- if theme.firestore.enable %}
                <span class="post-meta-item" title="{{ __('post.views') }}">
                  <span class="post-meta-item-icon">
                    <i class="fa fa-users"></i>
                  </span>
                  <span class="post-meta-item-text">{{ __('post.views') + __('symbol.colon') }}</span>
                  <span class="firestore-visitors-count"></span>
                </span>
              {%- endif %}

              {%- if not is_index and theme.busuanzi_count.enable and theme.busuanzi_count.post_views %}
                <span class="post-meta-item" title="{{ __('post.views') }}">
                  <span class="post-meta-item-icon">
                    <i class="fa fa-{{ theme.busuanzi_count.post_views_icon }}"></i>
                  </span>
                  <span class="post-meta-item-text">{{ __('post.views') + __('symbol.colon') }}</span>
                  <span class="busuanzi-value" id="busuanzi_value_page_pv"></span>
                </span>
              {%- endif %}

              {%- for inject_item in theme.injects.postMeta %}
                {{ partial(inject_item.layout, inject_item.locals, inject_item.options) }}
              {%- endfor %}

              {%- if config.symbols_count_time.symbols %}
              {%- if theme.symbols_count_time.separated_meta %}<br>{%- endif %}
                <span class="post-meta-item" title="{{ __('symbols_count_time.count') }}">
                  <span class="post-meta-item-icon">
                    <i class="fa fa-file-word-o"></i>
                  </span>
                  {%- if theme.symbols_count_time.item_text_post %}
                    <span class="post-meta-item-text">{{ __('symbols_count_time.count') + __('symbol.colon') }}</span>
                  {%- endif %}
                  <span>{{ symbolsCount(post) }}</span>
                </span>
              {%- endif %}

              {%- if config.symbols_count_time.time %}
                <span class="post-meta-item" title="{{ __('symbols_count_time.time') }}">
                  <span class="post-meta-item-icon">
                    <i class="fa fa-clock-o"></i>
                  </span>
                  {%- if theme.symbols_count_time.item_text_post %}
                    <span class="post-meta-item-text">{{ __('symbols_count_time.time') }} &asymp;</span>
                  {%- endif %}
                  <span>{{ symbolsTime(post, theme.symbols_count_time.awl, theme.symbols_count_time.wpm, __('symbols_count_time.time_minutes')) }}</span>
                </span>
              {%- endif %}

              {%- if post.description and (not theme.excerpt_description or not is_index) %}
                <div class="post-description">{#
                  #}{{ post.description }}{#
                #}</div>
              {%- endif %}

            </div>
          </header>
        {%- endif %}
        {#################}
        {### POST BODY ###}
        {#################}
        <div class="post-body{%- if post.direction && post.direction.toLowerCase() === 'rtl' %} rtl{%- endif %}" itemprop="articleBody">

          {# Gallery support #}
          {%- if post.photos and post.photos.length %}
            <div class="post-gallery" itemscope itemtype="http://schema.org/ImageGallery">
              {%- set COLUMN_NUMBER = 3 %}
              {%- for photo in post.photos %}
                {%- if loop.index0 % COLUMN_NUMBER === 0 %}<div class="post-gallery-row">{%- endif %}
                  <img src="{{ url_for(photo) }}" itemprop="contentUrl">
                {%- if loop.index0 % COLUMN_NUMBER === 2 %}</div>{%- endif %}
              {%- endfor %}

              {# Append end tag for `post-gallery-row` when (photos size mod COLUMN_NUMBER) is less than COLUMN_NUMBER #}
              {%- if post.photos.length % COLUMN_NUMBER > 0 %}</div>{%- endif %}
            </div>
          {%- endif %}

          {%- if is_index %}
            {%- if post.description and theme.excerpt_description %}
              {{ post.description }}
              <!--noindex-->
              {%- if theme.read_more_btn %}
                <div class="post-button text-center">
                  <a class="btn" href="{{ url_for(post.path) }}">
                    {{ __('post.read_more') }} &raquo;
                  </a>
                </div>
              {%- endif %}
              <!--/noindex-->
            {% elif post.excerpt %}
              {{ post.excerpt }}
              <!--noindex-->
              {%- if theme.read_more_btn %}
                <div class="post-button text-center">
                  <a class="btn" href="{{ url_for(post.path) }}{%- if theme.scroll_to_more %}#more{%- endif %}" rel="contents">
                    {{ __('post.read_more') }} &raquo;
                  </a>
                </div>
              {%- endif %}
              <!--/noindex-->
            {% else %}
              {%- if post.type === 'picture' %}
                <a href="{{ url_for(post.path) }}">{{ post.content }}</a>
              {% else %}
                {{ post.content }}
              {%- endif %}
            {%- endif %}
          {% else %}
            {{ post.content }}
          {%- endif %}
        </div>
        
        {#####################}
        {### END POST BODY ###}
        {#####################}

        {%- if theme.related_posts.enable and (theme.related_posts.display_in_home or not is_index) %}
          {% include '../_partials/post/post-related.swig' with { post: post } %}
        {%- endif %}

        {%- if not is_index %}
          {%- for inject_item in theme.injects.postBodyEnd %}
            {{ partial(inject_item.layout, inject_item.locals, inject_item.options) }}
          {%- endfor %}

          {%- if theme.wechat_subscriber.enable %}
            {{ partial('../_partials/post/wechat-subscriber.swig', {}, {cache: theme.cache.enable}) }}
          {%- endif %}

          {%- if post.reward === undefined and theme.reward_settings.enable %}
            {%- set reward_able = true %}
          {% else %}
            {%- set reward_able = post.reward %}
          {%- endif %}
          {%- if reward_able %}
            {{ partial('../_partials/post/post-reward.swig', {}, {cache: theme.cache.enable}) }}
          {%- endif %}

          {%- if theme.creative_commons.license and theme.creative_commons.post %}
            {% include '../_partials/post/post-copyright.swig' with { post: post } %}
          {%- endif %}

          <footer class="post-footer">
            {%- if post.tags and post.tags.length %}
              {%- if theme.tag_icon %}
                {%- set tag_indicate = '<i class="fa fa-tag"></i>' %}
              {% else %}
                {%- set tag_indicate = '#' %}
              {%- endif %}
              <div class="post-tags">
                {%- for tag in post.tags %}
                  <a href="{{ url_for(tag.path) }}" rel="tag">{{ tag_indicate }} {{ tag.name }}</a>
                {%- endfor %}
              </div>
            {%- endif %}

            {{ partial('../_partials/post/post-footer.swig', {}, {cache: theme.cache.enable}) }}

            {%- if post.prev or post.next %}
              <div class="post-nav">
                <div class="post-nav-next post-nav-item">
                  {%- if post.next %}
                    <a href="{{ url_for(post.next.path) }}" rel="next" title="{{ post.next.title }}">
                      <i class="fa fa-chevron-left"></i> {{ post.next.title }}
                    </a>
                  {%- endif %}
                </div>

                <span class="post-nav-divider"></span>

                <div class="post-nav-prev post-nav-item">
                  {%- if post.prev %}
                    <a href="{{ url_for(post.prev.path) }}" rel="prev" title="{{ post.prev.title }}">
                      {{ post.prev.title }} <i class="fa fa-chevron-right"></i>
                    </a>
                  {%- endif %}
                </div>
              </div>
            {%- endif %}
          </footer>
        {% else %}
          <footer class="post-footer">
            {%- set isLast = loop.index % post.per_page === 0 %}
            {%- if not isLast %}
              <div class="post-eof"></div>
            {%- endif %}
          </footer>
        {%- endif %}
      </div>
      {######################}
      {### END POST BLOCK ###}
      {######################}
    </article>
  {%- endif %}
  {%- if is_index %}
    {%- if post.image %}
      <div class="list-item block card-plain post-block">
        <div class="media media-3x2 col-4 col-md-4">
          <a class="media-content" href="" title="" style="background-image: url({{post.image}});" data-bg="url('https://www.suxing.me/wp-content/themes/PandaPRO-1.0.1-v1/timthumb.php?src=https://www.suxing.me/wp-content/uploads/2019/06/2019062012135210.jpg&amp;h=300&amp;w=450&amp;zc=1&amp;a=c&amp;q=100&amp;s=1')"></a>
        </div>
        <div class="list-content">
        <div class="list-body">
        <a href="{{post.path}}" title="{{post.title}}" class="list-title text-lg h-2x">
          {%- if post.top %}
            <span class="badge badge-hot">推荐</span>
          {%- endif %}
          {{post.title}}
        </a>
        <div class="list-desc d-none d-md-block text-sm text-secondary my-3">
          <div class="h-2x ">{{ post.excerpt }}</div>
        </div>
        </div>
        <div class="list-footer">
          <div class="d-flex flex-fill align-items-center text-muted text-xs">
            <div class="d-none d-md-inline-block"><a href="/{{post.path}}" target="_blank" class="flex-avatar w-20 "><img alt="" src="{{post.image}}" class="avatar avatar-20 photo w-20 loaded" height="20" width="20" data-src="{{post.image}}" data-nclazyload="true" data-srcset="" srcset="" data-was-processed="true"></a></div>
            {%- if post.author %}
              <div class="d-inline-block ml-md-2">
                <a href="/{{post.path}}" title="由{{post.author}}发布" rel="author">{{post.author}}</a>
              </div>
            {%- endif %}
            {%- if !post.author %}
              <div class="d-inline-block ml-md-2">
                <a href="/{{post.path}}" title="由{{author}}发布" rel="author">{{author}}</a>
              </div>
            {%- endif %}
            <div class="d-inline-block mx-1 mx-md-2"><i class="text-primary">—</i></div>
            <div class="d-inline-block">
              <a href="{{post.path}}" target="_blank">博客</a>
            </div>
            <div class="flex-fill"></div>
          <div>
          <time class="mx-1"></time>
        </div>
          </div></div>
        </div>
      </div>
    {%- endif %}
  {%- endif %}
