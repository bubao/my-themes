# <div align="center"><a title="Nice website repository" href="https://github.com/theme-next/theme-next.org"><img align="center" width="56" height="56" src="https://raw.githubusercontent.com/theme-next/hexo-theme-next/master/source/images/logo.svg?sanitize=true"></a> i c e</div>

<p align="center">«Nice» is a high quality elegant <a href="http://hexo.io">Hexo</a> theme. It is crafted from scratch with love.</p>

<p align="center">
  <a href="https://bestpractices.coreinfrastructure.org/projects/2625"><img src="https://bestpractices.coreinfrastructure.org/projects/2625/badge" title="Core Infrastructure Initiative Best Practices"></a>
  <a href="https://www.codacy.com/app/theme-nice/hexo-theme-nice?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=theme-nice/hexo-theme-nice&amp;utm_campaign=Badge_Grade"><img src="https://api.codacy.com/project/badge/Grade/72f7fe7609c2438a92069f448e5a341a" title="Project Grade"></a>
  <a href="https://travis-ci.org/theme-nice/hexo-theme-nice?branch=master"><img src="https://travis-ci.org/theme-nice/hexo-theme-nice.svg?branch=master" title="Travis CI [Linux]"></a>
  <a href="https://i18n.theme-nice.org"><img src="https://d322cqt584bo4o.cloudfront.net/theme-nice/localized.svg" title="Add or improve translation in few seconds!"></a>
  <a href="https://github.com/theme-nice/hexo-theme-nice/releases"><img src="https://badge.fury.io/gh/theme-nice%2Fhexo-theme-nice.svg"></a>
  <a href="http://hexo.io"><img src="https://img.shields.io/badge/hexo-%3E%3D%203.5.0-blue.svg"></a>
  <a href="https://github.com/theme-nice/hexo-theme-nice/blob/master/LICENSE.md"><img src="https://img.shields.io/badge/license-%20AGPL-blue.svg"></a>
</p>

## Live Preview

<p align="center">
:heart_decoration: <a href="https://muse.theme-nice.org">Muse</a> | :six_pointed_star: <a href="https://mist.theme-nice.org">Mist</a> | :pisces: <a href="https://pisces.theme-nice.org">Pisces</a> | :gemini: <a href="https://theme-nice.org">Gemini</a>
</p>

<p align="center">More «Nice» examples <a href="https://github.com/iissnan/hexo-theme-nice/issues/119">here</a>.</p>

## Installation

Simplest way to install is by cloning the entire repository:

   ```sh
   $ cd hexo
   $ git clone https://github.com/theme-nice/hexo-theme-nice themes/nice
   ```

Or you can see [detailed installation instructions][docs-installation-url] if you want any other variant.

## Plugins

In Nice config now you can find dependencies on each module which was moved to external repositories which can be found by [main organization link](https://github.com/theme-nice).

For example, if you want to use `fancybox` in your site, go to Nice config and see:

```yml
# Fancybox
# Dependencies: https://github.com/theme-nice/theme-nice-fancybox
fancybox: false
```

Then turn on `fancybox` and go to «Dependencies» link with installation instructions of this module.

### Exceptions

If you use cdn for any plugins, you need to replace your cdn link.

For example, if you want to use `fancybox` and you configured a cdn link, go to Nice config and see:

```yml
vendors:
  # ...
  # Some contents...
  # ...
  fancybox: # Set or update fancybox cdn url.
  fancybox_css: # Set or update fancybox cdn url.
```

Instead of defining [main organization link](https://github.com/theme-nice) for updates.

## Update

You can update to latest master branch by the following command:

```sh
$ cd themes/nice
$ git pull
```

And if you see any error message during update (something like **«Commit your changes or stash them before you can merge»**), recommended to learn [Hexo data files][docs-data-files-url] feature.\
However, you can bypass update errors by using the `Commit`, `Stash` or `Reset` commands for local changes. See [here](https://stackoverflow.com/a/15745424/5861495) how to do it.

**If you want to update from v5.1.x to v6.0.x, read [here][docs-update-5-1-x-url].**

## Contributing

Contribution is welcome, feel free to open an issue and fork. Waiting for your pull request.

## Feedback

* Visit the [Awesome Nice][awesome-nice-url] list.
* Ask a question on [Stack Overflow][stack-url].
* Report a bug in [GitHub Issues][issues-bug-url].
* Request a new feature on [GitHub][issues-feat-url].
* Vote for [popular feature requests][feat-req-vote-url].
* Join to our [Gitter][gitter-url] / [Riot][riot-url] / [Telegram][t-chat-url] chats.
* Follow us with [Telegram Channel][t-news-url] for latest news.