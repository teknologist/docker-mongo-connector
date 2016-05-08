#This will prepare a elasticsearch node with mongo-connector enabled

FROM python:3.5
MAINTAINER teknologist@gmail.com

ENV DEBIAN_FRONTEND noninteractive
ENV TZ UTC

# Installing Mongo Connector which will connect MongoDB and Elasticsearch
#RUN pip install mongo-connector==2.1
RUN git clone https://github.com/algolia/mongo-connector.git && \
git checkout algolia && \
cd mongo-connector && \
python setup.py install

COPY startup.sh /tmp/

COPY mongo /usr/bin/
RUN chmod a+x /usr/bin/mongo

VOLUME /data


# Sample usage when no commands is given outside
CMD ["/bin/bash", "/tmp/startup.sh"]
