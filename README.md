# MyOSCPexperience
My OSCP experience and advices

## About the process

Here is my process of the OSCP course and certification:

* October 26 - registered on the Offensive Security website to see the possible course start dates.
* October 28 - payed my fee ($800 for 30 days labtime) and got a place in the earlier available lab
* November 12 - start of my lab time- Received the pdf, videos and access to lab
* November 22 - scheduled my exam to December 18
* December 12 - end of my lab time
* December 18 - exam
* December 19 (afternoon) - submitted my exam report
* December 20 (evening) - got successful results e-mail

## Preparation before the exam

I have prepared by doing to following VMs (they are sorted from easy to hard). They are all available from vulnhub.com, some of them are linked here below:

1. LAMP security CTF7
2. LAMP security CTF4
3. LAMP security CTF5
4. Exploit KB Vulnerable Web App
5. VulnOSv2 https://www.vulnhub.com/entry/vulnos-2,147/
6. Kioptrix level 2 (1.1) https://www.vulnhub.com/entry/kioptrix-level-11-2,23/
7. pWnOS v2.0 https://www.vulnhub.com/entry/pwnos-20-pre-release,34/
8. Holynix v1 https://www.vulnhub.com/entry/holynix-v1,20/
9. pWnOS https://www.vulnhub.com/entry/pwnos-10,33/
10. Kioptrix level 3 (1.2)  https://www.vulnhub.com/entry/kioptrix-level-12-3,24/
11. Hackademic RTB1 https://www.vulnhub.com/entry/hackademic-rtb1,17/
12. LAMP security CTF6 https://www.vulnhub.com/entry/lampsecurity-ctf6,85/
13. Kioptrix Level 1
14. Metasploitable
15. Metasploitable 2
16. Kioptrix2014 (5)
17. Kioptrix level 4
18. SickOS 1.2
19. Acid: Server
20. No Exploiting Me
21. Sedna
22. Mr. Robot 1

Some of them are more esoteric than others, so if you are stuck, look up a walkthrough. Also keep in mind, that they usually have multiple entry points, while on OSCP there is usually one, clear solution. This also means, that even if you solve these machines, looking up some walkthroughs can still teach you something.

## Buffer overflow

On the exam you will have one buffer overflow machine for sure, usually very similar to the one on the pdf. For preparation I have also done this BoF exercise: http://justpentest.blogspot.hu/2015/07/minishare1.4.1-bufferoverflow.html (even though on my 64bit windows VM I have not found any library with no protection mechanism).

## Exam schedule

There are multiple strategies to schedule the 23:45 hour exam. I have started it at noon, so that I can sleep some after midnight and have a fresh start next morning. In the end I was lucky enough to have 75 points before midnight, so went to sleep and did the reporting next morning while still having access to the machines. I have submitted the report on that afternoon and got the results next day evening.

## The Exam

I have prepared a small script to run unicron scan on all TCP and UDP ports (massively parallel SYN scan), nmap -A on the resulted ports, nikto on the http(s) ports and enum4linux no matter what (since smb/samba is often an attack vector, it doesn't hurt to do some recon). My script is available in this repo. I have started with the buffer-overflow machine and the script was running meanwhile. Then it was faster to just review the scripts output and follow with the attack afterwards.
