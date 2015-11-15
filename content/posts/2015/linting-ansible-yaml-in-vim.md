---
date: 2015-11-15T16:53:43+02:00
description: "So YAML is easy right? You're prolly so badass your don't event lint your YAML..."
title: Linting Ansible YAML in vim
---

### I love Ansible, and one of the reasons is YAML...

But there's just so many [YAML gotcha's](http://docs.ansible.com/ansible/YAMLSyntax.html#gotchas).

In `vim` (Yes, the **mighties** of editors, _that of course you are using right???????_), I'm using the excellent [vim-ansible-yaml](https://github.com/chase/vim-ansible-yaml) plugin that not only adds syntax highlighting, but also snippets (YAY!).

Still though, I've been bitten more than once with those GOTCHA'z, a small escaping here and there.

Suddenly, as I was reading through [DevOps Weekly](http://www.devopsweekly.com/) when I stumbled across [ansible-dk](https://github.com/omniti-labs/ansible-dk), a kit with various tools for working with Ansible.

One of the gems there that I wasn't familiar with was [ansible-lint](https://github.com/willthames/ansible-lint).

Suddenly a thought hit me, what if I'll lint my Ansible YAML files within vim! That'd be truly geek-a-licous!!1

So I forked [syntastic](https://github.com/scrooloose/syntastic/pull/1599) (ZOMG!!1) and added a syntax checker that uses `ansible-lint`.

### AWESOMENESS achieved...

So suddenly I was productive, well, once I removed 1232133 whitespace errors.

### but ALAS

`ansible-lint` won't work if the YAML file is borked and not a valid YAML.

I needed the current files `filetype` to be both `ansible` and `yaml`.

So I could do an `autocmd` in my `.vimrc` that'll set the `filetype` to both by using a dot as a connector:

```
au BufNewFile,BufRead *.yaml set filetype=yaml.ansible
```

But that would add Ansible linting non Ansible YAML, which sucks.

### Fork to the rescue again

I forked [vim-ansible-yaml](https://github.com/chase/vim-ansible-yaml/pull/48), which does some magic to tell if the YAML file edited is indeed an Ansible YAML file.

I added that simple dot notation to the `ftdetect` part and _VOILA_, NERDGASM achieved!

### MAKE IT WORKz FOR ME!!1

Either wait for the pull requests to land, _OR_:

Use my forks in your Vundle / Pathogen / NeoWHATEVER:

```
Plugin 'erikzaadi/vim-ansible-yaml'
Plugin 'erikzaadi/syntastic'
``` 

And then go to your `<vundle install dir>/syntastic` and do `git checkout ansible-syntax-checker`


Live long and deploy fast
