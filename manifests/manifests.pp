file { "/etc/passwd":
      owner => "root",
      group => "root",
      mode  => "0644",
    }

# install git
package { "git":
  ensure=> installed;
}

#install packages for node.js
$nodePackages = [ "openssl-devel", "gcc-c++" ]
package { $nodePackages:
  ensure=> installed;
}

exec {
  "add_epel_6-8":
  command => "/bin/su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm'";
  # command => "/bin/su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'";

  "yum_install_nodejs":
  cwd => "/opt",
  command => "/usr/bin/yum -y install nodejs",
  require => [  Exec["add_epel_6-8"] ];

  "yum_install_npm":
  cwd => "/opt",
  command => "/usr/bin/yum -y install npm",
  require => [  Exec["yum_install_nodejs"] ];
}



#exec {
#  "create_tempFolder":
#    command => "/bin/mkdir /tmp/sources",
#    require => [Package[ $nodePackages ]];
#
#  "fetch_nodejs":
#    cwd => "/tmp/sources",
#    command => "/usr/bin/wget http://nodejs.org/dist/node-latest.tar.gz",
#    require => [ Exec["create_tempFolder"]];
#
#  "unzip_nodejs":
#    cwd => "/tmp/sources",
#    command => "/bin/tar -zxvf /tmp/sources/node-latest.tar.gz",
#    require => [  Exec["fetch_nodejs"] ];
#
#  "config_nodejs":
#    command => "/tmp/sources/node-v0.10.8/configure",
#    require => [ Exec[ "unzip_nodejs" ]];
#
#  "make_nodejs":
#    cwd => "/tmp/sources/node-v0.10.8",
#    command => "/usr/bin/make",
#    require => [ Exec["config_nodejs"]];
#
#  "install_nodejs":
#    cwd => "/tmp/sources/node-v0.10.8",
#    command => "/usr/bin/make install",
#    require => [ Exec["make_nodejs"]];
#
#  "move_nodejs":
#    command => "/bin/mv /tmp/sources/node-v0.10.8/out/Release /opt/node-v0.10.8",
#    require => [ Exec["install_nodejs"]];
#
#  "ln_nodejs":
#    command => "/bin/ln -s /opt/node-v0.10.8/node /usr/bin/node",
#    require => [ Exec["move_nodejs"]];
#}

exec {
#  "create_RepoFolder":
#    command => "/bin/mkdir /opt/widget-the-people",
#    require => [Exec[ "yum_install_nodejs" ]];

  "fetch_repo":
    cwd => "/opt",
    command => "/usr/bin/git clone https://github.com/douglasback/widget-the-people.git",
    require => [Exec["yum_install_npm"]];

  "whoami":
    cwd => "/opt/widget-the-people",
    command => "/usr/bin/whoami > /vagrant/whoami",
    require => [Exec["fetch_repo"]];

  "install_app":
    cwd => "/opt/widget-the-people",
    command => "/usr/bin/sudo /usr/bin/npm install",
    require => [Exec["whoami"]];

  "run_app":
    cwd => "/opt/widget-the-people",
    command => "/usr/bin/node app.js&",
    require => [Exec["install_app"]];
}
#
## disable pesky iptables. ick security!
exec { "disable_iptable":
  command => "iptables save",
  path => "/etc/init.d/",
}

exec { "disable_iptable1":
  command => "iptables stop",
  path => "/etc/init.d/",
}

exec { "disable_iptable2":
  command => "chkconfig iptables off",
  path => "/sbin/",
}

exec {"disable_iptable3":
  command => "/sbin/service iptables stop"
}
