SELECT * FROM "TRP_VC" WHERE
  "NOM_RUE" <> '' AND ("TRP_CLAS_L" <> 'Chemin de fer' OR ("TRP_CLAS_L" <> 'Non codé' AND "TRP_CLAS_L" <> 'autre'))
