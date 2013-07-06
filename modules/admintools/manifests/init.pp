class admintools {
  package { [
    "htop",
    "acpitool",
    "powertop",]:
    ensure => present,
  }
}
