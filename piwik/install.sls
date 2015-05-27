# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "piwik/map.jinja" import piwik with context %}

piwik:
  pkg.installed:
    - name: {{ piwik.pkg }}

