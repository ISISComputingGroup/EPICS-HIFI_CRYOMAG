#!../../bin/windows-x64/HIFI_CRYOMAG

## You may have to change HIFI_CRYOMAG to something else
## everywhere it appears in this file

# Increase this if you get <<TRUNCATED>> or discarded messages warnings in your errlog output
errlogInit2(65536, 256)

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/HIFI_CRYOMAG.dbd"
HIFI_CRYOMAG_registerRecordDeviceDriver pdbbase

##ISIS## Run IOC initialisation 
< $(IOCSTARTUP)/init.cmd

## Load record instances

##ISIS## Load common DB records 
< $(IOCSTARTUP)/dbload.cmd

lvDCOMConfigure("lvfp", "frontpanel", "$(TOP)/HIFI_CRYOMAGApp/protocol/HIFI_CRYO.xml", "$(LVDCOMHOST=localhost)", 6, "", "", "")
dbLoadRecords("$(TOP)/Db/HIFI_CRYOMAG.db","P=$(MYPVPREFIX)CRYO:")

## Load our record instances
#dbLoadRecords("db/xxx.db","user=kvlb23Host")

##ISIS## Stuff that needs to be done after all records are loaded but before iocInit is called 
< $(IOCSTARTUP)/preiocinit.cmd

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=kvlb23Host"

##ISIS## Stuff that needs to be done after iocInit is called e.g. sequence programs 
< $(IOCSTARTUP)/postiocinit.cmd
