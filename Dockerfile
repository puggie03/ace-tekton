#FROM cp.icr.io/cp/icp4i/ace/ibm-acecc-configurator-prod:11.0.0.8-r1-amd64
FROM ibmcom/ace:11.0.0.8-r1-amd64
# if using with Buildah in Tekton the ENV won't work
# ENV BAR1=Transformation_ESQL.bar

#RUN sed -i 's/dep-name/bmaprod/g' k8s/configmap.yaml

# Copy in the bar file to a temporary directory
#COPY --chown=aceuser ./ace/bar/$BAR1 /tmp
COPY --chown=aceuser ./ace/bar/*.bar /tmp
# DA switch to and from root if using Kaniko build - kaniko has a limitation - it needs to run as root
# USER root
# Unzip the BAR file; need to use bash to make the profile work
#RUN bash -c 'mqsibar -w /home/aceuser/ace-server -a /tmp/$BAR1 -c'
RUN bash -c 'mqsibar -w /home/aceuser/ace-server -a /tmp/*.bar -c'
#ADD /tmp/Transformation_ESQL.bar /home/aceuser/initial-config/bars/
#RUN bash -c 'mqsibar -a /tmp/Transformation_ESQL.bar -c -w /sis01Wrk'
# USER aceuser
# Switch off the admin REST API for the server run if required
RUN sed -i 's/adminRestApiPort/#adminRestApiPort/g' /home/aceuser/ace-server/server.conf.yaml 
#rename the deployment file

# We inherit the command from the base layer

# Expose ports
EXPOSE 7800
