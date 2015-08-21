#This will prepare a elasticsearch node with mongo-connector enabled

FROM python:3.4.3
MAINTAINER yeasy@github

ENV DEBIAN_FRONTEND noninteractive
ENV TZ Asia/Shanghai

# Installing Mongo Connector which will connect MongoDB and Elasticsearch
RUN pip install mongo-connector==2.1

COPY startup.sh /tmp/

COPY mongo /usr/bin/
RUN chmod a+x /usr/bin/mongo

VOLUME /data

RUN echo "["Collection(Database(MongoClient('mongo', 27017), 'local'), 'oplog.rs')", 6185434045103472641]" > /data/oplog.ts

# Sample usage when no commands is given outside
CMD ["/bin/bash", "/tmp/startup.sh"]

