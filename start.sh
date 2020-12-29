#! /usr/bin/env bash                                                            
                                                                                
## Copy openHAB content to working dir, if empty                                
if [ -z "$(ls -A /opt/openhab)" ]; then                                         
  echo "Copy openHAB content to working directory..."                           
  tar xafv /tmp/openhab.tar.gz -C /opt/openhab                                  
else                                                                            
  echo "Use existing data at openHAB working dir..."                            
fi                                                                              
                                                                                
##                                                                              
echo "Try to run: $@ "                                                          
                                                                                
## Start openHAB instance                                                       
exec $@
