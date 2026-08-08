"""Chargement des séries du cours — corrigés Python.

Économétrie des séries temporelles — M1 MBFA

Les chemins sont relatifs à la racine du dépôt. Si un fichier local manque,
on bascule sur l'URL GitHub : les corrigés fonctionnent donc sur Google Colab
sans clone préalable.
"""

from pathlib import Path
import pandas as pd

BASE_URL = ("https://raw.githubusercontent.com/bilelsanhaji/"
            "Cours-Series-Temporelles/refs/heads/main/04-Data/")


def _source(fichier: str, sous_dossier: str = "") -> str:
    local = Path("04-Data") / sous_dossier / fichier
    if local.exists():
        return str(local)
    suffixe = f"{sous_dossier}/" if sous_dossier else ""
    return BASE_URL + suffixe + fichier


def lire_insolation(fichier: str = "SH_MIN006088001.csv",
                    sous_dossier: str = "") -> pd.DataFrame:
    """Insolation mensuelle Météo-France. Renvoie les colonnes date / valeur."""
    d = pd.read_csv(_source(fichier, sous_dossier), sep=";", comment="#")
    d = d.dropna(subset=["VALEUR"])
    return pd.DataFrame({
        "date":   pd.to_datetime(d["YYYYMM"].astype(int).astype(str), format="%Y%m"),
        "valeur": pd.to_numeric(d["VALEUR"]),
    }).reset_index(drop=True)


def annuel(d: pd.DataFrame) -> pd.DataFrame:
    """Cumul annuel : somme des douze mois. 84 observations, 1931-2014."""
    g = d.assign(annee=d["date"].dt.year).groupby("annee")["valeur"]
    complet = g.count() == 12               # on écarte les années tronquées
    return (g.sum()[complet].rename("valeur").reset_index())


def lire_externe(nom: str) -> pd.DataFrame:
    """Séries FRED / Yahoo mises en cache par
    04-Data/mettre-a-jour-donnees-externes.R"""
    f = Path("04-Data") / f"{nom}.csv"
    if not f.exists():
        raise FileNotFoundError(
            f"Cache absent : {f}\n  Lancez une fois, depuis la racine du dépôt :\n"
            '    source("04-Data/mettre-a-jour-donnees-externes.R")')
    d = pd.read_csv(f)
    d["date"] = pd.to_datetime(d["date"])
    return d
