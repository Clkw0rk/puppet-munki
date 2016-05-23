# Install munki
class munki::install {

  $munkitools_version = $munki::munkitools_version

  if ! defined(File["${::puppet_vardir}/packages"]) {
    file { "${::puppet_vardir}/packages":
      ensure => directory,
    }
  }

  file { "${::puppet_vardir}/packages/munkitools.pkg":
    ensure  => file,
    source  => "puppet:///modules/munki/munkitools-${munkitools_version}.pkg",
    mode    => '0644',
    backup  => false,
    require => File["${::puppet_vardir}/packages"],
  }
  
  if $munki_version == "Munki not installed" {
    package { "munkitools":
      ensure   => installed,
      provider => pkgdmg,
      source   => "${::puppet_vardir}/packages/munkitools.pkg",
      require  => File["${::puppet_vardir}/packages/munkitools.pkg"],
    }
  }

}