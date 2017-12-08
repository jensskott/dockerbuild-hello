FROM docker-gobuild

ARG project_name
ARG project_owner=Accedo-Products
ARG cmd='make all'
ENV SOURCE_PATH=/work/src/github.com/${project_owner}/${project_name}
ENV GOPATH=/work 
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# Create a output volume
VOLUME [ "/app" ]

# Make source path for golang
RUN mkdir -p ${SOURCE_PATH}
WORKDIR ${SOURCE_PATH}

# Add sources to workdir
ADD . .

RUN ${cmd}
