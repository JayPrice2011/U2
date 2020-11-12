#!/bin/bash

set -exou pipefail

sudo yum update
sudo yum -y install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs
sudo service postgresql initdb
echo "local   all             all                                     		   trust" | sudo tee -a /var/lib/pgsql9/data/pg_hba.conf 
sudo service postgresql reload
sudo su - postgres
psql -U postgres
ALTER USER postgres WITH PASSWORD 'util';
CREATE USER app_user SUPERUSER; 
ALTER USER app_user WITH PASSWORD 'w@t3r';
CREATE DATABASE u2;
\q
exit   
echo "local   all             all                                     		   md5" | sudo tee -a /var/lib/pgsql/data/pg_hba.conf 
echo "host    all             all              0.0.0.0/0                       md5" | sudo tee -a /var/lib/pgsql/data/pg_hba.conf 
echo "host    all             all              ::/0                            md5" | sudo tee -a /var/lib/pgsql/data/pg_hba.conf 
echo "listen_addresses='*'" | sudo tee -a /var/lib/pgsql/data/postgresql.conf 
echo "port = 5432" | sudo tee -a /var/lib/pgsql/data/postgresql.conf 
sudo service postgresql reload
sudo systemctl enable postgresql || echo "postgresql could not be registeristed to start on start up"
sudo yum -y install firewalld
sudo systemctl start firewalld
sudo firewall-cmd --zone=public --add-port=5432/tcp --permanent
sudo firewall-cmd --reload


#hba config
        # # "local" is for Unix domain socket connections only
        # local   all             all                                     ident
        # # IPv4 local connections:
        # host    all             all             0.0.0.0/0               md5
        # host    all             all             ::/0                    md5
        # # IPv6 local connections:
        # host    all             all             ::1/128                 ident
        # # Allow replication connections from localhost, by a user with the
        # # replication privilege.
        # local   replication     all                                     peer
        # host    replication     all             127.0.0.1/32            ident
        # host    replication     all             ::1/128                 ident