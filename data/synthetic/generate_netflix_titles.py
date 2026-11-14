"""Generate a synthetic dataset with the same schema as the Kaggle 'Netflix Movies and TV Shows' CSV.
Replace data/netflix_titles.csv with the real file and the pipeline runs unchanged."""
import csv, random, sys
from datetime import date, timedelta
random.seed(42)
N = 3000
countries = {"United States":30,"India":14,"United Kingdom":8,"Japan":5,"South Korea":5,"Canada":5,"France":4,
 "Spain":3,"Germany":3,"Mexico":3,"Brazil":2,"Australia":2,"Nigeria":2,"Egypt":1,"Turkey":2,"Italy":2}
movie_genres = ["Dramas","Comedies","Documentaries","Action & Adventure","Thrillers","Horror Movies","Romantic Movies",
 "International Movies","Independent Movies","Children & Family Movies","Sci-Fi & Fantasy","Music & Musicals"]
tv_genres = ["TV Dramas","TV Comedies","Crime TV Shows","Reality TV","Docuseries","Kids' TV","International TV Shows",
 "Anime Series","Romantic TV Shows","TV Thrillers","TV Sci-Fi & Fantasy"]
movie_r = ["PG-13","R","PG","TV-MA","TV-14","TV-PG","G","NR"]
tv_r = ["TV-MA","TV-14","TV-PG","TV-Y7","TV-Y","TV-G"]
adj = ["Dark","Last","Silent","Hidden","Broken","Golden","Midnight","Lost","Wild","Secret","Endless","Crimson"]
noun = ["Kingdom","Promise","River","Game","Heist","Summer","Letters","Empire","Garden","Shadow","Road","Signal"]
first = ["Alex","Priya","Kenji","Maria","Chris","Fatima","Liam","Sofia","Raj","Emma","Noah","Aiko","Omar","Lucia","Ben"]
last = ["Smith","Patel","Tanaka","Garcia","Kim","Ali","Brown","Rossi","Singh","Muller","Silva","Lee","Okafor"]
def name(): return f"{random.choice(first)} {random.choice(last)}"
def pick_w(d): return random.choices(list(d), weights=d.values())[0]
rows=[]
for i in range(1, N+1):
    # catalogue grows over time -> skew release years recent
    ry = min(2021, int(2021 - random.expovariate(1/6)))
    ry = max(ry, 1970)
    typ = "Movie" if random.random()<0.69 else "TV Show"
    genres = random.sample(movie_genres if typ=="Movie" else tv_genres, random.choice([1,2,2,3]))
    cs = [pick_w(countries)]
    while random.random()<0.25 and len(cs)<4:
        c=pick_w(countries)
        if c not in cs: cs.append(c)
    country = ", ".join(cs) if random.random()>0.08 else ""
    added = date(max(ry,2008),1,1)+timedelta(days=random.randint(0,(date(2021,9,25)-date(max(ry,2008),1,1)).days))
    if added.year < 2016 and random.random()<0.7: added = date(random.randint(2016,2021),random.randint(1,12),random.randint(1,28))
    dur = f"{max(60,int(random.gauss(100,22)))} min" if typ=="Movie" else (f"{random.choice([1,1,1,2,2,3,4,5])} Season"+"s")
    if dur=="1 Seasons": dur="1 Season"
    rows.append({"show_id":f"s{i}","type":typ,"title":f"The {random.choice(adj)} {random.choice(noun)} {random.choice(['','II','Origins','',''])}".strip()+ (f" {i}" if random.random()<.3 else ""),
      "director":(", ".join(name() for _ in range(random.choice([1,1,2]))) if random.random()>0.3 else ""),
      "cast":", ".join(name() for _ in range(random.randint(2,6))) if random.random()>0.1 else "",
      "country":country,"date_added":(" " if random.random()<.1 else "")+added.strftime("%B %d, %Y").replace(" 0"," "),
      "release_year":ry,"rating":(random.choice(movie_r if typ=="Movie" else tv_r) if random.random()>0.01 else ""),
      "duration":dur,"listed_in":", ".join(genres),"description":"A synthetic title for SQL practice."})
for r in random.sample(rows,8):  # inject exact duplicate titles (different ids) to practice dedup
    d=dict(r); d["show_id"]=f"s{N+len(rows)-N+1}"; rows.append(d)
with open("netflix_titles_synthetic.csv","w",newline="",encoding="utf-8") as f:
    w=csv.DictWriter(f,fieldnames=list(rows[0])); w.writeheader(); w.writerows(rows)
print(len(rows),"rows written")
