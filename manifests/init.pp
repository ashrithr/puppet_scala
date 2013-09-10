# == Class: scala
#
# This class installs and manages scala
#
# === Parameters
#
# None
#
# === Variables
#
# Inherited from scala::params class
#
# === Requires
#
# scala::params
#
# === Sample Usage
#
# include scala
#
# === Authors
#
# Ashrith <ashrith@me.com>

class scala {

  require scala::params

  file {"$scala::params::scala_base":
    ensure  => "directory",
    owner   => "root",
    group   => "root",
    alias   => "scala-base"
  }

  file { "${scala::params::scala_base}/scala-${scala::params::scala_version}.tgz":
    mode    => 0644,
    owner   => root,
    group   => root,
    source  => "puppet:///modules/${module_name}/scala-${scala::params::scala_version}.tgz",
    alias   => "scala-source-tgz",
    before  => Exec["untar-scala"],
    require => File["scala-base"]
  }

  exec { "untar scala-${scala::params::scala_version}.tgz":
    command     => "/bin/tar -zxf scala-${scala::params::scala_version}.tgz",
    cwd         => "${scala::params::scala_base}",
    creates     => "${scala::params::scala_base}/scala-${scala::params::scala_version}",
    alias       => "untar-scala",
    refreshonly => true,
    subscribe   => File["scala-source-tgz"],
    before      => File["scala-app-dir"]
  }

  file { "${scala::params::scala_base}/scala-${scala::params::scala_version}":
    ensure  => "directory",
    mode    => 0644,
    owner   => root,
    group   => root,
    alias   => "scala-app-dir"
  }

  file { "/etc/profile.d/scala_home.sh":
    ensure  =>  present,
    content =>  template("scala/scala_home.sh.erb"),
    mode    => 0755,
    owner   => root,
    group   => root,
    require =>  File["scala-app-dir"],
  }
  
  #FIX: This causes scala to source every time
  exec { "source-scala":
    command   => "/etc/profile.d/scala_home.sh | sh",
    user      => 'root',
    group     => 'root',
    logoutput => 'true',
    onlyif    => '/usr/bin/test -z $SCALA_HOME',
    require   =>  File ["/etc/profile.d/scala_home.sh"],
  }
}