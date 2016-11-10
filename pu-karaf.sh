#!/bin/sh

# pu-karaf's version.
ver=1.0.1

# List of compatible Karaf versions.
compatibleKarafVersions=("4.0.0" "4.0.1" "4.0.2" "4.0.3" "4.0.4" "4.0.5" "4.0.6" "4.0.7")

# Some basic usage instruction.
read -r -d '' HELP << EOM
pu-karaf v$ver
Enhances Karaf's shell.init.script with additional aliases.

Usage:
	pu-karaf /a/path/to/karaf

The following aliases are added:
	- puk-lf		Lists failed bundles
	- puk-lg		List bundles with grep (e.g. puk-lg apache)
	- puk-fg		List feature with grep (e.g. puk-fg cxf)
	- puk-ds		List services providing datasources.
	- puk-dsf		List services providing datasource factories.
	- puk-ns		List handled namespaces.
	- puk-em		List Entity Managers (factories).

Do you have any suggestions?
Fork https://github.com/NMichas/pu-karaf and issue a PR.
EOM

#  Enhanced aliases.
read -r -d '' ALIASES << EOM
\n
// Enhanced by puk-karaf: https://github.com/NMichas/pu-karaf\n
puk-lg = { la | grep -i \$args } ;\n
puk-lf = { la | grep -i 'Failure\|Waiting\|GracePeriod' } ;\n
puk-fg = { feature:list | grep -i \$args } ;\n
puk-ds = { service:list javax.sql.DataSource } ;\n
puk-dsf = { service:list org.osgi.service.jdbc.DataSourceFactory } ;\n
puk-em = { service:list EntityManagerFactory } ;\n
puk-ns = { service:list |grep "osgi.service.blueprint.namespace" |sort } ;\n
EOM

# Show help if no args provided.
if [ $# -eq 0 ] 
	then
		echo "$HELP"
		exit 1
fi

# Check if provided arg is a Karaf installation.
if [ -f $1/etc/config.properties ] 
	then
		# Find Karaf's version.
		karafVersion=$(cat $1/etc/config.properties | sed -n 's/org.apache.karaf.version;version=\"\(.*\)\",\\/\1/p' | sed 's/ //g')
		# If Karaf's version is empty terminate.
		if [ -z $karafVersion ]
			then
				echo "Could not determine Karaf's version."
				exit 2
			else
				# Check if version found is supported.
				replace=0
				echo "Found Karaf version: $karafVersion"
				if [ $(echo ${compatibleKarafVersions[@]} | grep -o "$karafVersion" | wc -w) == 1 ]
					then
						replace=1
					else
						read -p "This version has not been checked for compatibility with this script. Proceed anyway (y/n)?" answer
						if [ "$answer" = 'y' ]
							then
						  		replace=1
						fi
				fi

				# Proceed enhancing aliases.
				if [ $replace == 1 ]
					then
						# Check if this Karaf has already been enhanced.
						if [ $(cat $1/etc/shell.init.script |grep -o "Enhanced by puk-karaf" |wc -w| sed 's/ //g') -gt 0 ]
							then
								echo "This Karaf is already enhanced by puk-karaf."
								exit 3
							else
								echo $ALIASES >> $1/etc/shell.init.script
								echo "New aliases have been successfully added. You need to restart your Karaf to use them."
						fi							
					else
						exit 4
				fi
		fi
		
	else	
		echo "Could not find a Karaf installation on: $1"
		exit 5
fi