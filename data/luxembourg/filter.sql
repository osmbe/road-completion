SELECT * FROM "TRP_VC"
WHERE 
    -- Exclude ways where "NOM_RUE" is empty
    "NOM_RUE" <> '' 
    -- Exclude ways where "TRP_CLAS_L" is 'Chemin de fer', 'Non codé', or 'autre'
    -- These are railroads or little paths.
    AND "TRP_CLAS_L" NOT IN ('Chemin de fer', 'Non codé', 'autre')
    -- Exclude rows where "shape_len" is equal to the lengths specified.
    -- These lengths have sub-atomic precision (10^-17 meters is smaller than the size of an atom!)
    -- and can therefore be used as convenient UIDs. Use these to filter razed roads.
    AND "shape_len" NOT IN (
        830.166626069713971,
        131.914105731793,
        113.935351615667,
        143.610383935929,
        298.383651161161,
        63.5874018965166
    )
