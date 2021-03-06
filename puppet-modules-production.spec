Name:		puppet-modules-production
Version:	1.0
Release:	4%{?dist}
Summary:	Production Puppet Modules

Group:		Applications/Engineering
License:	GPL
URL:		http://www.bit-sys.com
Source0:	%{name}-%{version}.tar.gz

Requires:	puppet-agent >= 5.0
Requires:   puppet-modules-forge

%define debug_package %{nil}
%define environment_path /etc/puppetlabs/code/environments/production

%description
Production Puppet Modules


%prep
%setup -q

%{__rm} *.spec
%{__rm} -fr .tito
%{__rm} LICENSE


%build


%install
%{__rm} -fr %{buildroot}
%{__mkdir_p} %{buildroot}/%{environment_path}

%{__mv} environment.conf environment.conf.real
%{__cp} -R * %{buildroot}/%{environment_path}/


%clean
%{__rm} -fr %{buildroot}


%post
# since we can't deliver this file in place
%{__mv} -f %{environment_path}/environment.conf.real %{environment_path}/environment.conf || :


%postun
if [ $1 -eq 0 ]; then
  %{__rm} -f %{environment_path}/environment.conf || :
fi


%files
%defattr(-,root,root,-)
%{environment_path}/environment.conf.real
%{environment_path}/manifests
%{environment_path}/modules


%changelog
* Sun Nov 26 2017 Marc Schweikert <schweikm@gmail.com> 1.0-4
- Fix erb error (schweikm@gmail.com)
- Use motd with custom template (schweikm@gmail.com)
* Sun Nov 26 2017 Marc Schweikert <schweikm@gmail.com> 1.0-3
- Finish rename of test_ntp (schweikm@gmail.com)
- Rename ntp to test_ntp to deconflict with forge (schweikm@gmail.com)
* Sun Nov 19 2017 Marc Schweikert <schweikm@gmail.com> 1.0-2
- Change to release tagger (schweikm@gmail.com)
- Remove license (schweikm@gmail.com)
- Fix spelling error (schweikm@gmail.com)
- Fix spec error (schweikm@gmail.com)
- Deliver environment.conf (schweikm@gmail.com)
* Sun Nov 12 2017 Marc Schweikert <schweikm@gmail.com> 1.0-1
- new package built with tito

