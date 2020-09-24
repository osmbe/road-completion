SELECT * FROM "Wegsegment" WHERE
  "STATUS" = 4
  AND ("LSTRNM" <> '' OR "RSTRNM" <> '')
  AND "BEHEER" = '42006'