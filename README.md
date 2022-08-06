
# Multiple Application (MAP)
## What is MAP?

 1. Do you have many shortcuts(links) on desktop? Then chances are
    80% of time you only use 20% of them. 
 2. Is your Taskbar is full with program links?
 3. Do you have to search your desktop for programs to run?

> If answer is Yes. Then MAP is the a solution.

`map.exe` runs multiple programs (or simply applications) or desktop shortcuts without searching on the entire system each time.

### How to configure MAP?
You get 2 things in release-package:
1. **Main application program - map.exe**
2. **Map configuration file - map.ini file** - Contains the \<key>=\<value> pair under label **[PROGRAMPATHS]** (don't change label’s name)
3. Put the name of your application(s) and it’s absolute location in the .ini configuration file.

---
*Example:* <br>
If your application 
```Notepad++ version 6.7.4``` is at location ```'D:\Program Files\Notepad++6.7.4\notepad++.exe'```
Then ```map.ini``` file would contain,<br>
```Notepad++ 6.7.4='D:\Program Files\Notepad++6.7.4\notepad++.exe'```  
Similarly other versions/applications can be added to the configuration file.
