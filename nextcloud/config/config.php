<?php
$CONFIG = array (
  'htaccess.RewriteBase' => '/',
  'memcache.local' => '\\OC\\Memcache\\APCu',
  'apps_paths' => 
  array (
    0 => 
    array (
      'path' => '/var/www/html/apps',
      'url' => '/apps',
      'writable' => false,
    ),
    1 => 
    array (
      'path' => '/var/www/html/custom_apps',
      'url' => '/custom_apps',
      'writable' => true,
    ),
  ),
  'memcache.distributed' => '\\OC\\Memcache\\Redis',
  'memcache.locking' => '\\OC\\Memcache\\Redis',
  'redis' => 
  array (
    'host' => 'redis',
    'password' => 'ed6f868221a182eb',
    'port' => 6379,
  ),
  'overwriteprotocol' => 'https',
  'overwritewebroot' => 'nextcloud',
  'passwordsalt' => '6gK2JQZboEQklkvqK0cNB41C45C0d6',
  'secret' => 'ToOhmQCp920icvV+SfUOvDvUyYNg/io6ZkYdFgAwTWB4H9qk',
  'trusted_domains' => 
  array (
    0 => 'localhost',
    1 => 'dev.labqs.ita.br',
    2 => 'ci.labqs.ita.br',
  ),
  'datadirectory' => '/var/www/html/data',
  'dbtype' => 'pgsql',
  'version' => '24.0.3.2',
  'overwrite.cli.url' => 'https://localhostnextcloud',
  'dbname' => 'nextcloud',
  'dbhost' => 'postgres',
  'dbport' => '',
  'dbtableprefix' => 'oc_',
  'dbuser' => 'nextcloud',
  'dbpassword' => 'e5478da866654a06',
  'installed' => true,
  'instanceid' => 'ochj9gld49p1',
  'mail_from_address' => 'labqs',
  'mail_smtpmode' => 'smtp',
  'mail_sendmailmode' => 'smtp',
  'mail_domain' => 'ita.br',
  'mail_smtpauthtype' => 'LOGIN',
  'mail_smtphost' => 'smtp.ita.br',
  'mail_smtpport' => '587',
  'mail_smtpauth' => 1,
  'mail_smtpname' => 'labqs@ita.br',
  'mail_smtppassword' => 'C0r0n@2022',
  'mail_smtpsecure' => 'tls',
  'objectstore' => [
    'class' => '\\OC\\Files\\ObjectStore\\S3',
    'arguments' => [
            'bucket' => 'nextcloud',
            'autocreate' => true,
            'key'    => 'YY79MESQLPD8SAC2KN5L',
            'secret' => '96bo7gRjpTdyy5IR34CrE1uFMQPUfGEqBk8nXAUr+7uRTVSj',
            'hostname' => 'st.test.labqs.ita.br',
            'use_ssl' => true,
            'use_path_style'=>true
    ],
],
);
