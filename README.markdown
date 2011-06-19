Project goal
============

This project is aimed at creating a mailing list server based on Exim, PHP and MySQL.

Usage
=====

Since this project modifies the Exim configuration to an extent, that it isn't usable as a standard mail server any
more, it is recommended to run it in a separate instance on a separate address.

Since only one database is used in MySQL, it can be safely hosted on a multi-tennant server.

The PHP part can be run on any webserver, but the application needs access to the mailing list servers' port 25 to
re-submit messages held for moderation. Also, a PHP CLI must be installed, so that Exim can submit messages for
moderation.