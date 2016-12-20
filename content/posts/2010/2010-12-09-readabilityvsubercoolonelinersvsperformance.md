---
date: '2010-12-09'
layout: post
slug: readabilityvsubercoolonelinersvsperformance
status: publish
title: Readability VS Uber Cool One Liners VS Performance
wordpress_id: '11'
comments: true
categories:
- CSharp
---

#### Given that you need to do a MD5 hash in C#, which approach would you take?

##### A not so readable but cool one liner:

Or

##### A more readable and performance wise approach?

  
**[Update:]** Alex proposed the following, verbose, but as an extension:

```csharp
public static string CalculateMd5Hash(this String input)
{
    return System.Security.Cryptography.MD5
        .Create()
        .ComputeHash(System.Text.Encoding.Unicode.GetBytes(input))
        .Aggregate(new StringBuilder(), (a, b) => a.Append(b.ToString("X2")), a => a)
        .ToString();
}
```


What do you think?
