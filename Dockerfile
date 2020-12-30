FROM registry.access.redhat.com/ubi8/ubi-minimal as SRC                         
                                                                                
ARG OPENHAB_SRC=https://bintray.com/openhab/mvn/download_file?file_path=org%2Fopenhab%2Fdistro%2Fopenhab%2F3.0.0%2Fopenhab-3.0.0.zip                            
                                                                                
RUN microdnf install --nodocs wget unzip tar gzip shadow-utils                  
RUN wget -O /tmp/openhab-download.zip ${OPENHAB_SRC}                            
RUN mkdir -p /opt/openhab                                                       
RUN unzip /tmp/openhab-download.zip -d /opt/openhab                             
RUN tar cafv /tmp/openhab.tar.gz -C /opt/ openhab/                              
                                                                                
                                                                                
                                                                                
                                                                                
FROM registry.access.redhat.com/ubi8/ubi-minimal                                
                                                                                
COPY --from=SRC /tmp/openhab.tar.gz /tmp/openhab.tar.gz                         
COPY start.sh /usr/local/sbin/start.sh                                          
                                                                                
RUN microdnf install --nodocs java-11-openjdk-headless shadow-utils tar sudo \  
 && adduser --no-create-home --user-group openhab \                             
 && mkdir -p /opt/openhab \                                                     
 && chown openhab:openhab -R /opt/openhab \                                     
 && chmod +x /usr/local/sbin/start.sh                                           
                                                                                
EXPOSE 8080                                                                     
WORKDIR /opt/openhab                                                            
VOLUME ["/opt/openhab"]                                                         
USER openhab                                                                    
                                                                                
ENTRYPOINT ["/usr/local/sbin/start.sh"]                                         
CMD ["/opt/openhab/start.sh"]
