# Les chapitres

Sept decks Quarto / reveal.js. Le découpage en slides est donné par les filets
horizontaux (`---`) : c'est ce qui séparait déjà les *frames* Beamer, et
`slide-level: 0` dans le `_quarto.yml` de la racine préserve ce comportement.
Les `#` et `##` restent des titres **à l'intérieur** d'une slide.

| Fichier | Chapitre |
|---|---|
| `../00-Syllabus/syllabus.qmd` | 0 — Présentation générale |
| `CM1-introduction.qmd` | 1 — Introduction et concepts essentiels |
| `CM2-arma.qmd` | 2 — Processus ARMA stationnaires |
| `CM3-racines-unitaires.qmd` | 3 — Racines unitaires |
| `CM4-var.qmd` | 4 — Séries temporelles multivariées |
| `CM5-non-lineaire.qmd` | 5 — Modèles univariés non linéaires |
| `CMR-rappels-revisions.qmd` | Rappels et révisions |

## Deux façons de rendre

**Pour les étudiants** — un seul fichier HTML, autonome, qui fonctionne hors
ligne et se dépose tel quel sur Moodle :

```bash
quarto render 01-Slides/CM2-arma.qmd
```

**Pour la salle** — avec le tableau blanc, pour annoter les slides en direct :

```bash
quarto render 01-Slides/CM2-arma.qmd --profile tableau
```

Ou, plus simplement, double-cliquer sur le lanceur **`Tableau - Chapitre 2.command`** :
il rend le deck et l'ouvre dans Safari.

> **Les deux rendus ne se mélangent pas.** La version étudiante sort à côté de
> la source, `01-Slides/CM2-arma.html`. La version tableau sort dans
> `_tableau/01-Slides/CM2-arma.html`, un dossier exclu du dépôt. Le plugin
> chalkboard interdit l'auto-inclusion des ressources : cette version-là traîne
> un dossier `*_files/` et ne s'ouvrirait pas chez un étudiant.
>
> Le script `publier-Cours-Series-Temporelles.command` refuse de committer un
> HTML non autonome, au cas où l'un des deux se retrouverait au mauvais endroit.

## En présentation

| Touche | Effet |
|---|---|
| `B` | tableau blanc plein écran |
| `C` | stylo, pour dessiner par-dessus la slide |
| `SUPPR` | effacer les annotations de la slide |
| `D` | télécharger les annotations |
| `S` | vue présentateur (chrono, notes, slide suivante) |
| `F` | plein écran |
| `Échap` | vue d'ensemble des slides |

## Retoucher l'apparence

Tout est dans `theme.scss` à la racine : palette, tailles de titres, encadrés.
C'est le **même fichier que le M2 Crypto-Fintech** — les deux cours partagent
une identité visuelle, une retouche ici gagne à être reportée là-bas.

Classes utilisables dans le corps des slides :

```markdown
::: {.retenir}    **À retenir** — encadré bleu
::: {.definition} cadre formel, bleu de Prusse
::: {.piege}      contre-intuitif, or
::: {.question}   question posée à la salle
::: {.small}      .xsmall  .xxsmall   pour réduire le corps du texte
```
