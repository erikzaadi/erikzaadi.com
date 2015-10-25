---
date: '2010-01-09'
layout: post
slug: usingmvcusercontrolsfromanothercontroller
status: publish
title: Using Mvc user controls from another controller
wordpress_id: '28'
comments: true
categories:
- AspdotNETMvc
- aspnetmvc
- CSharp
---

I needed to use a user control from a different controllers folder in a view.

Should be easy I thought, there’s probably an overload for the Html.RenderPartial that with the controller name.

Unfortunately, that’s not the case.

If you look at the solution layout below:

![](/images/SolutionLayout11.png) 

I needed to user the `OtherControl.ascx` from the Home controllers views.

Passing only the user control name to the `Html.RenderPartial` won’t work, and you’ll end up with an error like this:

![](/images/Error8.png)

Which is rather logical, as that’s the default behavior of the web forms view engine.

Overcoming the problem is rather strait forward :

```
<% Html.RenderPartial("../Other/OtherControl", new string[] { "ListItem1", "ListItemN" }); %>
```

Not the most elegant solution, but it works..

[Demo](http://demos.erikzaadi.com/UserControlsSample/) | [Source](http://demos.erikzaadi.com/UserControlsSample/Content/Source.zip)

Cheers

Erik
