FROM ibmcom/ace:11.0.0.8-r1-amd64
# if using with Buildah in Tekton the ENV won't work
#ENV BAR1=Test.bar

# Copy in the bar file to a temporary directory
#COPY --chown=aceuser ./ace/bar/$BAR1 /tmp
COPY --chown=aceuser ./ace/bar/Test.bar /tmp
# DA switch to and from root if using Kaniko build - kaniko has a limitation - it needs to run as root
# USER root
# Unzip the BAR file; need to use bash to make the profile work
#RUN bash -c 'mqsibar -w /home/aceuser/ace-server -a /tmp/$BAR1 -c'
RUN bash -c 'mqsibar -w /home/aceuser/ace-server -a /tmp/Test.bar -c'
# USER aceuser
# Switch off the admin REST API for the server run if required
#DA RUN sed -i 's/adminRestApiPort/#adminRestApiPort/g' /home/aceuser/ace-server/server.conf.yaml 

# We inherit the command from the base layer

# Expose ports
EXPOSE 7800
