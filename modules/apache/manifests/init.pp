class apache {
	package { "apache2": ensure => installed;}
	file { "/etc/apache2/apache2.conf":
		source => ["puppet:///modules/apache/$hostname/apache2.conf",
				"puppet:///modules/apache/apache2.conf",],
		mode => 444,
		owner => root,
		group => root,
		require => Package["apache2"]
	}
	file { '/var/www/html/jabberhelp.html':
		source => 'puppet:///modules/apache/jabberhelp.html',
		mode => 644,
		owner => root,
		group => root,
		require => Package['apache2'],
		}
	file { '/var/www/html/pidginhelp.html':
		source => 'puppet:///modules/apache/pidginhelp.html',
		mode => 644,
		owner => root,
		group => root,
		require => Package['apache2'],
		}
	file { '/var/www/html/coccinellahelp.html':
		source => 'puppet:///modules/apache/coccinella.html',
		mode => 644,
		owner => root,
		group => root,
		require => Package['apache2'],
		}
	file { '/var/www/html/foo.html':
		source => 'puppet:///modules/apache/foo.html',
		mode => 644,
		owner => root,
		group => root,
		require => Package['apache2'],
		}
	file {"/var/www/html":
	     	ensure  => directory,
	        recurse => true,
		purge   => true,
		source  => "puppet:///modules/apache",
		 }
	service { "apache2":
		enable => true,
		ensure => running,
		require => [Package["apache2"],
				File["/etc/apache2/apache2.conf"],
				File['/var/www/html/foo.html']],
		subscribe => [File["/etc/apache2/apache2.conf"],]
	}
}
