class profile::foreman (
  String $admin_password = 'admin',
){
  class { '::foreman':
    admin_password => $admin_password
  }
}