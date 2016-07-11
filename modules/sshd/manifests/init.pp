class sshd {
        package {
                "openssh-server": ensure => installed;
        }
        ssh_authorized_key { "costello-key-pair":
        user => "ubuntu",
	type => "ssh-rsa",
        key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCPrg48+84u65bZqmcD9yRJd2ILijuiZY7+iFVgQtXi3HH2s0Pc807oo20lD9fVvjzMFlAUluAQ8GGaLAzTY3bN2iGDzvhtCrI0O9r6u/60WKmYmryuVXunTz28IiISH04AQhNvS3B4mAXE5ZlOtBONao15bQO9ulnH1/LWjtOhh/+XeF4TjyvctM5z+hU5BzGmH7zcPm3Uz9+bnq9yVqSBJXt9HSVba0TEzuQv8MIkZnXJmaSdVtyOY7MVqNo91UCD0IfBqvapt7iUXApU0Zkwoi/ybojz2bcjrf8EPE8GJ4cI6wQ957GuqoD7P2G7vJuQpF3A0fDtzGIbHvn33SKZ"
        }

        ssh_authorized_key { "elijahcaluya_key_pair":
        user => "ubuntu",
	type => "ssh-rsa",
        key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDkMbAYCfE6FHg4s4HJXlXZmMtWzuqWFUQSVLIs8y/dAu6FVkfbfF4Dts2TrmV9vQmjSARjFtzqTdRnvW9IdcamwMJCbCgMTG/DSdmYvSQgl1S7TBmF+9hiJbK88vAFcZxqbsJ8hZb3EpIjd8uiZHEJyYzlSc3hAc5qiUv0j1OtPFcGtpOuekgRuxoZ0ZCPXEFbk4ToteO6UGLd3D3qHWvDt1svFaoTFSA/s6yO8UM+TnELQkaU6Hpb8zUebmLLDFL2B5ZDpzjS5Lb5lznM9FF/BaFjEyF4IXJUy77Rm+88deWqXhf2JFWCz4l+fx05469uUtMR4l3ZF6eveouU7sHF"
	}	
        file { "/etc/ssh/sshd_config":
                source => ["puppet:///modules/sshd/$hostname/sshd_config",
			  "puppet:///modules/sshd/sshd_config",],
                mode => 444,
                owner => root,
                group => root,
                require => Package["openssh-server"],
        }
        service {"ssh":
                enable => true,
                ensure => running,
                require => [Package["openssh-server"],
                        File["/etc/ssh/sshd_config"],],
                subscribe => File["/etc/ssh/sshd_config"],
        }
}
