# pu-karaf
Enhances Karaf's shell.init.script with additional aliases.

Usage:  
`pu-karaf /a/path/to/karaf`

The following aliases are added:  

- `lf` Lists failed bundles
- `lg` List bundles with grep (e.g. `lg apache`)
- `fg` List feature with grep (e.g. `fg cxf`)
- `ds` List services providing datasources.
- `dsf` List services providing datasource factories.
- `ns` List handled namespaces.
- `em` List Entity Managers (factories).

Do you have suggestions?  
Fork https://github.com/NMichas/pu-karaf and issue a PR.
