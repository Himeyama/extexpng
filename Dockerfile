FROM ubuntu:latest

RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install texlive-latex-base -y

COPY extexpng /root/extexpng

RUN apt install ruby -y
RUN apt install texlive-extra-utils poppler-utils poppler-data -y
