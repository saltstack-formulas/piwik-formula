piwik
=====

Salt formula to install Piwik

This formula will setup piwik and create an empty database and user
it will not set a webserver and do the initialisation of the piwik server.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available States
================

.. contents::
    :local:

``piwik``

Metastate to install piwik and database

``piwik.repo``
--------------

Creates the piwik repository (only debian)

``piwik.install``
-----------------

Installs the piwik package from distribution repo

``piwik.mysql``
---------------

Creates the piwik database and database user

``piwik.python-mysqldb``
------------------------

This is a requirement state for salt to create the mysql databases

Formula Depencies
=================

* php
* apache

or

* php.fpm
* nginx
