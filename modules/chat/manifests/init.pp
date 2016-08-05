class chat {
	
	package {
		"chat" :ensure => installed;
	}

	file {
		"/etc/chat/chat.cfg":
			source => ["puppet:///modules/chat/$hostname/chat.cfg",],
			mode => 444,
			owner => root,
			group => root,
			require => Package["chat"],
	}

	service {
		"chat":
			enable => true,
			ensure => running,
			hasstatus => true,
			hasrestart => true,
			require => [Package["chat"],File["/etc/chat/chat.cfg"]],
			subscribe => File["/etc/chat/chat.cfg"]
	}

}
