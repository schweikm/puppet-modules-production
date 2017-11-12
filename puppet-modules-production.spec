Name:		puppet-modules-production
Version:	1.0
Release:	1%{?dist}
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

%build


%install
%{__rm} -fr %{buildroot}
%{__mkdir_p} %{buildroot}/%{environment_path}

%{__cp} -R * %{buildroot}/%{environment_path}/

%clean
%{__rm} -fr %{buildroot}


%files
%defattr(-,root,root,-)
%{environment_path}/*



%changelog

