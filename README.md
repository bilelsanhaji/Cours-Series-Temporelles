# Économétrie des séries temporelles — M1 MBFA

**Université Paris 8 — Master 1 Monnaie, Banque, Finance, Assurance**
Cours magistral et travaux dirigés · B. Sanhaji

---

## De quoi il s'agit

Le cours part de la régression linéaire et de la théorie des probabilités pour
aller vers l'analyse des **processus évolutifs et non stationnaires**. Les
séries temporelles posent deux difficultés que l'analyse transversale ignore :
les variables sont corrélées entre elles *à un instant donné*, mais aussi
*dans le temps* — et leurs moments eux-mêmes peuvent varier.

Le fil des chapitres :

| | Chapitre | Ce que vous saurez faire |
|---|---|---|
| **1** | Introduction et concepts essentiels | Caractériser un processus stochastique, lire une ACF |
| **2** | Processus ARMA stationnaires | Identifier, estimer et valider un ARMA |
| **3** | Racines unitaires | Tester la non-stationnarité, choisir la spécification du test |
| **4** | Séries temporelles multivariées | Estimer un VAR, tester Granger, lire une IRF, traiter la cointégration |
| **5** | Modèles univariés non linéaires | Situer les modèles à seuil et à transition lisse |

Les objectifs sont formulés en termes de pratique : lire un article empirique
en macroéconomie ou en finance, **reproduire** son analyse, la critiquer, puis
produire son propre travail empirique.

---

## Ce que contient ce dépôt

| Dossier | Contenu |
|---|---|
| `00-Syllabus/` | Chapitre 0 : présentation générale, plan, objectifs, évaluation |
| `01-Slides/` | Les chapitres du cours magistral (Quarto → reveal.js) |
| `01-Slides/notes/` | Notes de cours détaillées : calcul des autocovariances, stationnarité des AR |
| `02-TD/` | Les fiches de travaux dirigés (exercices sur papier) |
| `03-TP/` | Les fiches `R` (travail sur machine) |
| `04-Data/` | Les séries utilisées en TD et en TP |
| `05-Eval/` | Sujets d'examen, sujet de projet, articles de référence |
| `06-Enseignant/` | Déroulé des séances, notes de préparation |
| `99-Archive/` | Sources `.Rmd` d'origine et versions antérieures |

Les corrigés sont dans `02-TD/corriges/` et `03-TP/corriges/`, et sont déposés
après chaque séance.

---

## Récupérer le cours

```bash
git clone https://github.com/bilelsanhaji/Cours-Series-Temporelles.git
cd Cours-Series-Temporelles
```

Le dépôt est mis à jour au fil du semestre. Pour récupérer les ajouts :

```bash
git pull
```

Les corrigés des TD et des TP y sont déposés **après** chaque séance.

---

## Installation

Le cours se fait **en `R`**. Il vous faut :

1. [R](https://cran.r-project.org/) (≥ 4.2)
2. [RStudio](https://posit.co/download/rstudio-desktop/) ou
   [Posit Cloud](https://posit.cloud/) si vous ne pouvez pas installer de logiciel
3. [Quarto](https://quarto.org/docs/get-started/) **≥ 1.3** — inclus dans les
   versions récentes de RStudio

Puis, dans la console `R` :

```r
source("install-packages.R")
```

Ce script installe les paquets manquants et laisse les autres tranquilles.

> **Une distribution LaTeX est nécessaire** pour compiler les fiches de TD et de
> TP en PDF. Le plus simple :
> `install.packages("tinytex"); tinytex::install_tinytex()`
> Les chapitres, eux, se rendent en HTML et n'en ont pas besoin.

---

## Les données

| Série | Fichier | Source |
|---|---|---|
| Durées d'insolation, Nice | `04-Data/SH_MIN006088001.csv` | Météo-France |
| Durées d'insolation, Paris | `04-Data/SH_MIN175114001.csv` | Météo-France |
| Débit de la Helmsdale (Kilpherid) | `04-Data/riverflowUK.csv` | [NRFA, station 2001](https://nrfa.ceh.ac.uk/data/station/download?stn=2001&dt=gdf) |
| 27 stations métropolitaines | `04-Data/SH_IN_metropole/` | Météo-France |

Les fiches de TP chargent les deux premières séries **par URL** depuis le dépôt
GitHub du cours, de sorte qu'elles fonctionnent sans clone préalable. Les mêmes
fichiers sont versionnés dans `04-Data/` : en cas de coupure réseau, remplacez
l'URL par le chemin relatif, par exemple

```r
read_delim("../04-Data/SH_MIN006088001.csv", delim = ";")
```

Certains chapitres utilisent en plus l'API [FRED](https://fred.stlouisfed.org/docs/api/api_key.html)
via `{fredr}`, qui demande une clé personnelle gratuite.

---

## Compiler les supports

Les chapitres se rendent de deux façons.

**Pour les étudiants** — un fichier HTML unique et autonome, qui fonctionne hors
ligne et se dépose tel quel sur Moodle :

```bash
quarto render 01-Slides/CM2-arma.qmd
```

**Pour la salle** — avec le tableau blanc, pour annoter les slides en direct
(`B` pour le tableau, `C` pour le stylo, `S` pour la vue présentateur) :

```bash
quarto render 01-Slides/CM2-arma.qmd --profile tableau
```

Ou, plus simplement, double-cliquer sur le lanceur
`01-Slides/Tableau - Chapitre 2.command`.

Les fiches de TD et de TP restent en PDF :

```bash
quarto render 02-TD 03-TP
```

Le détail des deux profils, des raccourcis en présentation et des classes de
mise en forme est dans `01-Slides/README.md`.

> **Quarto ≥ 1.3 requis.** Les chapitres utilisent `slide-level: 0` — seuls les
> filets horizontaux découpent les slides, les `#` et `##` restent des titres
> internes. C'est ce qui reproduit à l'identique le découpage des anciennes
> *frames* Beamer, et cela demande Pandoc 3, embarqué à partir de Quarto 1.3.

---

## Évaluation

| Composante | Poids |
|---|---|
| Examen final sur table (CM) | 60 % |
| Projet individuel (TD) | 40 % |

Le projet se fait **en `R`** : le code doit être compris, exécutable et
documenté, avec citation des sources originales des méthodes employées. Le sujet
et les attendus sont dans `05-Eval/projet/`.

---

## Bibliographie

Les ouvrages de référence sont rassemblés dans le dossier `Biblio/` du répertoire
parent : Hamilton, Brooks, Mills, Wei, Cryer & Chan, Shumway & Stoffer.

---

## Licence et usage

Matériel pédagogique mis à disposition des étudiants du M1 MBFA de l'Université
Paris 8. Réutilisation à des fins d'enseignement bienvenue, avec mention de la
source.
