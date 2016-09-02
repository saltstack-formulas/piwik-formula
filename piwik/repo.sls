# -*- coding: utf-8 -*-
# vim: ft=sls
#
{% from "piwik/map.jinja" import piwik with context %}

{% if not piwik.install_from_source %}
{% if grains['os_family'] == 'Debian' %}
piwik-repo:
  pkgrepo.managed:
    - name: {{ piwik.pkg_repo }}
    - file: {{ piwik.repo_file }}
    - key_url: {{ piwik.key_url }}
    - gpgcheck: 1
    - require_in:
      - pkg: {{ piwik.pkg }}
{%- endif %}
{%- endif %}
