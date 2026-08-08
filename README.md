# Économétrie des séries temporelles — M1 MBFA

**Université Paris 8 — Master 1 Monnaie, Banque, Finance, Assurance**
B. Sanhaji

---

## De quoi il s'agit

Le cours part de la régression linéaire et de la théorie des probabilités pour
aller vers l'analyse des **processus évolutifs et non stationnaires**. Les
séries temporelles posent deux difficultés que l'analyse transversale ignore :
les variables sont corrélées entre elles *à un instant donné*, mais aussi
*dans le temps* — et leurs moments eux-mêmes peuvent varier.

| | Chapitre | Ce que vous saurez faire |
|---|---|---|
| **1** | Introduction et concepts essentiels | Caractériser un processus stochastique, lire une ACF |
| **2** | Processus ARMA stationnaires | Identifier, estimer et valider un ARMA |
| **3** | Racines unitaires | Tester la non-stationnarité, choisir la spécification du test |
| **4** | Séries temporelles multivariées | Estimer un VAR, tester Granger, lire une IRF |
| **5** | Cointégration et correction d'erreur | Reconnaître une relation de long terme, situer un VECM |
| **6** | Ouverture : modèles non linéaires | Situer les modèles à changement de régime |

À la fin du semestre, vous devez pouvoir lire un article empirique en
macroéconomie ou en finance, **reproduire** son analyse, la critiquer, et
produire votre propre travail empirique.

**11 séances de 3 × 50 min**, environ moitié cours, moitié travaux dirigés et
travaux sur machine, dans la même séance.

---

## `R` ou `Python`, au choix

Les travaux sur machine se font dans le langage de votre choix. **Les deux sont
pris en charge à parité** : chaque fiche a un corrigé dans chaque langage, et
`03-TP/correspondance-R-python.md` donne, fonction par fonction, l'équivalence
entre les deux écosystèmes.

Le choix est libre, réversible en cours de semestre, et **sans aucune incidence
sur la notation**.

---

## Où trouver quoi

| Dossier | Contenu |
|---|---|
| `00-Syllabus/etudiant/` | Présentation générale : plan, objectifs, évaluation |
| `01-Slides/etudiant/` | Les chapitres du cours, en HTML |
| `01-Slides/notes/` | Notes détaillées et **fiche de révision** |
| `02-TD/` | Les fiches de travaux dirigés — exercices sur papier |
| `03-TP/` | Les fiches de travaux sur machine |
| `04-Data/` | Les séries utilisées en TD et en TP |
| `05-Eval/` | Sujets d'examen des années passées, articles de référence |

Les **corrigés** des TD et des TP sont déposés après chaque séance, dans
`02-TD/corriges/` et `03-TP/corriges/`.

Les chapitres se lisent dans un navigateur : ouvrez le fichier `.html`, il
fonctionne hors ligne. `Échap` donne la vue d'ensemble, `F` le plein écran.

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

Sans `git`, le bouton **Code → Download ZIP** de la page GitHub fait l'affaire —
mais il faudra le refaire à chaque mise à jour.

---

## Installation

**La marche à suivre complète est dans `03-TP/TP0-installation.qmd`**, à faire
**avant la première séance**.

| | À installer | Paquets | Sans rien installer |
|---|---|---|---|
| `R` | [R](https://cran.r-project.org/) ≥ 4.2 + [RStudio](https://posit.co/download/rstudio-desktop/) | `source("install-packages.R")` | [Posit Cloud](https://posit.cloud/) |
| `Python` | [Python](https://www.python.org/downloads/) ≥ 3.10 ou Anaconda | `pip install -r 03-TP/environnements/requirements.txt` | [Google Colab](https://colab.research.google.com/) |

Les deux solutions en ligne suffisent pour tout le semestre, **y compris pour
les TP notés**.

Pour compiler les fiches en PDF, une distribution LaTeX est nécessaire. Le plus
simple, en `R` : `install.packages("tinytex"); tinytex::install_tinytex()`.

---

## Les données

| Série | Fichier | Source |
|---|---|---|
| Durées d'insolation, Nice | `04-Data/SH_MIN006088001.csv` | Météo-France |
| Durées d'insolation, Paris | `04-Data/SH_MIN175114001.csv` | Météo-France |
| 27 stations métropolitaines | `04-Data/SH_IN_metropole/` | Météo-France |
| Débit de la Helmsdale | `04-Data/riverflowUK.csv` | [NRFA, station 2001](https://nrfa.ceh.ac.uk/data/station/download?stn=2001&dt=gdf) |
| Chômage, PIB, consommation, richesse, revenu — États-Unis | `04-Data/FRED_*.csv` | FRED |
| Dow Jones, GBP/USD, or | `04-Data/YAHOO_*.csv` | Yahoo Finance |

**Toutes les séries sont dans le dépôt.** Aucune fiche n'a besoin d'une
connexion ni d'une clé d'accès : les données sont versionnées, et vos résultats
seront donc reproductibles.

Deux modules, `03-TP/donnees.R` et `03-TP/donnees.py`, se chargent de la
lecture. Voir `03-TP/README.md`.

---

## Évaluation

| Composante | Poids | Modalité |
|---|---|---|
| Partiel final sur table | 60 % | 2 h, sans document |
| Trois TP notés sur machine | 40 % | Séances 7, 9 et 11, en séance, individuels |

**Chaque étudiant travaille sur sa propre série** — une station météo différente
par étudiant, attribuée en séance 1. Les trois TP notés portent sur cette même
série : vous la connaîtrez, et pourrez vous concentrer sur la méthode.

Ce qui est noté est la **démarche** et l'**interprétation**, pas la sortie
brute. Un résultat gênant correctement discuté vaut mieux qu'un résultat propre
laissé sans commentaire.

L'usage d'une assistance par IA est autorisé pendant les TP notés. Il ne
présente simplement aucun intérêt pour la partie qui compte : personne ne peut
produire vos chiffres ni les interpréter à votre place.

---

## Bibliographie

Hamilton, Brooks, Mills, Wei, Cryer & Chan, Shumway & Stoffer. Les références
précises sont dans le chapitre 1.

---

## Licence et usage

Matériel pédagogique mis à disposition des étudiants du M1 MBFA de l'Université
Paris 8. Réutilisation à des fins d'enseignement bienvenue, avec mention de la
source.
