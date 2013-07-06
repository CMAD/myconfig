class ssd {

  file { "/etc/lvm/lvm.conf":
    source => "puppet:///modules/ssd/lvm.conf",
    owner  => root,
    group  => root,
    notify => Exec["rebuild_initrd"],
  } ->
  augeas { "ssd_noatime":
    changes => [
      'set /files/etc/fstab/*[file="/"]/opt[1] noatime',
    ],
  } ->
  augeas { "ssd_trim":
    changes => [
      'set /files/etc/crypttab/1/opt[1] luks',
      'set /files/etc/crypttab/1/opt[2] discard',    
    ],
  } ~>
  exec { "rebuild_initrd":
    refreshonly => true,
    command     => "/usr/sbin/update-initramfs/update-initramfs -u -k all",
  }

  file { "/etc/cron.weekly/2fstrim":
    source => "puppet:///modules/ssd/2fstrim",
    mode   => "+x",
    owner  => root,
    group  => root, 
  }

}
