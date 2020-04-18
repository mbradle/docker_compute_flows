FROM mbradle/docker_wn_user

ENV NAME VAR
ENV NAME OUT_DIR
ENV NAME OUT_FILE
ENV NAME HEADER_COPY_DIRECTORY

ARG WN_USER
ENV WN_USER=$WN_USER

WORKDIR /my-projects

RUN git -C ${WN_USER_TARGET} pull

RUN git clone https://mbradle@bitbucket.org/mbradle/analysis.git

WORKDIR /my-projects/analysis

COPY Dockerfile master.[h] /my-projects/analysis

RUN make compute_flows

CMD \
  if [ "$HEADER_COPY_DIRECTORY" ]; then \
    cp /my-projects/compute_flows/default/master.h ${HEADER_COPY_DIRECTORY}/master.h; \
  else \
    ./compute_flows $VAR;\
  fi
