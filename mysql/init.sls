mysql:
  global:
    client-server:
      default_character_set: utf8

  clients:
    mysql:
      default_character_set: utf8
    mysqldump:
      default_character_set: utf8

  library:
    client:
      default_character_set: utf8

  server:
    # Use this account for database admin (defaults to root)
    # root_user: 'admin'
    # root_password: '' - to have root@localhost without password
    root_password: 'somepass'
    root_password_hash: '*13883BDDBE566ECECC0501CDE9B293303116521A'
    user: mysql
    # If you only manage the dbs and users and the server is on
    # another host
    #host: 123.123.123.123
    # my.cnf sections changes
    mysqld:
      # you can use either underscore or hyphen in param names
      bind-address: 0.0.0.0
      log_bin: /var/log/mariadb/mysql-bin.log
      port: 3307
      binlog_do_db: classicmodels
      auto_increment_increment: 5
    mysql:
      # my.cnf param that not require value
      no-auto-rehash: noarg_present

  salt_user:
    salt_user_name: 'salt'
    salt_user_password: 'someotherpass'
    grants:
      - 'all privileges'

  # Manage databases
  database:
    - classicmodels
  schema:
    classicmodels:
      load: True
      source: salt://mysql/files/classicmodels.schema

  # Manage users
  # you can get pillar for existing server using scripts/import_users.py script
  user:
    frank:
      password: 'somepass'
      host: localhost
      databases:
        - database: classicmodels
          grants: ['select', 'insert', 'update']
    nopassuser:
      password: ~
      host: localhost
      databases: []


  # Install MySQL headers
  dev:
    # Install dev package - defaults to False
    install: False

