# pysch

Here you can view all the scripts and other files related to the hacks I have done.
We're just exploring the beauty of it. After we’re done, we will reset everything to default. 
You will also find a backup script that removes simple footprints and restores the system to normal. <3

## Pysch SSH
FIRST OFF ALL

  This isn’t as wild as it sounds. I built it to gain access to my campus machine so I could learn about Unix systems and stuff. * _ *
  I’ve made it so the firewall only gives a hoot about connections within the local network. No sneaky ninja moves here.
  
  
This isn’t some crazy rootkit or evil magic, jst an ssh
 
I'm jst learning mahnn may be in the future.

BIG CONES OF PYSCH SSH

  - You gotta run the script physically in the target machine and u need to know the **root password** of it (Basically I can do it) \_(o_o)_/ 
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

     - If you encounter error of some kinda shit of characters(thanks to Windows-style carriage returns), yeah (I did created the script in windows) use this to remove them
      ```sudo sed -i 's/\r$//' run.sh```
     
### Important
  if smtg goes wrong and you mess up with the ssh configuration 

  Dw I gotcha <3, I have created a backup file of default configuration, use this to set to deafult
  ```cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config```

  

