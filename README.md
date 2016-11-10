# pu-karaf
Enhances Karaf's shell.init.script with additional aliases.

Usage:
	`pu-karaf /a/path/to/karaf`

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