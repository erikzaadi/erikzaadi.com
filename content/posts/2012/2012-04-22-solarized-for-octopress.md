---
title: "Solarized color scheme for Octopress"
date: 2012-04-22
comments: true
categories: [octopress, solarized, css]
tags: [octopress, solarized, css]
---

### Created a  [solarized](http://ethanschoonover.com/solarized)  theme for [octopress](http://octopress.org).
Inspired by Ethan Schoonover's [own homepage](http://ethanschoonover.com/).

The source is as always [on github](https://github.com/erikzaadi/solarized-octopress-theme).

To add this to your own Octopress instance : 

```bash
cd /my/awesome/octopress/dir
git clone http://github.com/erikzaadi/solarized-octopress-theme .themes/solarized
rake install["solarized"]
```

_zsh users_ : run 
```bash
rake install\['solarized'\]
``` 
instead of the last command

### Customize

To toggle between light and dark mode, edit `sass/custom/_colors.scss` and change `$sol` and ``$solarized`:

```css
$sol : light; // light or dark -  Recommended: set $solarized  to the opposite of this
$solarized : dark; // code syntax highlighting theme
```

### Screenshots

![Dark](https://github.com/erikzaadi/solarized-octopress-theme/raw/master/images/dark.png)

![Light](https://github.com/erikzaadi/solarized-octopress-theme/raw/master/images/light.png)
