# Installe les paquets R nécessaires au cours, sans toucher à ceux déjà présents.
# Usage :  source("install-packages.R")

paquets <- c(
  # séries temporelles
  "astsa", "forecast", "tseries", "aTSA", "urca", "vars", "TSA", "FinTS",
  "lmtest", "moments", "ppcor", "xts", "zoo",
  # données
  "readr", "dplyr", "tidyverse", "quantmod", "fredr",
  # graphiques et rendu
  "ggplot2", "gridExtra", "latex2exp", "knitr", "rmarkdown",
  # utilitaires
  "MASS"
)

manquants <- setdiff(paquets, rownames(installed.packages()))

if (length(manquants) == 0) {
  message("Tous les paquets sont déjà installés.")
} else {
  message("Installation de : ", paste(manquants, collapse = ", "))
  install.packages(manquants, repos = "https://cloud.r-project.org")
}

# LaTeX, nécessaire pour compiler les slides et les fiches en PDF
if (!requireNamespace("tinytex", quietly = TRUE)) {
  install.packages("tinytex", repos = "https://cloud.r-project.org")
}
if (!tinytex::is_tinytex()) {
  message("Aucune distribution LaTeX détectée. Lancez : tinytex::install_tinytex()")
}

# {fredr} demande une clé API gratuite : https://fred.stlouisfed.org/docs/api/api_key.html
# À placer dans ~/.Renviron sous la forme  FRED_API_KEY=votre_cle
