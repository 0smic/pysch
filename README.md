# pysch

Here you can view all the scripts and etc. of the hacks I have done.
We're just explore the beauty. After we done with it. You will set back to default.
You can also see a backup script which only remove simple footprints and restore the sys to normal <3

## Pysch SSH
FIRST OFF ALL

  it's not like u think. And I built it for getring into my campus machine so i can learn about unix sys and etc.... * _ *
  well I have reconfigured firewall so it will ignore conns outside the local network
  
  
It's not a crazy backdoor like rootkit or smtg
 
I'm jst learning mahnn may be in the future.

BIG CONES OF PYSCH SSH

  - You need to run the script in the target physically and u need to know the **root password** of it (Basically I can do it) \_(o_o)_/ 
  - That's it

BASICALLY PYSCH SSH DOES

  - setup ssh auto when booting
  - configure ufw firewall
  - enable x11forwarding
  - changes the port


Next best thing i can say to you is **ONLY USE FOR EDUCATION PURPOSES** o_O

Remember we're not **Evils**. we respect sys around us


### How to Start
  1) Make it Executable
     ```chmod +x run.sh```
  2) Run the script using root privilege
     ```sudo ./run.sh```

     - If you encounter error of some kinda shit of characters( Windows-style carriage return characters), yeah (I did created the script in windows) use this to remove them
      ```sudo sed -i 's/\r$//' run.sh```
     
### Important
  if somtg goes wrong and you messed with the ssh configuration 

  Dw I gotcha <3, I have created a backup file of default configuration, use this to set to deafult
  ```cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config```

  

