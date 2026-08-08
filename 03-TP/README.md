# Les travaux sur machine

**`R` ou `Python`, au choix.** Le choix est libre, réversible en cours de
semestre, et sans aucune incidence sur la notation. Chaque fiche a un corrigé
dans les deux langages.

---

## Les fiches

| Fiche | Séance | Contenu | Prépare |
|---|---|---|---|
| `TP0-installation.qmd` | **avant** la 1 | Installer et vérifier son environnement | — |
| `TP1-simulation-acf.qmd` | 4 | Bruit blanc, simulation, ACF et PACF | TP noté n°1 |
| `TP2-arma.qmd` | 7 | Identification, estimation, diagnostic ARMA | TP noté n°1 |
| `TP3-racines-unitaires.qmd` | 9 | DS/TS, procédure ADF, régression fallacieuse | TP noté n°2 |
| `TP4-var.qmd` | 11 | VAR, Granger, réponses impulsionnelles | TP noté n°3 |
| `TP5-cointegration.qmd` | *hors séance* | Engle-Granger, Johansen, VECM | — |

`TP5` est **fourni mais non traité** : la cointégration reste au niveau
conceptuel, exigible au partiel mais pas sur machine.

Les corrigés sont dans `corriges/`, déposés après chaque séance.

---

## Structure d'une fiche

L'**énoncé** ne contient aucun code : les questions valent dans les deux
langages. Les corrigés, eux, sont dédoublés :

```
TP2-arma.qmd                          énoncé, sans code
corriges/TP2-arma-R-corrige.qmd       corrigé R
corriges/TP2-arma-python-corrige.qmd  corrigé Python
```

Pour obtenir un notebook Jupyter à partir d'un corrigé `Python` :

```bash
quarto convert corriges/TP2-arma-python-corrige.qmd
```

---

## Charger les données

Deux modules font le travail, l'un par langage. Ils lisent le fichier local
s'il existe et basculent sinon sur l'URL GitHub — les corrigés fonctionnent
donc sur Posit Cloud ou Google Colab sans clone préalable.

::: {.panel-tabset}

### `R`

```r
source("03-TP/donnees.R")

nice  <- lire_insolation("SH_MIN006088001.csv")   # mensuel
niceA <- annuel(nice)                             # cumul annuel, 84 obs
chom  <- lire_externe("FRED_UNRATE")              # série mise en cache
```

### `Python`

```python
import sys; sys.path.insert(0, "03-TP")
from donnees import lire_insolation, annuel, lire_externe

nice  = lire_insolation("SH_MIN006088001.csv")
niceA = annuel(nice)
chom  = lire_externe("FRED_UNRATE")
```

:::

**Les chemins sont relatifs à la racine du dépôt** — `execute-dir: project`
dans `_quarto.yml` s'en charge, quel que soit l'emplacement du document.

### Aucune fiche n'appelle d'API

Les séries FRED et Yahoo sont **mises en cache** dans `04-Data/` par
`04-Data/mettre-a-jour-donnees-externes.R`, à relancer une fois par an avant la
rentrée. Les TP compilent donc hors ligne, sans clé, et donnent toujours les
mêmes chiffres — ce qui n'était pas le cas quand les données étaient
téléchargées au moment du rendu.

---

## Équivalences entre les deux langages

`correspondance-R-python.md` donne, fonction par fonction, l'équivalence pour
tout le programme : ARMA, tests de diagnostic, racines unitaires, VAR, IRF,
cointégration.

Il signale aussi les trois pièges qui coûtent le plus de temps :

- les hypothèses nulles opposées d'ADF et de KPSS ;
- la convention de signe du polynôme AR dans `statsmodels`
  (`ar=[1, -0.7]` pour $\phi = 0{,}7$) ;
- l'absence, en `Python`, des statistiques jointes $\phi_1$, $\phi_2$, $\phi_3$
  de la procédure de Dickey-Fuller — à reconstruire par un test de Fisher, ce
  que le TP3 fait faire.

---

## Environnement

| | |
|---|---|
| `R` | `install-packages.R` à la racine |
| `Python` | `environnements/requirements.txt` |

En cas de difficulté d'installation, **Posit Cloud** et **Google Colab**
suffisent pour tout le semestre, y compris pour les TP notés. Voir `TP0`.
