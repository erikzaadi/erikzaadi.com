---
title: "Mocking Python imports"
date: 2012-07-03
comments: true
categories: [python, mock, unittests, tdd]
---

Writing unit tests with Python is a joy, especially with the excellent [mock](http://www.voidspace.org.uk/python/mock/) library.

You can tweak the language and mock almost anything to your will, making testing even the smallest of units very easy.

**HOWEVER** , mocking imports, when a class / module depends on imports which you might not have on your machine, such as windows modules (oei vei) when you are (and you should be) on a nix machine.

Another typical case is when you integrate a module to a big system, which imports **THE ENTIRE INTERNETZ** in each file.

In those cases it's critical to be able to isolate your class / module by totally disconnecting it from those modules.

Mock to the rescue:

**TLDR:** *you can clone `git://gist.github.com/3039780.git` and play around with it...*


<script src="https://gist.github.com/erikzaadi/3039780.js?file=third_party_module.py"></script>

<script src="https://gist.github.com/erikzaadi/3039780.js?file=my_module.py"></script>

<script src="https://gist.github.com/erikzaadi/3039780.js?file=test_bad_module.py"></script>

Running nosetest now will yield the following :

```bash
nosetests
E.
======================================================================
ERROR: Failure: ImportError (No module named the.internetz)
----------------------------------------------------------------------
```

To fix this, we need to mock the *"the internetz"* module:

<script src="https://gist.github.com/erikzaadi/3039780.js?file=test_good_module.py"></script>

The reason to put all the patches, mocks and imports in the `setUp` function is that you'd probably reuse them in the same test class on other test methods.
