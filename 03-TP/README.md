# Les travaux sur machine

**`R` ou `Python`, au choix.** Le choix est libre, réversible en cours de
semestre, et sans aucune incidence sur la notation. Chaque fiche a un corrigé
dans les deux langages.

---

## Les fiches

| Fiche | Séance | Contenu |
|---|---|---|
| `TP0-installation` | **avant la 1re** | Installer et vérifier votre environnement |
| `TP1-simulation-acf` | 4 | Bruit blanc, simulation, ACF et PACF |
| `TP2-arma` | 7 | Identification, estimation, diagnostic d'un ARMA |
| `TP3-racines-unitaires` | 9 | DS/TS, procédure ADF, régression fallacieuse |
| `TP4-var` | 11 | VAR, causalité de Granger, réponses impulsionnelles |
| `TP5-cointegration` | — | Engle-Granger, Johansen, VECM |

`TP5` n'est **pas traité en séance** : la cointégration reste au niveau
conceptuel, exigible au partiel mais pas sur machine. La fiche est là pour
ceux qui veulent aller au bout de la mise en œuvre.

Les fiches TP1, TP2 et TP3 préparent directement les **TP notés** des
séances 7, 9 et 11.

Les **corrigés** sont dans `corriges/`, déposés après chaque séance, en `R` et
en `Python`.

---

## Charger les données

Deux modules font le travail, un par langage. Ils prennent le fichier local
s'il existe et basculent sinon sur l'URL du dépôt : **tout fonctionne sur Posit
Cloud ou Google Colab sans avoir cloné quoi que ce soit.**

### `R`

```r
source("03-TP/donnees.R")

nice  <- lire_insolation("SH_MIN006088001.csv")   # série mensuelle
niceA <- annuel(nice)                             # cumul annuel, 84 obs
chom  <- lire_externe("FRED_UNRATE")              # chômage américain
```

### `Python`

```python
import sys; sys.path.insert(0, "03-TP")
from donnees import lire_insolation, annuel, lire_externe

nice  = lire_insolation("SH_MIN006088001.csv")
niceA = annuel(nice)
chom  = lire_externe("FRED_UNRATE")
```

Les chemins sont relatifs à la **racine du dépôt**, quel que soit l'endroit d'où
vous travaillez.

**Aucune fiche n'a besoin d'une connexion ni d'une clé d'accès.** Toutes les
séries, y compris celles de FRED et de Yahoo Finance, sont versionnées dans
`04-Data/`. Vos résultats seront donc les mêmes d'une exécution à l'autre.

---

## Passer d'un langage à l'autre

`correspondance-R-python.md` donne, fonction par fonction, l'équivalence pour
tout le programme : ARMA, tests de diagnostic, racines unitaires, VAR, IRF,
cointégration.

Il signale aussi les trois pièges qui coûtent le plus de temps :

- **ADF et KPSS n'ont pas la même hypothèse nulle** — un petit $p$ ne veut pas
  dire la même chose selon le test ;
- en `Python`, le polynôme AR s'écrit avec le **signe inversé** :
  `ar=[1, -0.7]` pour $\phi = 0{,}7$ ;
- les statistiques jointes $\phi_1$, $\phi_2$, $\phi_3$ de la procédure de
  Dickey-Fuller **n'existent dans aucune bibliothèque Python** : il faut les
  reconstruire par un test de Fisher, ce que le TP3 vous fait faire.

---

## Environnement

| | |
|---|---|
| `R` | `install-packages.R`, à la racine du dépôt |
| `Python` | `environnements/requirements.txt` |

## Travailler sur notebook

Les corrigés `Python` sont des fichiers `.qmd`. Ils s'ouvrent tels quels dans
**VS Code** et **Positron**, qui exécutent les cellules directement.

Pour un vrai `.ipynb` — sur Google Colab, par exemple :

```bash
# depuis la racine du dépôt
quarto convert 03-TP/corriges/TP2-arma-python-corrige.qmd
```

Le chemin doit être celui vu depuis l'endroit où vous lancez la commande. Le
notebook est écrit à côté du `.qmd`.

Si `quarto convert` échoue, `jupytext` fait la même chose :

```bash
pip install jupytext
jupytext --to ipynb 03-TP/corriges/TP2-arma-python-corrige.qmd
```

En cas de difficulté d'installation, **Posit Cloud** et **Google Colab**
suffisent pour tout le semestre, TP notés compris. Voir `TP0-installation`.
