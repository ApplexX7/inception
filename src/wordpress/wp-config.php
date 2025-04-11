<?php
/**
 * The base configuration for WordPress.
 *
 * The wp-config.php creation script uses this file during the installation.
 * You can copy this file to "wp-config.php" and fill in the values.
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */
// ** Database settings ** //
define( 'DB_NAME', "mariadb_database" ); // The name of your database
define( 'DB_USER', "mohilali" ); // Your MySQL username
define( 'DB_PASSWORD', "hilali123" ); // Your MySQL password
define( 'DB_HOST', 'mariadb:3306' ); // Database host (MariaDB container and port)

// ** Authentication unique keys and salts. ** //
// Generate these using the WordPress secret-key service: https://api.wordpress.org/secret-key/1.1/salt/
define('AUTH_KEY',         'Y?Q=Fd:*=];J(N$uTR8;HOUF(ur!NoOXYQ-|=@9@-R*jL#R)RWPbfTbPwl9#f`GY');
define('SECURE_AUTH_KEY',  '#L%&^?y-$$c8S.>N,P>c5z w:UNVU_|?Ut38];t>{g.M$XS,e]R+J;SZl?lz<XbO');
define('LOGGED_IN_KEY',    'o:`m|h7d>0ZW%zi&2!dxQl`Y+?.4--Q>;XpIdh.vI^{7*|/-d<HSvw;Q$vMyZ4Xc');
define('NONCE_KEY',        ']6xcj?~:J[R;sF!U(2Pg.17?,(gI7;; oOWKQQgb#>YB|WVWZC.]WKL.(-*x,$SW');
define('AUTH_SALT',        '-G-uyXpb*g9/$hzuX*y&+b/:;a68-1.L%- r_)[--*WZMU8V95H/uB]RdrnJDKUw');
define('SECURE_AUTH_SALT', '*dy{,GYyYU}1;##^N,9BH:KP2Pbo>e#:+PW*QGJCGa#X?3cX:c4xhUh9)K6@4v!f');
define('LOGGED_IN_SALT',   'yC}~#$@vf2d;^IkdN&P-{YrU+&OYq-P]~!_p380;Izv3Rmq,7+Hp~]pgN.)}A ;`');
define('NONCE_SALT',       '%6c<}4P tuEoVN,[>c4UA{$xI!`eC<^/?e`uWb[pA|yKU=^Pjz0@+to+}$YH.szR');
// ** Database Table prefix ** //
$table_prefix = 'wp_';  // You can change this if you want to have multiple installations in one database

// ** Debugging settings ** //
define( 'WP_DEBUG', false );  // Set to true for development or debugging

// ** Absolute path to the WordPress directory. ** //
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

// ** Sets up WordPress vars and included files. ** //
require_once( ABSPATH . 'wp-settings.php' );
