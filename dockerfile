
# syntax=docker/dockerfile:1

FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /toypo-api-kadai-app-latest
COPY Gemfile /toypo-api-kadai-app-latest/Gemfile
COPY Gemfile.lock /toypo-api-kadai-app-latest/Gemfile.lock
RUN bundle install
#COPY ../compose /toypo_api_kadai_app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]