---
layout: post
title: "Inheritance within Python Unit Tests"
date: 2012-09-13
comments: true
categories:  ['python','unittests']
---

#### **TL;DR**: _[Grab the gist](https://gist.github.com/3731389)_

Let's say you have these classes in a python file:

<script src="https://gist.github.com/3731389.js?file=components.py" type="text/javascript"></script>

And you want to write some simple unit tests for them, typically you'd do something like this:

<script src="https://gist.github.com/3731389.js?file=test_components_verbose.py" type="text/javascript"></script>

running them with `nosetests -v` will get you the following result:

```bash
nosetests -v test_components_verbose
user@host:gist-3731389|‹master› ⇒  nosetests -v test_components_verbose.py
Test that initialized is set. ... ok
Test A class constructor set something. ... ok
Test that initialized is set. ... ok
Test B class constructor sets something. ... ok

----------------------------------------------------------------------
Ran 4 tests in 0.001s

OK
```

Although that might seem ok, there's some code duplication here that is really annnoying.
If `ClassA` where to inherit `ClassB` this would seem even more over verbose..

So, how'd you typically approach a problem like this in any OOP environment? 
But of course, inheritance..

Say that we create a base test class, and let `TestA` and `TestB` inherit that class, wouldn't that be cool?

```python
#base_test_class.py
from unittest import TestCase

class BaseTestClass(TestCase):
    """
    Base test class for the two components.
    """

    component = None

    def test_something(self):
        """ Test a component constructor sets something. """

        comp = self.component()

        self.assertTrue(hasattr(comp, "something"))

    def test_initialized(self):
        """ Test that initialized is set. """

        comp = self.component()

        self.assertEquals(comp.initialized, True)
```

```python
#test_components.py
from base_test_class import BaseTestClass
from components import AClass, BClass

class TestA(BaseTestClass):
    """ Test the A class. """

    component = AClass


class TestB(BaseTestClass):
    """ Test the B class. """

    component = BClass
```

Running `nosetest -v` now should work right?

```bash
nosetests -v test_components
user@host:gist-3731389|‹master› ⇒  nosetests test_components -v
BaseTestClass : Test that initialized is set. ... ERROR
test_something (test_components.BaseTestClass) ... ERROR
Test that initialized is set. ... ok
Test a component constructor sets something. ... ok
Test that initialized is set. ... ok
Test a components constructor sets something. ... ok

======================================================================
ERROR: BaseTestClass : Test that initialized is set.
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/media/data/Code/Tests/gist-3731389/base_test_class.py", line 37, in test_initialized
      comp = self.component()
      TypeError: 'NoneType' object is not callable

      ======================================================================
      ERROR: test_something (test_components.BaseTestClass)
      ----------------------------------------------------------------------
      Traceback (most recent call last):
        File "/media/data/Code/Tests/gist-3731389/base_test_class.py", line 30, in test_something
            comp = self.component()
            TypeError: 'NoneType' object is not callable

            ----------------------------------------------------------------------
            Ran 6 tests in 0.001s

            FAILED (errors=2)
```

**OY VEI!**

So what happened here?

Since the base class and the test classes (in the end) inherits `unittest.TestCase`, and `BaseTestClass` was importerted to `test_components.py`, they're run automagically by nose.

Have no fear, we're in the magic unicorn world of python, there's a magic property that fixes this:

```python
#base_test_class.py
from unittest import TestCase

class BaseTestClass(TestCase):
    """
    Base test class for the two components.
    """

    __test__ = False #important, makes sure tests are not run on base class

    component = None

    ... #rest of file
```

Note that you need to explicitly set `__test__` to `True` in the child classes.

<script src="https://gist.github.com/3731389.js?file=test_components.py" type="text/javascript"></script>

Running `nosetests -v test_components` again should yield the following result:

```bash
nosetests -v test_componets
user@host:gist-3731389|‹master› ⇒  nosetests test_components -v
Test that initialized is set. ... ok
Test a component constructor sets something. ... ok
Test that initialized is set. ... ok
Test a component constructor sets something. ... ok

----------------------------------------------------------------------
Ran 4 tests in 0.001s

OK
```

Ok, works, but still, there's something bothering in the log output.
How can you tell which component where tested? 
It's a bit unverbose-ish..

Adding a bit more python magic and voila :

<script src="https://gist.github.com/3731389.js?file=base_test_class.py" type="text/javascript"></script>

Running `nosetests -v` now shows the following stunning (!) result:

```bash
nosetests -v test_components
user@host:gist-3731389|‹master› ⇒  nosetests test_components -v
TestA : Test that initialized is set. ... ok
TestA : Test AClass constructor sets something. ... ok
TestB : Test that initialized is set. ... ok
TestB : Test BClass constructor sets something. ... ok

----------------------------------------------------------------------
Ran 4 tests in 0.001s

OK
```

w00t!

So what have we got here?

We've overridden `shortDescription` and prefixed with the current class which is running.

We've even added a possibility to add the component name in the docstring for string formatting, which might be just a little bit too much if you want to make a generic base class..


Enjoy and keep on python-ing!
