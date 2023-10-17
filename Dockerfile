FROM python:3.6-slim-stretch

#set TimeZone
ENV TZ="Europe/Berlin"

#setup Snips
RUN pip install urllib3==1.26.6
RUN pip install snips-nlu

#Download Languages
RUN python -m snips_nlu download-all-languages

#Copy Files for Snips
COPY files/cli/utils.py /usr/local/lib/python3.6/site-packages/snips_nlu/cli/utils.py

#Prepare for Downloading languages
RUN pip config set global.trusted-host "resources.snips.ai" --trusted-host=https://resources.snips.ai/

#Download entites
RUN python -m snips_nlu download-language-entities de
RUN python -m snips_nlu download-language-entities en

#setup Endpoints
RUN pip install fastapi
RUN pip install uvicorn