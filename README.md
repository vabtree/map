# Multiple Application
map.exe runs multiple versions of same or different programs without searching on the entire machine each time.

### How to configure?
You get only 2 things in package:
1. **Application file - map.exe**
2. **Configuration file - map.ini file** - Contains the <key>=<value> under label **[PROGRAMPATHS]** (don't change label’s name)
3. Put the name of your application(s) and it’s absolute location in the .ini file.

---
*Example:* <br>
If your application 
```Notepad++ version 6.7.4``` is at location ```'D:\Program Files\Notepad++6.7.4\notepad++.exe'```
Then map.ini file would contain,<br>
```Notepad++ 6.7.4='D:\Program Files\Notepad++6.7.4\notepad++.exe'```  
Similarly other versions/applications can be added to the configuration file.