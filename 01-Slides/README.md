# Les chapitres

Huit decks Quarto / reveal.js. Le découpage en slides est donné par les filets
horizontaux (`---`) : c'est ce qui séparait déjà les *frames* Beamer, et
`slide-level: 0` dans le `_quarto.yml` de la racine préserve ce comportement.
Les `#` et `##` restent des titres **à l'intérieur** d'une slide.

| Fichier | Chapitre | Slides | Séances |
|---|---|---|---|
| `../00-Syllabus/syllabus.qmd` | 0 — Présentation générale | 5 | 1 |
| `CM1-introduction.qmd` | 1 — Introduction et concepts essentiels | 24 | 1–2 |
| `CM2-arma.qmd` | 2 — Processus ARMA stationnaires | 36 | 3–5 |
| `CM3-racines-unitaires.qmd` | 3 — Racines unitaires | 23 | 5–7 |
| `CM4-var.qmd` | 4 — Séries temporelles multivariées | 36 | 7–9 |
| `CM5-cointegration.qmd` | 5 — Cointégration et correction d'erreur | 16 | 9–10 |
| `CM6-ouverture.qmd` | 6 — Ouverture : modèles non linéaires | 5 | 11 |
| `CMR-rappels-revisions.qmd` | Rappels et révisions | 10 | 11 |

**155 slides pour 11 × 75 min de cours magistral**, soit environ 5,5 min par
slide — le rythme observé sur les deux années précédentes.

## Deux versions : la vôtre et celle des étudiants

| | Où | Contient les notes | Publié |
|---|---|---|---|
| **Vos sources** | `01-Slides/*.qmd`, `00-Syllabus/syllabus.qmd` | oui | non — gitignore |
| **Version étudiante** | `01-Slides/etudiant/`, `00-Syllabus/etudiant/` | non | oui |

Les blocs `::: {.notes}` sont **embarqués dans le HTML rendu** : un étudiant qui
appuie sur `S` ouvre la vue présentateur et les lit. Distribuer votre version
reviendrait donc à distribuer vos notes. D'où la séparation.

**Pour engendrer et rendre la version étudiante** — double-cliquer sur
**`Version étudiante.command`**. Il expurge les notes, rend les HTML autonomes
dans `etudiant/`, puis vérifie qu'aucune note n'a survécu.

Ou à la main :

```bash
Rscript 01-Slides/generer-version-etudiant.R
quarto render 01-Slides/etudiant && quarto render 00-Syllabus/etudiant
```

> **Ne modifiez jamais un fichier de `etudiant/`** : il est réécrit à chaque
> génération. Toutes les corrections se font dans la source.

## Notes de conduite de séance

Chaque chapitre porte des blocs `::: {.notes}` : minutage, bornes de séance,
points de décrochage, transitions. Ils s'affichent en **vue présentateur**
(touche `S`) et n'apparaissent pas à la projection.

La première slide de chaque chapitre porte une note de cadrage qui indique le
découpage en séances et ce qui a été déplacé vers les fiches de TP.

Le profil `tableau`, lui, rend **votre** source : vous gardez donc les notes en
salle, où elles servent.

## Le code a quitté les chapitres

Tous les chunks sont en `echo: false` : les figures s'affichent, le code non.
Les slides « Dans la pratique » sont devenues la matière des fiches de TP. Ce
qui a été retiré est conservé dans `extraits/`, chapitre par chapitre, pour
servir de matière première.

## Trois rendus, à ne pas confondre

| Pour | Commande | Sort dans | Notes | Publié |
|---|---|---|---|---|
| **Les étudiants** | `Version étudiante.command` | `01-Slides/etudiant/` | non | oui |
| **La salle** | `Tableau - Chapitre 2.command` | `_tableau/01-Slides/` | oui | non |
| **Votre relecture** | `quarto render 01-Slides/CM2-arma.qmd` | `01-Slides/` | oui | non |

Les deux derniers rendent **votre source, notes comprises**. Ils sont l'un et
l'autre exclus du dépôt — le troisième par la règle `01-Slides/*.html` du
`.gitignore`.

> **Les rendus ne se mélangent pas.** La version tableau traîne un dossier
> `*_files/` : le plugin chalkboard interdit l'auto-inclusion des ressources, et
> ce fichier-là ne s'ouvrirait pas chez un étudiant.
>
> Le script `publier-Cours-Series-Temporelles.command` a deux garde-fous : il
> refuse tout HTML non autonome, et **tout fichier contenant vos notes de
> conduite de séance**.

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
