# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "piwik/map.jinja" import piwik with context %}

include:
  - piwik.python-mysqldb

mysql-requirements:
  pkg.installed:
    - pkgs:
      - mysql-server
      - mysql-client
    - require_in:
      - service: mysql
      - mysql_user: piwik

mysql:
  service.running:
    - watch:
      - pkg: mysql-requirements

piwik_db_user:
  mysql_user.present:
    - name: {{ piwik.db_user }}
    - host: {{ piwik.db_host }}
    - password: {{ piwik.db_passwd }}
    - require:
      - pkg: python-mysqldb
      - pkg: mysql-requirements
      - service: mysql

piwik_db:
  mysql_database.present:
    - name: {{ piwik.db_name }}
    - require:
      - mysql_user: {{ piwik.db_user }}
      - pkg: python-mysqldb
  mysql_grants.present:
    - grant: SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES
    - database: {{ piwik.db_name }}.*
    - host: {{ piwik.db_host }}
    - user: {{ piwik.db_user }}
    - require:
      - mysql_database: {{ piwik.db_name }}
      - pkg: python-mysqldb
      - service: mysql

