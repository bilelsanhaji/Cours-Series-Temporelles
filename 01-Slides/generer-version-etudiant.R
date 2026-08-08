# Engendre la version étudiante des chapitres
# Économétrie des séries temporelles — M1 MBFA
#
# Vos sources (01-Slides/*.qmd et 00-Syllabus/syllabus.qmd) contiennent des
# blocs `::: {.notes}` : minutage, points de décrochage, transitions. Ces notes
# sont embarquées dans le HTML rendu — un étudiant qui appuie sur `S` ouvre la
# vue présentateur et les lit. Elles ne doivent donc jamais quitter votre poste.
#
# Ce script produit, dans `etudiant/`, une copie de chaque chapitre expurgée de
# ses notes. C'est cette copie-là qui est rendue et publiée.
#
#   sources enseignant   01-Slides/*.qmd              -> gitignore
#   version étudiante    01-Slides/etudiant/*.qmd     -> publiée
#
# Usage, depuis la racine du dépôt :
#     source("01-Slides/generer-version-etudiant.R")
#
# Ou, plus simplement, double-cliquer sur
#     01-Slides/Version étudiante.command
# qui engendre les copies ET les rend en HTML.

SOURCES <- c(
  "00-Syllabus/syllabus.qmd",
  "01-Slides/CM1-introduction.qmd",
  "01-Slides/CM2-arma.qmd",
  "01-Slides/CM3-racines-unitaires.qmd",
  "01-Slides/CM4-var.qmd",
  "01-Slides/CM5-cointegration.qmd",
  "01-Slides/CM6-ouverture.qmd",
  "01-Slides/CMR-rappels-revisions.qmd"
)

BANDEAU <- paste(
  "",
  "<!-- Version étudiante : engendrée automatiquement depuis la source",
  "     enseignante par 01-Slides/generer-version-etudiant.R.",
  "     Ne pas modifier ici — les changements seraient écrasés. -->",
  "", sep = "\n")

expurger <- function(chemin) {
  lignes <- readLines(chemin, warn = FALSE, encoding = "UTF-8")

  # `readLines` perd le retour à la ligne final. On le remet : sans lui, un
  # bloc de notes situé en toute fin de fichier — c'est le cas du syllabus —
  # ne se termine pas par ":::\n" et échappe au motif ci-dessous.
  txt <- paste0(paste(lignes, collapse = "\n"), "\n")

  # Retire les blocs ::: {.notes} ... ::: , avec les lignes vides qui les
  # précèdent. (?s) laisse le point traverser les retours à la ligne, (?m)
  # ancre ^ en début de ligne, .*? reste non gourmand pour ne pas avaler
  # jusqu'au dernier ::: du fichier.
  txt <- gsub("(?sm)\n*^::: \\{\\.notes\\}\n.*?^:::[ \t]*\n", "\n", txt, perl = TRUE)

  # Insère le bandeau juste après l'en-tête YAML
  sub("(?s)^(---\n.*?\n---\n)", paste0("\\1", BANDEAU), txt, perl = TRUE)
}

for (src in SOURCES) {
  if (!file.exists(src)) { warning("absent : ", src); next }

  dossier <- file.path(dirname(src), "etudiant")
  dir.create(dossier, showWarnings = FALSE, recursive = TRUE)
  cible <- file.path(dossier, basename(src))

  brut   <- paste(readLines(src, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  avant  <- lengths(regmatches(brut, gregexpr("::: {.notes}", brut, fixed = TRUE)))
  sortie <- expurger(src)

  # Garde-fou : aucune note ne doit avoir survécu
  if (grepl("::: {.notes}", sortie, fixed = TRUE)) {
    stop("Des notes subsistent dans ", src, ".\n",
         "  Un bloc n'est pas reconnu. Vérifiez qu'il s'ouvre par une ligne\n",
         "  exactement égale à '::: {.notes}' et se ferme par une ligne ':::'.")
  }

  writeLines(sub("\n+$", "", sortie), cible, useBytes = TRUE)
  message(sprintf("  %-42s -> %-44s %d note(s) retirée(s)",
                  src, cible, avant))
}

message("\nVersions étudiantes engendrées. Pour les rendre :")
message("    quarto render 01-Slides/etudiant")
message("    quarto render 00-Syllabus/etudiant")
