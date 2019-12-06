<div class="local-search-pop-overlay"></div>
<div class="site-search">
  <div class="popup search-popup local-search-popup">
    <div class="local-search-header clearfix">
      <span class="search-icon">
        <i class="fa fa-search"></i>
      </span>
      <span class="popup-btn-close">
        <i class="fa fa-times-circle"></i>
      </span>
      <div class="local-search-input-wrapper">
        <input autocomplete="off" placeholder="Searching..." spellcheck="false" type="text" id="local-search-input" autocapitalize="none" autocorrect="off">
      </div>
    </div>
    <div id="local-search-result">
      <ul class="search-result-list">
      </ul>
    </div>
  </div>
</div>
<script src="{{ url_for(theme.js) }}/json-search.js?v={{ version }}"></script>
