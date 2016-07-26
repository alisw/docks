FROM google/nodejs

RUN npm install -g hubot coffee-script yo generator-hubot
RUN mkdir alihubot && cd alibot &&                              \
    yo hubot --owner="ALICE Builder <alibuild@cern.ch>"         \
             --name="alibot"                                    \
             --description="ALICE Hubot"                        \
             --adapter="Slack"                                  \
             --defaults

RUN npm install hubot-slack
CMD ["./bin/hubot", "--adapter", "slack"]

