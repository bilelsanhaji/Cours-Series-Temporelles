# Met en cache les séries provenant d'API externes
# Économétrie des séries temporelles — M1 MBFA
#
# POURQUOI
#
# Trois graphiques du cours viennent d'API : le chômage américain (FRED), le
# Dow Jones et la parité GBP/USD (Yahoo Finance). Tant qu'ils étaient appelés
# au moment du rendu, compiler un chapitre exigeait une connexion, une clé FRED
# valide, et la bonne volonté de Yahoo — dont l'interface casse régulièrement.
# Les chiffres changeaient en plus d'un rendu à l'autre.
#
# Ce script télécharge les trois séries UNE FOIS et les écrit dans 04-Data/.
# Les chapitres lisent ensuite ces fichiers : ils compilent hors ligne, sans
# clé, et donnent toujours les mêmes graphiques.
#
# QUAND LE RELANCER
#
# Une fois par an avant la rentrée, pour rafraîchir les séries. Jamais pendant
# le semestre : vos slides doivent rester stables une fois distribuées.
#
# USAGE, depuis la racine du dépôt
#
#     source("04-Data/mettre-a-jour-donnees-externes.R")
#
# Il faut une clé FRED personnelle, gratuite, dans ~/.Renviron :
#
#     FRED_API_KEY=votre_cle
#
# Redémarrer R après avoir créé ce fichier. Une clé ne se met jamais dans un
# fichier du projet.
#
# Ce script documente la provenance des séries de 04-Data/ : vous n'avez pas
# besoin de le lancer, les données sont déjà là.

library(fredr)
library(quantmod)

cle <- Sys.getenv("FRED_API_KEY")
if (!nzchar(cle)) {
  stop("FRED_API_KEY absente.\n",
       "  Créez ~/.Renviron avec la ligne  FRED_API_KEY=votre_cle\n",
       "  puis redémarrez R. Clé gratuite : https://fredaccount.stlouisfed.org/apikeys")
}
fredr_set_key(cle)

ecrire <- function(d, nom) {
  f <- file.path("04-Data", paste0(nom, ".csv"))
  write.csv(d, f, row.names = FALSE)
  message(sprintf("  %-22s %5d observations, %s -> %s",
                  nom, nrow(d), format(min(d$date)), format(max(d$date))))
}

# --- Séries FRED (chapitre 1, TP3, TP4, TP5) ---------------------------------
#
#   UNRATE     chômage américain, mensuel      chapitre 1, TP3
#   GDPC1      PIB réel, trimestriel           TP4
#   PCECC96    consommation réelle             TP5  (le « c » de cay)
#   TNWBSHNO   richesse nette des ménages      TP5  (le « a » de cay)
#   DPIC96     revenu disponible réel          TP5  (le « y » de cay)

series <- list(
  FRED_UNRATE   = list(id = "UNRATE",   debut = "1948-01-01"),
  FRED_GDPC1    = list(id = "GDPC1",    debut = "1947-01-01"),
  FRED_PCECC96  = list(id = "PCECC96",  debut = "1947-01-01"),
  FRED_TNWBSHNO = list(id = "TNWBSHNO", debut = "1952-01-01"),
  FRED_DPIC96   = list(id = "DPIC96",   debut = "1947-01-01")
)

for (nom in names(series)) {
  s <- series[[nom]]
  d <- try(fredr(series_id = s$id,
                 observation_start = as.Date(s$debut),
                 observation_end   = Sys.Date()), silent = TRUE)
  if (inherits(d, "try-error")) { warning("échec pour ", s$id); next }
  d <- d[!is.na(d$value), ]
  ecrire(data.frame(date = d$date, value = d$value), nom)
}

# --- Dow Jones, Yahoo Finance (chapitre 1) -----------------------------------
dji <- getSymbols("^DJI", src = "yahoo", from = "2004-01-01",
                  to = "2014-01-01", auto.assign = FALSE)
ecrire(data.frame(date = as.Date(index(dji)),
                  close = as.numeric(Cl(dji))), "YAHOO_DJI")

# --- Parité GBP/USD, Yahoo Finance (chapitre 3) ------------------------------
gbp <- getSymbols("GBP=X", src = "yahoo", from = "2004-12-01",
                  to = "2024-12-01", auto.assign = FALSE)
gbp <- gbp[!is.na(Cl(gbp)), ]
ecrire(data.frame(date = as.Date(index(gbp)),
                  close = as.numeric(Cl(gbp))), "YAHOO_GBPUSD")

# --- Or, cours quotidien 2005, Yahoo Finance (TP3) ---------------------------
# Le ticker à terme 'GC=F' remonte mal les années anciennes selon les jours.
# On tente d'abord le contrat à terme, puis l'ETF GLD en repli.
or <- try(getSymbols("GC=F", src = "yahoo", from = "2005-01-01",
                     to = "2005-12-31", auto.assign = FALSE), silent = TRUE)
if (inherits(or, "try-error") || nrow(or) < 100) {
  message("  GC=F indisponible ou trop lacunaire, repli sur l'ETF GLD")
  or <- getSymbols("GLD", src = "yahoo", from = "2005-01-01",
                   to = "2005-12-31", auto.assign = FALSE)
}
or <- or[!is.na(Cl(or)), ]
ecrire(data.frame(date = as.Date(index(or)),
                  close = as.numeric(Cl(or))), "YAHOO_GOLD_2005")

message("\nCache à jour. Les chapitres et les TP compilent désormais sans réseau.")
