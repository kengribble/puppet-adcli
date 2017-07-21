# == Class: adcli::join
#
# Uses adcli to join to an Active Directory domain.
#
# See README.md for more details
#
class adcli::join (
  $ad_domain         = $adcli::ad_domain,
  $ad_join_username  = $adcli::ad_join_username,
  $ad_join_password  = $adcli::ad_join_password,
  $ad_join_realm     = $adcli::ad_join_realm,
  $ad_join_host_fqdn = $adcli::ad_join_host_fqdn,
) {
  if $ad_domain == undef {
    notify {'For Active Directory join to work you must specify the ad_domain parameter.':}
  }
  elsif $ad_join_username == undef {
    notify {'For Active Directory join to work you must specify the ad_join_username parameter.':}
  }
  elsif $ad_join_password == undef {
    notify {'For Active Directory join to work you must specify the ad_join_password parameter.':}
  }
  elsif $ad_join_realm == undef {
    notify {'For Active Directory join to work you must specify the ad_join_realm parameter.':}
  }
  elsif $ad_join_host_fqdn == undef {
    notify {'For Active Directory join to work you must specify the ad_join_host_fqdn parameter.':}
  }
  else {
    exec {'adcli_join':
            command   => "/bin/echo -n \'${ad_join_password}\' | /usr/sbin/adcli join --login-type user --login-user=\'${ad_join_username}\' --domain=\'${ad_domain}\' --domain-realm=\'${ad_join_realm}\' --host-fqdn=\'${ad_join_host_fqdn}\' --stdin-password --verbose",
      logoutput       => true,
      creates         => '/etc/krb5.keytab',
    }
  }
}
