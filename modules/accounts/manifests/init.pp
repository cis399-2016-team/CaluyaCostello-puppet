class accounts {

$rootgroup = $osfamily ? {
	'Debian' => 'sudo',
	'RedHat' => 'wheel',
	default => warning('This distribution is not supported by the Accounts modeuls'),
}


	user { 'CaluyaCostello':
		ensure => present,
		home => '/home/CaluyaCostello',
		shell => '/bin/bash',
		managehome => true,
		gid => 'CaluyaCostello',
		groups => "$rootgroup",
		password => '$1$1IHhh/MKn$DGKKlQSrZsaAA6LvVXg/',
	}

	include groups
}
