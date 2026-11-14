"""Build the SQLite database, run the SQL pipeline and export every analysis query to results/*.csv
and results/REPORT.md.   Usage:  python run_project.py"""
import csv, re, sqlite3, pathlib

ROOT = pathlib.Path(__file__).parent
DB = ROOT / "streaming.db"
CSV = ROOT / "data" / "netflix_titles.csv"
OUT = ROOT / "results"
OUT.mkdir(exist_ok=True)

if not CSV.exists():
    raise SystemExit(f'Missing {CSV}. Download netflix_titles.csv (see README) and place it in data/.')

DB.unlink(missing_ok=True)
con = sqlite3.connect(DB)

# 1. load raw CSV, every column as TEXT (cleaning happens in SQL, not Python)
with open(CSV, newline="", encoding="utf-8") as f:
    rd = csv.reader(f)
    cols = next(rd)
    con.execute("CREATE TABLE netflix_raw (%s)" % ", ".join(f'"{c}" TEXT' for c in cols))
    con.executemany("INSERT INTO netflix_raw VALUES (%s)" % ",".join("?" * len(cols)), rd)

# 2. clean + split
for name in ("01_clean.sql", "02_split.sql"):
    con.executescript((ROOT / "sql" / name).read_text(encoding="utf-8"))

# 3. analysis queries
text = (ROOT / "sql" / "03_analysis.sql").read_text(encoding="utf-8")
blocks = re.split(r"^-- name: ", text, flags=re.M)[1:]
report = ["# Streaming Content Analysis - results\n"]
for b in blocks:
    head, sql = b.split("\n", 1)
    slug, question = [s.strip() for s in head.split("|", 1)]
    cur = con.execute(sql)
    header = [d[0] for d in cur.description]
    rows = cur.fetchall()
    with open(OUT / f"{slug}.csv", "w", newline="", encoding="utf-8") as f:
        w = csv.writer(f); w.writerow(header); w.writerows(rows)
    report.append(f"\n## {slug}\n**{question}**\n")
    report.append("| " + " | ".join(header) + " |")
    report.append("|" + "---|" * len(header))
    for r in rows[:20]:
        report.append("| " + " | ".join("" if v is None else str(v) for v in r) + " |")
    print(f"{slug}: {len(rows)} rows")

(OUT / "REPORT.md").write_text("\n".join(report) + "\n", encoding="utf-8")
con.commit(); con.close()
print("Done -> streaming.db, results/")
