"""Render README charts from the exported query results. Usage: python make_charts.py (after run_project.py)"""
import csv, pathlib
import matplotlib; matplotlib.use("Agg")
import matplotlib.pyplot as plt
R = pathlib.Path(__file__).parent / "results"; (R / "charts").mkdir(exist_ok=True)
rd = lambda n: list(csv.DictReader(open(R / f"{n}.csv", encoding="utf-8")))
RED = "#E50914"

def style(ax, title):
    ax.set_title(title, loc="left", fontweight="bold")
    for s in ("top", "right"): ax.spines[s].set_visible(False)

y = [r for r in rd("q03_type_share_by_year") if int(r["year_added"]) >= 2014]
fig, ax = plt.subplots(figsize=(8, 4))
yrs = [r["year_added"] for r in y]
ax.bar(yrs, [int(r["movies"]) for r in y], color=RED, label="Movies")
ax.bar(yrs, [int(r["tv_shows"]) for r in y], bottom=[int(r["movies"]) for r in y], color="#221F1F", label="TV Shows")
ax.legend(frameon=False); style(ax, "Titles added per year (2021 is a partial year)")
fig.tight_layout(); fig.savefig(R / "charts" / "added_per_year.png", dpi=150)

c = rd("q04_top_countries")[::-1]
fig, ax = plt.subplots(figsize=(8, 4))
ax.barh([r["country"] for r in c], [int(r["titles"]) for r in c], color=RED)
style(ax, "Top 10 countries by number of titles"); fig.tight_layout()
fig.savefig(R / "charts" / "top_countries.png", dpi=150)

g = [r for r in rd("q07_genre_trend") if int(r["early"]) >= 100]
g = sorted(g, key=lambda r: float(r["growth_pct"]))
fig, ax = plt.subplots(figsize=(8, 5))
ax.barh([r["genre"] for r in g], [float(r["growth_pct"]) for r in g],
        color=[RED if float(r["growth_pct"]) > 0 else "#777" for r in g])
style(ax, "Genre growth, titles added 2019-21 vs 2016-18 (%)")
fig.tight_layout(); fig.savefig(R / "charts" / "genre_growth.png", dpi=150)
print("charts written")
