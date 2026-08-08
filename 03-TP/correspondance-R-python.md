# Correspondance `R` ↔ `Python`

**Économétrie des séries temporelles · M1 MBFA**

Les travaux sur machine se font au choix en `R` ou en `Python`. Ce document liste,
pour chaque opération du cours, la fonction à utiliser dans chaque écosystème.

Il n'est **pas** un cours de programmation : il suppose que vous savez déjà
manipuler un tableau de données dans le langage que vous avez choisi.

---

## Manipulation et graphiques

| Opération | `R` | `Python` |
|---|---|---|
| Lire un CSV | `readr::read_delim(f, delim = ";")` | `pd.read_csv(f, sep=";")` |
| Objet série temporelle | `ts(x, start, frequency)` | index `pd.DatetimeIndex` ou `PeriodIndex` |
| Différence première | `diff(x)` | `x.diff().dropna()` |
| Différence saisonnière | `diff(x, lag = 12)` | `x.diff(12).dropna()` |
| Retard | `dplyr::lag(x)` | `x.shift(1)` |
| Log-rendements | `diff(log(x)) * 100` | `np.log(x).diff() * 100` |
| Graphique | `plot(x, type = "l")` | `fig, ax = plt.subplots(); ax.plot(x)` |
| Ligne horizontale | `abline(h = mean(x))` | `ax.axhline(x.mean())` |

---

## Description : ACF, PACF, corrélations croisées

| Opération | `R` | `Python` |
|---|---|---|
| ACF (graphique) | `acf(x)` | `statsmodels.graphics.tsaplots.plot_acf(x)` |
| PACF (graphique) | `pacf(x)` | `plot_pacf(x)` |
| ACF (valeurs) | `acf(x, plot = FALSE)$acf` | `statsmodels.tsa.stattools.acf(x)` |
| PACF (valeurs) | `pacf(x, plot = FALSE)$acf` | `stattools.pacf(x)` |
| Corrélation croisée | `ccf(x, y)` | `stattools.ccf(x, y)` |

> **Attention aux conventions.** `acf()` en `R` renvoie le retard 0 (valeur 1) en
> première position ; `statsmodels` aussi, mais `plot_acf` l'affiche par défaut
> et `plot_acf(x, zero=False)` le masque. Vérifiez toujours à quel retard
> correspond la première barre avant de conclure.

---

## Modèles ARMA

| Opération | `R` | `Python` |
|---|---|---|
| Simuler un ARMA | `arima.sim(list(ar = , ma = ), n)` | `statsmodels.tsa.arima_process.ArmaProcess(...).generate_sample(n)` |
| Estimer un ARMA | `arima(x, order = c(p, d, q))` | `ARIMA(x, order=(p, d, q)).fit()` |
| Résumé | `summary(fit)` ou `lmtest::coeftest` | `res.summary()` |
| AIC / BIC | `AIC(fit)`, `BIC(fit)` | `res.aic`, `res.bic` |
| Résidus | `residuals(fit)` | `res.resid` |
| Valeurs ajustées | `fitted(fit)` | `res.fittedvalues` |
| Sélection automatique | `forecast::auto.arima(x)` | `pmdarima.auto_arima(x)` |
| Prévision | `forecast::forecast(fit, h)` | `res.get_forecast(steps=h)` |

> `arima()` en `R` estime par maximum de vraisemblance et inclut une constante
> nommée `intercept` qui est en réalité la **moyenne** du processus, pas
> l'ordonnée à l'origine. `statsmodels` l'appelle `const` et suit la même
> convention. Ne pas interpréter ce coefficient comme un $\phi_0$.

---

## Tests de diagnostic sur les résidus

| Test | `H_0` | `R` | `Python` |
|---|---|---|---|
| Ljung-Box | absence d'autocorrélation | `Box.test(r, lag, type = "Ljung-Box")` | `acorr_ljungbox(r, lags=[k])` |
| Box-Pierce | absence d'autocorrélation | `Box.test(r, lag, type = "Box-Pierce")` | `acorr_ljungbox(r, lags=[k], boxpierce=True)` |
| Jarque-Bera | normalité | `tseries::jarque.bera.test(r)` | `statsmodels.stats.stattools.jarque_bera(r)` |
| Shapiro-Wilk | normalité | `shapiro.test(r)` | `scipy.stats.shapiro(r)` |
| White | homoscédasticité | régression auxiliaire à la main | `statsmodels.stats.diagnostic.het_white(r, X)` |
| Breusch-Pagan | homoscédasticité | `lmtest::bptest(m)` | `het_breuschpagan(r, X)` |
| Ramsey RESET | forme fonctionnelle correcte | régression auxiliaire à la main | `linear_reset(m, power=2)` |
| Engle ARCH | absence d'effet ARCH | `FinTS::ArchTest(r, lags)` | `statsmodels.stats.diagnostic.het_arch(r, nlags=k)` |

Toutes les fonctions `Python` de ce tableau sont dans
`statsmodels.stats.diagnostic`, sauf `jarque_bera` (dans `stats.stattools`).

---

## Racines unitaires

