# RPKI Invalid Routes

**Author**: carlos@lacnic.net AT Punta Cana, 20190506

## Goal

Find all routes visible in BGP which are currently being invalidated by RPKI ROAs and group them by:

- country
- org-id (LACNIC-specific)
- org name (more generic)

## Pipeline Description

El pipeline consta de 4 pasos y sería así:

```
generar el netdata.db (esto tiene su propio pipeline)
script: s0_get_netdatadb
salida: netdata-latest.db
generar la lista de prefijos invalidados
script: s1_invalid_prefixes
salida: s1_invalid_prefixes.csv
formato: Prefix|Status|OriginAS|ROAAS|ROAPrefix|MaxLen
agregarle a cada línea el org-id:
script: s2_enrich_with_orgid
salida: s2_enrich_with_orgid.csv
format: Prefix|Status|OriginAS|ROAAS|ROAPrefix|MaxLen|ORGID
agrupar listado por org ids y generar un segundo listado por org ids con número de anuncios invalidados
script: s3_group_by_orgid
```

## Publicación de resultados:

Los productos de este pipeline son:

*TBW

Están disponibles en:

*TBA

## Anexos

SQL útiles:

```
select orgid1,count(orgid1) as cnt from invalids group by orgid1 order by cnt asc;
```

```select orgid0,count(orgid0) as count, name,email1,email2 from invalids,registrados where orgid0=orgid group by orgid0 order by count asc;```


```
select orgid0,count,name,email1,email2 from (

select orgid0,count(orgid0) as count 

from invalids  group by orgid0 order by count asc),

registrados 

where orgid0=orgid group by orgid0 order by count asc;
```
