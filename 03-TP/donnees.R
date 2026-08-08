# Chargement des séries du cours — corrigés R
# Économétrie des séries temporelles — M1 MBFA
#
# Les chemins sont relatifs à la racine du dépôt (execute-dir: project).
# Si un fichier local manque, on bascule automatiquement sur l'URL GitHub :
# les corrigés fonctionnent donc aussi sur Posit Cloud sans clone.

BASE_URL <- paste0("https://raw.githubusercontent.com/bilelsanhaji/",
                   "Cours-Series-Temporelles/refs/heads/main/04-Data/")

.source_donnees <- function(fichier, sous_dossier = "") {
  local <- file.path("04-Data", sous_dossier, fichier)
  if (file.exists(local)) local else paste0(BASE_URL, sous_dossier,
                                            if (nzchar(sous_dossier)) "/" else "", fichier)
}

# Insolation mensuelle Météo-France : renvoie date / valeur
lire_insolation <- function(fichier = "SH_MIN006088001.csv", sous_dossier = "") {
  d <- read.table(.source_donnees(fichier, sous_dossier), sep = ";", header = TRUE,
                  comment.char = "#", stringsAsFactors = FALSE)
  d <- d[!is.na(suppressWarnings(as.numeric(d$VALEUR))), ]
  data.frame(date   = as.Date(paste0(d$YYYYMM, "01"), format = "%Y%m%d"),
             valeur = as.numeric(d$VALEUR))
}

# Cumul annuel : somme des douze mois. 84 observations, 1931-2014.
annuel <- function(d) {
  an <- as.integer(format(d$date, "%Y"))
  n  <- tapply(d$valeur, an, length)
  a  <- sort(unique(an))
  complet <- a[n[as.character(a)] == 12]          # on écarte les années tronquées
  data.frame(annee  = complet,
             valeur = as.numeric(tapply(d$valeur, an, sum)[as.character(complet)]))
}

# Séries externes mises en cache (FRED, Yahoo). Voir
# 04-Data/mettre-a-jour-donnees-externes.R
lire_externe <- function(nom) {
  f <- file.path("04-Data", paste0(nom, ".csv"))
  if (!file.exists(f))
    stop("Cache absent : ", f, "\n  Lancez une fois :\n",
         '    source("04-Data/mettre-a-jour-donnees-externes.R")')
  d <- read.csv(f, stringsAsFactors = FALSE)
  d$date <- as.Date(d$date)
  d
}
