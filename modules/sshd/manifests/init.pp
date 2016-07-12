class sshd {
        package {
                "openssh-server": ensure => installed;
        }
	case $operatingsystem {
		'Ubuntu':{
			$key_user = "ubuntu"
			$service_name = "ssh"
			}
		'Amazon':{
			$key_user = "ec2-user"
			$service_name = "sshd"
			}
	}

        ssh_authorized_key { "costello-key-pair":
        user => $key_user,
	type => "ssh-rsa",
        key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCPrg48+84u65bZqmcD9yRJd2ILijuiZY7+iFVgQtXi3HH2s0Pc807oo20lD9fVvjzMFlAUluAQ8GGaLAzTY3bN2iGDzvhtCrI0O9r6u/60WKmYmryuVXunTz28IiISH04AQhNvS3B4mAXE5ZlOtBONao15bQO9ulnH1/LWjtOhh/+XeF4TjyvctM5z+hU5BzGmH7zcPm3Uz9+bnq9yVqSBJXt9HSVba0TEzuQv8MIkZnXJmaSdVtyOY7MVqNo91UCD0IfBqvapt7iUXApU0Zkwoi/ybojz2bcjrf8EPE8GJ4cI6wQ957GuqoD7P2G7vJuQpF3A0fDtzGIbHvn33SKZ"
        }

        ssh_authorized_key { "elijahcaluya_key_pair":
        user => $key_user,
	type => "ssh-rsa",
        key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCFr3mfY4/QWOsi2DowDDt9KoafoUFN2rdwEEK0Phq/jbhy8l397gIPxf4KWneIRydwX8hbTuLrk/9vbqOr4nL9joFGPql4h50+cM2awr0GFW17FqikYkPJSJ4VczNUzJIw8J9kTQEGZW31Ig0eKGCm1L1G0ARha+r3Zitk3Ed1W1RBT1wVfwokJVq3jzHTB8635tC1BQN0fGngKM21y5r4zSYio0+i/MbF+ObUbxrZvKwrejICEaj2FEZh6p/6ox1Oq+XiljT0qj6zt7l1HKT1O3P+xXxUYDms/fy2FCF/GNLmkep518PtEWGcAWkfJZQCc1ueECfY6KfMOre0r8jz"
	}	
        file { "/etc/ssh/sshd_config":
                source => ["puppet:///modules/sshd/$hostname/sshd_config",
			  "puppet:///modules/sshd/sshd_config",],
                mode => 444,
                owner => root,
                group => root,
                require => Package["openssh-server"],
        }
        service {$service_name:
                enable => true,
                ensure => running,
                require => [Package["openssh-server"],
                        File["/etc/ssh/sshd_config"],],
                subscribe => File["/etc/ssh/sshd_config"],
        }
}
