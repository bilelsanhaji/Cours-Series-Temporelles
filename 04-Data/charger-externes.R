# Lecture des séries externes mises en cache
# Chargé par les chapitres 1 et 3. Voir 04-Data/mettre-a-jour-donnees-externes.R
#
# Le répertoire d'exécution est la racine du projet (`execute-dir: project`
# dans _quarto.yml) : le chemin ci-dessous vaut donc depuis n'importe quel
# document, y compris depuis 01-Slides/etudiant/.

charger_externe <- function(nom) {
  f <- file.path("04-Data", paste0(nom, ".csv"))
  if (!file.exists(f)) {
    stop("Série externe absente du cache : ", f, "\n",
         "  Lancez une fois, depuis la racine du dépôt :\n",
         '    source("04-Data/mettre-a-jour-donnees-externes.R")')
  }
  d <- utils::read.csv(f, stringsAsFactors = FALSE)
  d$date <- as.Date(d$date)
  d
}
