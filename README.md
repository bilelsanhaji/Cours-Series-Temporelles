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
| `01-Slides/notes/` | Notes de cours détaillées : calcul des autocovariances, stationnarité des AR |
| `01-Slides/extraits/` | Slides retirées du cours et versées aux fiches de TP |
| `02-TD/` | Les fiches de travaux dirigés (exercices sur papier) |
| `03-TP/` | Les fiches de travaux sur machine, `R` et `Python` |
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
