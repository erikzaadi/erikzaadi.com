---
date: '2009-12-22'
slug: aspdotnetmvcexceptionhandlingwithjquery
status: publish
title: Asp.Net MVC Exception Handling with jQuery
wordpress_id: '30'
comments: true
categories:
- AspdotNETMvc
- aspnetmvc
- jQuery
---

I stumbled upon this
excellent post by [Sumit](http://2leggedspider.wordpress.com/) : [http://2leggedspider.wordpress.com/2009/12/22/handling-exceptions-using-jquery-and-asp-net-mvc/](http://2leggedspider.wordpress.com/2009/12/22/handling-exceptions-using-jquery-and-asp-net-mvc/)

I thought the idea was great, but the fact that you need to parse it as JSON bothered me.

Since the information needed is only the status code, stack trace and error message, it seemed more appropriate for me to use the existing http response parts that are designed to pass those values.

For the impatient:

[Demo](http://demos.erikzaadi.com/ErrorsForAjax/) | [Source](http://demos.erikzaadi.com/ErrorsForAjax/Content/Source.zip)

###  [Update] Altered the code with [@Neal](http://randomcode.net.nz/), and [@Colin](http://colinbowern.com/)'s feedback..

I created a filter that inherits the default `[HandleError]` Attribute.

```csharp
public class HandleErrorWithAjaxFilter : HandleErrorAttribute  
{  

        public bool ShowStackTraceIfNotDebug { get; set; }  

        public override void OnException(ExceptionContext filterContext)  

            {  

                    if (filterContext.HttpContext.Request.IsAjaxRequest())  

                        {  

                                var content = ShowStackTraceIfNotDebug ||  

                                                    filterContext.HttpContext.IsDebuggingEnabled ?  

                                                        filterContext.Exception.StackTrace :  

                                                        string.Empty;  

                                filterContext.Result = new ContentResult  

                                    {  

                                            ContentType = "text/plain",//Thanks Colin  
                                                Content = content  

                                                };  

                                filterContext.HttpContext.Response.Status =  

                                        "500 " + filterContext.Exception.Message  

                                        .Replace("\r", " ")  

                                        .Replace("\n", " ");  

                                filterContext.ExceptionHandled = true;  

                                filterContext.HttpContext.Response.TrySkipIisCustomErrors = true;  

                            }  

                    else  

                        {  

                                base.OnException(filterContext);  

                            }  

                }  
}  
```

**Note:**

_The typical usage would be to decorate the controller with the `[HandleErrorWithAjaxFilter]` attribute._

However, for the sake of the example, the actions are decorated separately to show the different override usages.

```csharp
public class HomeController : Controller  
{  

    public ActionResult Index()  
    {  

        return View();  

    }  


    [ErrorsForAjax.Models.HandleErrorWithAjaxFilter]  
    public ActionResult ThrowError()  

    {  

        throw new Exception("This is the error message");  

    }  


    [ErrorsForAjax.Models.HandleErrorWithAjaxFilter(ShowStackTraceIfNotDebug = true)]  
    public ActionResult ThrowErrorWithStackTrace()  

    {  

            throw new Exception("This is another error message");  

    }  
}  
```


The filter detects if the request came from Ajax, and if so returns a more slim response, allowing me to capture it in the jQuery ajax method's error handler:


```javascript
$(function() {  

    $("button").click(function() {  

        $.ajax({ error: function(xhr, status, error) {  

                xhr.statusText; //ErrorMessage  
                xhr.responseText; //StackTrace (if debug or overridden)  
                xhr.status; //Numeric status code  
            },  

                url: '/SomeUrlThatMightThrowAnError'  

            });  

        });  

        return false;  

    });  

});  
```

[Demo](http://demos.erikzaadi.com/ErrorsForAjax/) | [Source](http://demos.erikzaadi.com/ErrorsForAjax/Content/Source.zip)

Thanks again to [Sumit](http://2leggedspider.wordpress.com/) for the great idea, and to [Neal](http://randomcode.net.nz/) and [Colin](http://colinbowern.com/) for the feedback.

Erik
