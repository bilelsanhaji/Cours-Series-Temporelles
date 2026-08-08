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
| **4** | Séries temporelles multivariées | Estimer un VAR, tester Granger, lire une IRF |
| **5** | Cointégration et correction d'erreur | Reconnaître une relation de long terme, situer un VECM |
| **6** | Ouverture : modèles non linéaires | Situer les modèles à changement de régime |

Les objectifs sont formulés en termes de pratique : lire un article empirique
en macroéconomie ou en finance, **reproduire** son analyse, la critiquer, puis
produire son propre travail empirique.

**Format 2026/2027 : 11 séances de 3 × 50 min**, environ moitié cours magistral,
moitié travaux dirigés et travaux sur machine, dans la même séance.

---

## `R` ou `Python`, au choix

Les travaux sur machine se font dans le langage de votre choix. **Les deux sont
pris en charge à parité** : chaque fiche de TP a un corrigé dans chaque langage,
et `03-TP/correspondance-R-python.md` donne, fonction par fonction, l'équivalence
entre les deux écosystèmes.

Le choix est libre, réversible en cours de semestre, et sans aucune incidence sur
la notation.

---

## Ce que contient ce dépôt

| Dossier | Contenu |
|---|---|
| `00-Syllabus/` | Chapitre 0 : présentation générale, plan, objectifs, évaluation |
| `01-Slides/` | Les chapitres du cours magistral (Quarto → reveal.js) |
| `01-Slides/notes/` | Notes détaillées et **fiche de révision** |
| `01-Slides/extraits/` | Slides retirées du cours et versées aux fiches de TP |
| `02-TD/` | Les fiches de travaux dirigés (exercices sur papier) |
| `03-TP/` | Les fiches de travaux sur machine, `R` et `Python` (voir `03-TP/README.md`) |
| `04-Data/` | Les séries utilisées en TD et en TP |
| `05-Eval/` | Sujets de partiel, sujets des TP notés, articles de référence |
| `05-Eval/tp-notes/` | Les trois TP notés et leur mode d'emploi |
| `06-Enseignant/` | Déroulé des séances, plan de refonte, notes de préparation |
| `99-Archive/` | Sources d'origine et versions antérieures du cours |

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

**La marche à suivre complète est dans `03-TP/TP0-installation.qmd`**, à faire
circuler avant la première séance.

En bref, selon le langage retenu :

| | À installer | Paquets | Repli sans installation |
|---|---|---|---|
| `R` | [R](https://cran.r-project.org/) ≥ 4.2, [RStudio](https://posit.co/download/rstudio-desktop/) | `source("install-packages.R")` | [Posit Cloud](https://posit.cloud/) |
| `Python` | [Python](https://www.python.org/downloads/) ≥ 3.10 ou Anaconda | `pip install -r 03-TP/environnements/requirements.txt` | [Google Colab](https://colab.research.google.com/) |

[Quarto](https://quarto.org/docs/get-started/) **≥ 1.3** est nécessaire dans les
deux cas — il est inclus dans les versions récentes de RStudio.

Les deux solutions en ligne suffisent pour tout le semestre, **y compris pour
les TP notés**.

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
| 27 stations métropolitaines | `04-Data/SH_IN_metropole/` | Météo-France |
| Débit de la Helmsdale (Kilpherid) | `04-Data/riverflowUK.csv` | [NRFA, station 2001](https://nrfa.ceh.ac.uk/data/station/download?stn=2001&dt=gdf) |
| Chômage américain, PIB réel, consommation, richesse, revenu | `04-Data/FRED_*.csv` | FRED, mis en cache |
| Dow Jones, GBP/USD, or 2005 | `04-Data/YAHOO_*.csv` | Yahoo Finance, mis en cache |

**Aucun chapitre ni aucune fiche n'appelle d'API.** Les séries FRED et Yahoo
sont mises en cache par `04-Data/mettre-a-jour-donnees-externes.R`, à relancer
une fois par an avant la rentrée. Tout compile donc hors ligne, sans clé, et
donne des chiffres stables d'un rendu à l'autre.

Deux modules — `03-TP/donnees.R` et `03-TP/donnees.py` — se chargent de la
lecture. Ils prennent le fichier local s'il existe et basculent sinon sur l'URL
GitHub : les corrigés fonctionnent donc sur Posit Cloud ou Colab sans clone
préalable. Voir `03-TP/README.md`.

Le rafraîchissement annuel du cache demande une clé FRED personnelle et
gratuite, à placer dans `~/.Renviron` sous la forme `FRED_API_KEY=…` —
**jamais dans un fichier du dépôt**.

---

## Compiler les supports

Les chapitres se rendent de deux façons.

**Pour les étudiants** — une copie expurgée des notes de conduite de séance,
rendue en HTML autonome dans `etudiant/`. C'est cette version qui se dépose sur
Moodle et qui est publiée :

```bash
Rscript 01-Slides/generer-version-etudiant.R
quarto render 01-Slides/etudiant && quarto render 00-Syllabus/etudiant
```

Ou, plus simplement, double-cliquer sur `01-Slides/Version étudiante.command`.

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

| Composante | Poids | Modalité |
|---|---|---|
| Partiel final sur table | 60 % | 2 h, sans document |
| Trois TP notés sur machine | 40 % | Séances 7, 9 et 11, en séance, individuels |

**Chaque étudiant travaille sur sa propre série** — une station météo différente
par étudiant, parmi les 27 de `04-Data/SH_IN_metropole/`. Les trois TP notés
portent sur cette même série, ce qui permet de se concentrer sur la méthode
plutôt que sur la découverte des données.

Ce qui est noté est la **démarche** et l'**interprétation**, pas la sortie brute.
Un résultat gênant correctement discuté vaut mieux qu'un résultat propre laissé
sans commentaire.

L'usage d'une assistance par IA est autorisé pendant les TP notés. Il ne présente
simplement aucun intérêt pour la partie qui compte : personne ne peut produire
vos chiffres ni les interpréter à votre place.

Les sujets, le mode d'emploi et le script d'attribution des stations sont dans
`05-Eval/tp-notes/`.

---

## Bibliographie

Les ouvrages de référence sont rassemblés dans le dossier `Biblio/` du répertoire
parent : Hamilton, Brooks, Mills, Wei, Cryer & Chan, Shumway & Stoffer.

---

## Licence et usage

Matériel pédagogique mis à disposition des étudiants du M1 MBFA de l'Université
Paris 8. Réutilisation à des fins d'enseignement bienvenue, avec mention de la
source.