| Test | `R` | `Python` |
|---|---|---|
| ADF | `tseries::adf.test(x)` | `arch.unitroot.ADF(x)` |
| ADF (procédure complète) | `urca::ur.df(x, type, lags)` | `arch.unitroot.ADF(x, trend=...)` |
| ADF (rapide) | `aTSA::adf.test(x)` | `statsmodels.tsa.stattools.adfuller(x)` |
| DF-GLS | `urca::ur.ers(x)` | `arch.unitroot.DFGLS(x)` |
| Phillips-Perron | `tseries::pp.test(x)` | `arch.unitroot.PhillipsPerron(x)` |
| KPSS | `tseries::kpss.test(x)` | `arch.unitroot.KPSS(x)` |
| Zivot-Andrews (rupture) | `urca::ur.za(x)` | `arch.unitroot.ZivotAndrews(x)` |

### Trois pièges à connaître

**1. L'hypothèse nulle n'est pas la même partout.** ADF, DF-GLS et Phillips-Perron
testent $H_0$ : *racine unitaire*. KPSS teste $H_0$ : *stationnarité*. Un petit
$p$ ne veut donc pas dire la même chose selon le test.

**2. `tseries::adf.test()` et `aTSA::adf.test()` ne donnent pas le même
résultat.** Le premier fixe le nombre de retards à $\lfloor (T-1)^{1/3} \rfloor$
et n'affiche qu'une spécification ; le second balaie les trois spécifications et
plusieurs retards. Aucun des deux n'est faux — ils ne répondent pas à la même
question. Toujours dire lequel on utilise.

**3. Les statistiques jointes $\phi_1$, $\phi_2$, $\phi_3$ n'existent pas en
`Python`.** `urca::ur.df()` les fournit ; `statsmodels` et `arch` non. Il faut
les reconstruire par un test de Fisher sur la régression auxiliaire :

```python
import statsmodels.api as sm
import numpy as np

dy = y.diff().dropna()
X  = pd.DataFrame({"y_lag": y.shift(1)}).loc[dy.index]
X["const"] = 1.0
X["trend"] = np.arange(len(X))
m = sm.OLS(dy, X[["const", "trend", "y_lag"]]).fit()

# phi_3 : H0 = {gamma = 0, beta = 0}, modèle avec constante et tendance
print(m.f_test("y_lag = 0, trend = 0"))
```

La valeur critique ne se lit **pas** dans une table de Fisher : utiliser les
tables de Dickey-Fuller (Dickey & Fuller 1981, table VI). C'est le point que le
TP3 vous fait construire.

---

## Modèles VAR et cointégration

| Opération | `R` | `Python` |
|---|---|---|
| Estimer un VAR | `vars::VAR(Y, p, type)` | `statsmodels.tsa.api.VAR(Y).fit(p)` |
| Choix du retard | `vars::VARselect(Y, lag.max)` | `VAR(Y).select_order(maxlags)` |
| Stabilité | `vars::roots(fit)` | `res.is_stable()`, `res.roots` |
| Causalité de Granger | `vars::causality(fit, cause)` | `res.test_causality(caused, causing)` |
| IRF | `vars::irf(fit, impulse, response)` | `res.irf(periods).plot()` |
| Décomposition de variance | `vars::fevd(fit)` | `res.fevd(periods)` |
| Prévision | `predict(fit, n.ahead)` | `res.forecast(Y.values[-p:], steps)` |
| Diagnostic sériel | `vars::serial.test(fit)` | `res.test_whiteness()` |
| Engle-Granger | régression puis ADF des résidus | `statsmodels.tsa.stattools.coint(y, x)` |
| Johansen | `urca::ca.jo(Y, type, ecdet, K)` | `statsmodels.tsa.vector_ar.vecm.coint_johansen(Y, det_order, k_ar_diff)` |
| VECM | `urca::cajorls(jo, r)` | `vecm.VECM(Y, k_ar_diff, coint_rank).fit()` |

> **Ordre de Cholesky.** Dans les deux langages, l'IRF orthogonalisée dépend de
> l'ordre des colonnes de `Y`. Changer l'ordre change les réponses. Ce n'est pas
> un détail d'implémentation : c'est votre hypothèse d'identification, et elle
> doit être justifiée.

---

## Données externes

| Source | `R` | `Python` |
|---|---|---|
| FRED | `fredr::fredr(series_id = )` | `pandas_datareader.get_data_fred()` ou `fredapi` |
| Yahoo Finance | `quantmod::getSymbols()` | `yfinance.download()` |

Les deux exigent une connexion. **Les fiches de TP chargent en priorité les
fichiers versionnés dans `04-Data/`**, précisément pour ne pas dépendre de la
disponibilité d'une API le jour de la séance.

La clé FRED se lit dans une variable d'environnement, jamais en dur dans le
code :

```r
fredr_set_key(Sys.getenv("FRED_API_KEY"))   # R
```

```python
os.environ["FRED_API_KEY"]                   # Python
```

---

## Ce qui n'a pas d'équivalent direct

| | |
|---|---|
| `urca::ur.df()` — statistiques $\phi$ | à reconstruire (voir plus haut) |
| `forecast::checkresiduals()` | à composer : graphique des résidus + ACF + Ljung-Box |
| `astsa::sarima()` | `ARIMA(...).fit()` puis `plot_diagnostics()` |
| `arch` (paquet `Python`) | pas d'équivalent `R` aussi homogène pour les racines unitaires |
