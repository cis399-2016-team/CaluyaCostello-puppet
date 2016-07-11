node 'ip-10-0-4-244' {

	cron { "puppet update":
		command => "cd /etc/puppet && git pull -q origin master",
		user => root,
		minute => "*/5",
	}
}

node 'ip-10-0-4-164' {
	include sshd
}

node 'ip-10-0-4-188' {
}

