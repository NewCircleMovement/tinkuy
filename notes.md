# Original ruby README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version
- System dependencies
- Configuration
- Database creation
- Database initialization
- How to run the test suite
- Services (job queues, cache servers, search engines, etc.)
- Deployment instructions
- ...


# rails-code.txt

(just moved this from codedoc into readme)

  git push heroku master --force
  
  heroku run rake db:migrate
  
  git add -A
  git push
  git commit -m "message" 
  
  git status


... brug git bash!

# Dumping the database from heroku

    heroku pg:backups capture --remote production --app tinkuy
    heroku pg:backups public-url  --remote production --app tinkuy

Download the dump, and convert to sql-text through `pg_restore`
