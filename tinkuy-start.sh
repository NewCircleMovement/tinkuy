#!/usr/bin/env bash

/etc/init.d/postgresql start
/etc/init.d/ssh start

su - -c 'createdb --echo tinkuy_development' postgres

su - -c 'createuser --echo -s -r u6lu2kduj14b3u' postgres

# Create role root just for running rake db:migrate
su - -c 'createuser --echo -s -r root' postgres
xzcat /root/tinkuy/test2/sample-db.pgsql.xz | psql tinkuy_development
rake db:migrate RAILS_ENV=development

rails server -b '0.0.0.0'


bash
