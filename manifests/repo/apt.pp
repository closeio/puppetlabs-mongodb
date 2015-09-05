# PRIVATE CLASS: do not use directly
class mongodb::repo::apt inherits mongodb::repo {
  # we try to follow/reproduce the instruction
  # from http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/

  include ::apt

  if (versioncmp($version, '3.0.0') >= 0) {
    $release = "precise/mongodb-org/3.0"
    $repos = "multiverse"
  } else {
    $release = "dist"
    $repos = "10gen"
  }

  if($::mongodb::repo::ensure == 'present' or $::mongodb::repo::ensure == true) {
    apt::source { 'downloads-distro.mongodb.org':
      location    => $::mongodb::repo::location,
      release     => $release,
      repos       => $repos,
      key         => '492EAFE8CD016A07919F1D2B9ECBEC467F0CEB10',
      key_server  => 'hkp://keyserver.ubuntu.com:80',
      include_src => false,
    }

    Apt::Source['downloads-distro.mongodb.org']->Package<|tag == 'mongodb'|>
  }
  else {
    apt::source { 'downloads-distro.mongodb.org':
      ensure => absent,
    }
  }
}
