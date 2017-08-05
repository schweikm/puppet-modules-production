Name:		puppet-modules-squadx
Version:	1.0
Release:	1%{?dist}
Summary:	Production Puppet modules

Group:		Applications/Engineering
License:	GPL
URL:		http://www.bit-sys.com
Source0:	%{name}-%{version}.tar.gz

Requires:	puppet-agent >= 5.0
Requires:       puppet-modules-forge

%define debug_package %{nil}
%define module_path /etc/puppetlabs/code/environments/squadx

%description
Production Puppet modules


%prep
%setup -q


%build


%install
%{__rm} -fr %{buildroot}
%{__mkdir_p} %{buildroot}/%{module_path}

%{__cp} -R * %{buildroot}/%{module_path}/

%clean
%{__rm} -fr %{buildroot}


%files
%defattr(-,root,root,-)
%{module_path}/*



%changelog

