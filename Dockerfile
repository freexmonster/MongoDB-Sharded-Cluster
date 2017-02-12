FROM mongo

ADD init.sh /init.sh

CMD ["bash", "/init.sh"]