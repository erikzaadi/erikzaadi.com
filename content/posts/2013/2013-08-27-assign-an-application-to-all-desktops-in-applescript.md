---
title: "Assign an Application to all desktops in Applescript"
date: 2013-08-27
comments: true
categories: [development, mac, applescript]
---

### Back to basics, applescript

It's been a while since I wrote applescript.

Although the capabilities are truly amazing, I never really connected to the `tell` syntax, a bit to verbose for me.

Anyhow, I'm using [slate](https://github.com/jigish/slate) for automagically position apps when I change monitors (amongs other things), and I needed a way to pin certain applications to all desktops when using multiple monitors, or to a specific desktop when using just one monitor.

You can run this script from the shell (if you chmod it): 

```applescript
assignTo this|all Chrome Adium "App with spaces"
```

Source

```applescript
#!/usr/bin/osascript
script assignTo
	on toAllDesktops(appsList)
		forAllChats("All Desktops", appsList)
	end toAllDesktops
	
	
	on toThisDesktop(appsList)
		forAllChats("This Desktop", appsList)
	end toThisDesktop
	
	on forAllChats(toSet, appsList)
		repeat with appName in appsList
			tell application "System Events" to tell UI element appName of list 1 of process "Dock"
				perform action "AXShowMenu"
				click menu item "Options" of menu 1
				click menu item toSet of menu 1 of menu item "Options" of menu 1
			end tell
		end repeat
	end forAllChats
end script
on run argv
    tell application "Finder"
        set scriptName to name of file (path to me) as text
    end tell
	set usage to scriptName & "
	Usage: all|this Application1 ApplicationN"
	if (count of argv) is 0 then
		return usage
	end if
	set what to item 1 of argv
	set apps to rest of items of argv
	if (count of apps) is 0 then
		return usage & "
	At least one application is required!"
	end if
	tell assignTo
		if what is "all" then
			toAllDesktops(apps)
		else if what is "this" then
			toThisDesktop(apps)
		else
			return usage
		end if
	end tell
end run

```

Enjoy
