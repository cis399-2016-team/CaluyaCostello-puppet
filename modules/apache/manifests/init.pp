class apache {
	package { "apache2": ensure => installed;}
	file { "/etc/apache2/apache2.conf":
		source => ["puppet:///modules/apache/$hostname/apache2.conf",
				"puppet:///modules/apache/apache2.conf",],
		mode => 444,
		owner => root,
		group => root,
		require => Package["apache2"],
	}
	service { "apache2":
		enable => true,
		ensure => running,
		require => [Package["apache2"],File["/etc/apache2/apache2.conf"],],
		subscrube => [File["/etc/apache2/apache2.conf"],],
	}
}
