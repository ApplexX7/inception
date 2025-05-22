<?php
// ** Database settings ** //
$db_user_password = file_get_contents('/run/secrets/db_user_password');
define( 'DB_NAME', "mariadb_database" );
define( 'DB_USER', "mohilali" );
define( 'DB_PASSWORD', trim($db_user_password) ); // trim() recommended to remove trailing newline
define( 'DB_HOST', 'mariadb:3306' );

// ** Redis settings ** //
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DISABLED', false );
define( 'WP_CACHE', true );

// Authentication Keys and Salts...
// (no changes needed here)

// Database Table prefix
$table_prefix = 'wp_';

// Debugging
define( 'WP_DEBUG', false );

// Absolute path
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

// Include wp-settings
require_once( ABSPATH . 'wp-settings.php' );

