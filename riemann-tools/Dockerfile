FROM ruby:2.6

RUN gem install riemann-tools
ADD run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD [ ]
