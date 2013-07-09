class kubuntu {

  package { [
    "language-pack-kde-es",
    "kubuntu-restricted-addons", 
    "kubuntu-restricted-extras",
    "konversation",
    "yakuake",
    "quicksynergy",]:
    ensure => latest,
  }

  file { "/etc/apt/sources.list.d/partner.list":
    ensure  => present,
    source  => "puppet:///modules/kubuntu/partner.list",
    owner   => root,
    group   => root,
    before  => Package[skype],
  } ~>
  exec { '/usr/bin/apt-get update':
    refreshonly => true,
  } 

  package { skype:
    ensure => latest,
  }

}
