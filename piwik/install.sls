# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "piwik/map.jinja" import piwik with context %}

{%- if piwik.install_from_source %}
gnupg:
  pkg.installed

import_gpg_key:
  cmd.run:
    - name: gpg --recv-key {{ piwik.gpg_key_id }}
    - unless: gpg --list-key {{ piwik.gpg_key_id }}
    - require:
      - pkg: gnupg

download_source:
  cmd.run:
    - name: curl {{ piwik.url }} -o /tmp/piwik.zip
    - unless: test -d {{ piwik.install_dir }}

download_source_asc:
  cmd.run:
    - name: curl {{ piwik.asc_url }} -o /tmp/piwik.zip.asc
    - unless: test -d {{ piwik.install_dir }}

verify_source:
  cmd.run:
    - name: gpg --verify /tmp/piwik.zip.asc /tmp/piwik.zip
    - unless: test -d {{ piwik.install_dir }}
    - require:
      - cmd: import_gpg_key

{{ piwik.install_dir }}:
  file.directory:
    - user: {{ piwik.web_user }}
    - group: {{ piwik.web_user }}
    - dir_mode: 755

install_from_source:
  archive.extracted:
    - name: {{ piwik.install_dir }}
    - source: /tmp/piwik.zip
    - archive_format: zip
    - if_missing: {{ piwik.install_dir }}/index.php
    - require:
      - file: {{ piwik.install_dir }}
      - cmd: verify_source

update_ownership:
  file.directory:
    - name: {{ piwik.install_dir }}
    - user: {{ piwik.web_user }}
    - group: {{ piwik.web_user }}
    - recurse:
      - user
      - group
    - require:
      - archive: install_from_source
{%- else %}
piwik:
  pkg.installed:
    - name: {{ piwik.pkg }}
{%- endif %}
