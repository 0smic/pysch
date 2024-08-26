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
  #### RUN
  1) Make it Executable
     ```chmod +x run.sh```
  2) Run the script using root privilege
     ```sudo ./run.sh```

     - If you encounter error of some kinda shit of characters(thanks to Windows-style carriage returns), yeah (I did created the script in windows) use this to remove them
      ```sudo sed -i 's/\r$//' run.sh```

  #### PYTHON SERVER SETUP
  It's not directly related to ssh. Some of them need this. yeah i need this.
  cause I can't take any external laptop or devices in the campus computer lab.
  so i setup http server in the boot file of a laptop in the campus lab.
  so whenever I'm in the lab and using another computer i can retrieve and store necessary details like usernames and password file of ssh.
  so i can bruteforce ssh of all other devices in the lab. so that's it
  that's a lot 'so' in it.
  1) Make it Executable
     ```chmod +x python_server_setup.sh```
     
  2) Run the script using root privilege
     ```sudo ./python_server_setup.sh```
       - maybe you need this ```sudo sed -i 's/\r$//' python_server_setup.sh```
### Important

I did hard code the port changing mechanism. so u need to change the port in code not the var
  if smtg goes wrong and you mess up with the ssh configuration 

  Dw I gotcha <3, I have created a backup file of default configuration, use this to set to deafult
  ```cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config```

  

