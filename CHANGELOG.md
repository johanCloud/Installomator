## v0.5 - 2020-

- 


## v0.4.6 - 2020-10-25

- Alligned with version 0.4 from official Installomator
- Reenforced need of signature on downloaded file. If files do not have a signature, we will not accept automatic download and install
- xpath function added to handle differences with xpath between Catalina and Big Sur
- we will not be using Installomator to install unsigned packages or software. That will be handled manually.


## 0.4.5 - 2020-09-02
- Changed GitHub download so that returned file has to end with filetype.
- Logging using label as tag, and also with logger command (label as tag so that concurrent runnings of Installomator can be separated
- cleanupAndExit function writes exit code

