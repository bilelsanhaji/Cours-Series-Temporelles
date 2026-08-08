# Les chapitres du cours

Les supports sont dans **`etudiant/`**, en deux formats :

- **`.html`** — à ouvrir dans un navigateur. Tout est embarqué : le fichier
  fonctionne hors ligne, une fois téléchargé.
- **`.qmd`** — la source Quarto, si vous voulez voir comment une figure est
  produite ou reprendre un morceau de code.

| Fichier | Chapitre |
|---|---|
| `../00-Syllabus/etudiant/syllabus.html` | 0 — Présentation générale |
| `etudiant/CM1-introduction.html` | 1 — Introduction et concepts essentiels |
| `etudiant/CM2-arma.html` | 2 — Processus ARMA stationnaires |
| `etudiant/CM3-racines-unitaires.html` | 3 — Racines unitaires |
| `etudiant/CM4-var.html` | 4 — Séries temporelles multivariées |
| `etudiant/CM5-cointegration.html` | 5 — Cointégration et correction d'erreur |
| `etudiant/CM6-ouverture.html` | 6 — Ouverture : modèles non linéaires |
| `etudiant/CMR-rappels-revisions.html` | Rappels et révisions |

## Se déplacer dans un chapitre

| Touche | Effet |
|---|---|
| `→` `←` ou molette | slide suivante, précédente |
| `Échap` | vue d'ensemble de toutes les slides |
| `F` | plein écran |
| `?` | liste des raccourcis |

## Notes de cours

`notes/` contient les compléments qui ne tiennent pas dans une slide :

| Fichier | Contenu |
|---|---|
| `notes/fiche-revision.qmd` | **Fiche de révision** — synthèse de tout le programme |
| `notes/annexes-autocovariance.qmd` | Calcul détaillé des autocovariances et autocorrélations |
| `notes/stationnarite-racines-AR.qmd` | Stationnarité des AR : les deux conventions de racines |

Les annexes détaillent les calculs que le cours ne déroule pas au tableau faute
de temps. Elles sont là pour être lues posément, pas apprises par cœur.

## Le code des figures

Les chapitres affichent les figures sans le code qui les produit — c'est en TP
que vous l'écrirez vous-même. Si vous voulez tout de même voir comment une
figure est faite, ouvrez le `.qmd` correspondant dans `etudiant/`.
