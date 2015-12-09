FROM alisw/riemann-tools

RUN gem install riemann-dash
ADD config.rb /config.rb

CMD RIEMANN_DASH_CONFIG=/config.rb riemann-dash
