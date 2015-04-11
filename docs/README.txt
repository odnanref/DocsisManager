README
======

This directory should be used to place project specfic documentation including
but not limited to project notes, generated API/phpdoc documentation, or
manual files generated or hand written.  Ideally, this directory would remain
in your development environment only and should not be deployed with your
application to it's final production location.

===================
Details
===================

- see the INSTALL document for install details
- see keyword.config for keywords in CM_TEMPLATES
- cm_templates is the directory where Cable modem templates are stored
- gen directory is used for the generated templates
- configs directory holds the application.ini config details

====================
bin directory
====================
- getVendors.php get's information from the network CM's
- counter.php get's information from modems counter this is not fully developed and has issues
- gerar.pl generates config files for dhcp server

====================
brand.sql
===================
In this table you will configure the modem brand + model 
and the associated template file to use


Setting Up Your VHOST
=====================

The following is a sample VHOST you might want to consider for your project.

<VirtualHost *:80>
   DocumentRoot "/home/andref/workspace/docsismanager/public"
   ServerName docsismanager.local

   # This should be omitted in the production environment
   SetEnv APPLICATION_ENV development

   <Directory "/home/andref/workspace/docsismanager/public">
       Options Indexes MultiViews FollowSymLinks
       AllowOverride All
       Order allow,deny
       Allow from all
   </Directory>

</VirtualHost>
