class ejabberd {
	
	package {
		"ejabberd" :ensure => installed;
	}

	file {
		"/etc/ejabberd/ejabberd.cfg":
			source => ["puppet:///modules/ejabberd/$hostname/ejabberd.cfg",],
			mode => 444,
			owner => root,
			group => root,
			require => Package["ejabberd"],
	}

	service {
		"ejabberd":
			enable => true,
			ensure => running,
			hasstatus => true,
			hasrestart => true,
			require => [Package["ejabberd"],File["/etc/ejabberd/ejabberd.cfg"]],
			subscribe => File["/etc/ejabberd/ejabberd.cfg"]
	}

}
