# add support for stdlib stages
stage { 'first': } -> Stage['main'] -> stage { 'last': }

# this is how it all works:
# node -> role -> profiles -> classes -> resources -> implementation
$role = lookup('role', String)

if $role =~ String and !empty($role) {
  include "::role::${role}"
} elsif $role =~ Array or $role =~ Hash {
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
