# A Chassis extensions to add Php APC User Cache to your Chassis server
class apcu (
	$config,
	$path = '/vagrant/extensions/apcu'
) {

	if ( ! empty( $::config[disabled_extensions] ) and 'chassis/apcu' in $config[disabled_extensions] ) {
		$package = absent
	} else {
		$package = latest
	}

	$php = $config[php]

	if versioncmp( $php, '5.4') <= 0 {
		$php_package = 'php5'
	}
	else {
		$php_package = "php${$php}"
	}

	package { "${$php_package}-apcu":
		ensure  => $package,
		require => [ Package["${$php_package}-fpm"], Package["${php_package}-cli"] ],
		notify  => Service["${$php_package}-fpm"]
	}
}
