# add support for stdlib stages
stage { 'first': } -> Stage['main'] -> stage { 'last': }

# this is how it all works:
# node -> role -> profiles -> classes -> resources -> implementation
$role = hiera('role', '')

if is_string($role) and $role != '' {
  $profiles = hiera_array($profiles, [])

  if size($profiles) == 0 {
    fail("No profiles defined for role: ${role}")
  } elsif !member($profiles, 'profiles::core') {
    fail("profiles::core is not assigned in role ${role}")
  }

  hiera_include($profiles)
} elsif is_array($role) or is_hash($role) {
  fail('A node can only have ONE role assigned')
} else {
  fail('No role is defined')
}

# allow virtual packages
if versioncmp($facts['puppetversion'], '3.6.1') >= 0 {
  Package {
    allow_virtual => true,
  }
}
