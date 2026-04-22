1. PYTHON /
import os
import shutil

# --- DONNÉES DU CATALOGUE ---
mangas = [
    {
        "id": "maitresse-et-eleve",
        "title": "MOBY DICK",
        "cover": "https://raw.githubusercontent.com/Audinay/Manga-List-X/refs/heads/main/t%C3%A9l%C3%A9chargement.jpg",
        "synopsis": "Un soir, Hoon-sang se retrouve en possession d’une mystérieuse carte de visite. La carte lui promet une nouvelle vie dans une ville où le sexe et l’adultère sont rois, pour peu qu’il soit prêt à échanger son corps pour de l’argent. « Tu es un ‘cadeau’ pour nos VIPs. Fais en sorte qu’elles ne t’oublient jamais… Qu’elles le veuillent ou non. »",
        "chapters": [
            {
                "id": "chapitre-0",
                "title": "Chapitre 0 - Le commencement",
                "images": ["https://raw.githubusercontent.com/Audinay/Manga-List-X/refs/heads/main/Capture%20d'%C3%A9cran%202026-04-14%20151916.png", "https://raw.githubusercontent.com/Audinay/Manga-List-X/refs/heads/main/Capture%20d'%C3%A9cran%202026-04-14%20151953.png", "https://raw.githubusercontent.com/Audinay/Manga-List-X/refs/heads/main/Capture%20d'%C3%A9cran%202026-04-14%20152001.png", "https://raw.githubusercontent.com/Audinay/Manga-List-X/refs/heads/main/Capture%20d'%C3%A9cran%202026-04-14%20152102.png", "https://raw.githubusercontent.com/Audinay/Manga-List-X/refs/heads/main/Capture%20d'%C3%A9cran%202026-04-14%20152118.png", "https://raw.githubusercontent.com/Audinay/Manga-List-X/refs/heads/main/Capture%20d'%C3%A9cran%202026-04-14%20152129.png", "https://raw.githubusercontent.com/Audinay/Manga-List-X/refs/heads/main/Capture%20d'%C3%A9cran%202026-04-14%20152137.png", "https://raw.githubusercontent.com/Audinay/Manga-List-X/refs/heads/main/Capture%20d'%C3%A9cran%202026-04-14%20152146.png", "https://raw.githubusercontent.com/Audinay/Manga-List-X/refs/heads/main/Capture%20d'%C3%A9cran%202026-04-14%20152156.png", "https://raw.githubusercontent.com/Audinay/Manga-List-X/refs/heads/main/Capture%20d'%C3%A9cran%202026-04-14%20152207.png"]
            },
            {
                "id": "chapitre-1",
                "title": "Chapitre 1 - La découverte",
                "images": ["chap1_page1.jpg", "chap1_page2.jpg", "chap1_page3.jpg"]
            }
        ]
    },
    {
        "id": "autre-manga",
        "title": "Titre du Second Manga",
        "cover": "cover_autre.jpg",
        "synopsis": "Ceci est un exemple pour te montrer comment le catalogue affiche plusieurs œuvres côte à côte en forme de grille.",
        "chapters": [
            {
                "id": "chapitre-1",
                "title": "Chapitre 1",
                "images": ["autre_c1_p1.jpg", "autre_c1_p2.jpg"]
            }
        ]
    }
]

# --- CONFIGURATION DES DOSSIERS ---
OUTPUT_DIR = "dist"

def create_dir(path):
    if not os.path.exists(path):
        os.makedirs(path)

if os.path.exists(OUTPUT_DIR):
    shutil.rmtree(OUTPUT_DIR)
create_dir(OUTPUT_DIR)
create_dir(os.path.join(OUTPUT_DIR, "images"))

# --- TEMPLATES HTML/CSS/JS INTÉGRÉS ---
CSS_STYLES = """
<style>
    :root { 
        --bg-color: #121212; 
        --text-color: #ffffff; 
        --accent-color: #e50914; 
        --card-bg: #1e1e1e; 
    }
    body { 
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        background-color: var(--bg-color); 
        color: var(--text-color); 
        margin: 0; 
        padding: 0; 
    }
    a { color: var(--text-color); text-decoration: none; }
    a:hover { color: var(--accent-color); }
    header { 
        background-color: #000; 
        padding: 20px; 
        text-align: center; 
        border-bottom: 2px solid var(--accent-color); 
    }
    h1, h2, h3 { margin: 0; }
    .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
    
    .grid { 
        display: grid; 
        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); 
        gap: 25px; 
        margin-top: 20px; 
    }
    .card { 
        background-color: var(--card-bg); 
        border-radius: 8px; 
        overflow: hidden; 
        transition: transform 0.3s ease, box-shadow 0.3s ease; 
        display: flex;
        flex-direction: column;
    }
    .card:hover { 
        transform: translateY(-5px); 
        box-shadow: 0 10px 20px rgba(229, 9, 20, 0.4); 
    }
    .card img { width: 100%; height: 320px; object-fit: cover; }
    .card-content { padding: 15px; text-align: center; }
    
    .manga-header { 
        display: flex; 
        flex-wrap: wrap;
        gap: 30px; 
        margin-bottom: 40px; 
        background: var(--card-bg); 
        padding: 20px; 
        border-radius: 10px; 
    }
    .manga-cover { width: 250px; border-radius: 8px; object-fit: cover; }
    .manga-info { flex: 1; min-width: 300px; }
    
    .controls { 
        margin-bottom: 20px; 
        display: flex; 
        justify-content: space-between; 
        align-items: center; 
        background: #000;
        padding: 15px;
        border-radius: 8px;
    }
    .sort-btn { 
        background-color: var(--accent-color); 
        color: white; 
        border: none; 
        padding: 10px 20px; 
        border-radius: 5px; 
        cursor: pointer; 
        font-weight: bold; 
        transition: background 0.3s;
    }
    .sort-btn:hover { background-color: #b20710; }
    
    .chapter-list { display: flex; flex-direction: column; gap: 10px; }
    .chapter-item { 
        background-color: var(--card-bg); 
        padding: 15px 20px; 
        border-radius: 5px; 
        display: flex; 
        justify-content: space-between; 
        align-items: center;
        transition: background 0.2s; 
        font-weight: bold;
    }
    .chapter-item:hover { background-color: #333; color: var(--accent-color); }
    
    .reader { 
        display: flex; 
        flex-direction: column; 
        align-items: center; 
        background-color: #000; 
        padding-top: 20px;
    }
    .reader img { 
        max-width: 100%; 
        width: 800px; 
        display: block; 
        margin-bottom: 0; 
    }
    .reader-nav { 
        width: 100%; 
        padding: 15px 30px; 
        background: #111; 
        display: flex; 
        justify-content: space-between; 
        align-items: center;
        position: sticky; 
        top: 0; 
        box-shadow: 0 2px 10px rgba(0,0,0,0.8); 
        box-sizing: border-box;
    }
    .reader-nav a {
        background: #333;
        padding: 8px 15px;
        border-radius: 5px;
        transition: background 0.3s;
    }
    .reader-nav a:hover {
        background: var(--accent-color);
    }
</style>
"""

INDEX_TEMPLATE = f"""<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalogue - Mangas</title>
    {CSS_STYLES}
</head>
<body>
    <header>
        <h1>Bibliothèque de Mangas</h1>
    </header>
    <div class="container">
        <div class="grid">
            {{manga_cards}}
        </div>
    </div>
</body>
</html>"""

MANGA_TEMPLATE = f"""<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{title}}</title>
    {CSS_STYLES}
</head>
<body>
    <header>
        <h1><a href="../index.html">← Retour au Catalogue</a></h1>
    </header>
    <div class="container">
        <div class="manga-header">
            <img src="{{cover}}" alt="Couverture de {{title}}" class="manga-cover">
            <div class="manga-info">
                <h2>{{title}}</h2>
                <p style="margin-top: 20px; line-height: 1.6; font-size: 1.1em; color: #ccc;">{{synopsis}}</p>
            </div>
        </div>
        
        <div class="controls">
            <h3 style="margin: 0;">Liste des Chapitres</h3>
            <button class="sort-btn" onclick="toggleSort()">Trier: Ordre Décroissant</button>
        </div>
        
        <div class="chapter-list" id="chapter-list">
            {{chapters_list}}
        </div>
    </div>

    <script>
        let isAscending = true;
        function toggleSort() {{
            const list = document.getElementById('chapter-list');
            const items = Array.from(list.children);
            items.reverse();
            list.innerHTML = '';
            items.forEach(item => list.appendChild(item));
            
            isAscending = !isAscending;
            const btn = document.querySelector('.sort-btn');
            btn.textContent = isAscending ? "Trier: Ordre Décroissant" : "Trier: Ordre Croissant";
        }}
    </script>
</body>
</html>"""

CHAPTER_TEMPLATE = f"""<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{manga_title}} - {{chapter_title}}</title>
    {CSS_STYLES}
</head>
<body style="background-color: #000;">
    <div class="reader-nav">
        <a href="index.html">← Retour aux chapitres</a>
        <span style="font-weight: bold; font-size: 1.2em;">{{chapter_title}}</span>
        <span></span> 
    </div>
    
    <div class="reader">
        {{images_list}}
    </div>
</body>
</html>"""


# --- LOGIQUE DE GÉNÉRATION DES FICHIERS ---

print("Début de la génération de ton site de mangas...")

# 1. Génération des cartes
manga_cards_html = ""
for manga in mangas:
    manga_cards_html += f"""
    <a href="{manga['id']}/index.html" class="card">
        <img src="{manga['cover']}" alt="{manga['title']}">
        <div class="card-content">
            <h3>{manga['title']}</h3>
        </div>
    </a>
    """

# Écriture index.html (CORRECTION ICI: un seul crochet)
with open(os.path.join(OUTPUT_DIR, "index.html"), "w", encoding="utf-8") as f:
    f.write(INDEX_TEMPLATE.replace("{manga_cards}", manga_cards_html))


# 2. Génération des pages internes
for manga in mangas:
    manga_dir = os.path.join(OUTPUT_DIR, manga["id"])
    create_dir(manga_dir)
    
    chapters_list_html = ""
    for chapter in manga["chapters"]:
        chapters_list_html += f"""
        <a href="{chapter['id']}.html" class="chapter-item">
            <span>{chapter['title']}</span>
            <span style="color: var(--accent-color);">Lire le chapitre →</span>
        </a>
        """
        
        images_html = ""
        for img in chapter["images"]:
            images_html += f'<img src="{img}" alt="Page de manga" loading="lazy">\n'
            
        # Écriture du chapitre (CORRECTION ICI: un seul crochet)
        chapter_html = CHAPTER_TEMPLATE \
            .replace("{manga_title}", manga["title"]) \
            .replace("{chapter_title}", chapter["title"]) \
            .replace("{images_list}", images_html)
            
        with open(os.path.join(manga_dir, f"{chapter['id']}.html"), "w", encoding="utf-8") as f:
            f.write(chapter_html)

    # Écriture de la page manga (CORRECTION ICI: un seul crochet)
    manga_html = MANGA_TEMPLATE \
        .replace("{title}", manga["title"]) \
        .replace("{cover}", manga["cover"]) \
        .replace("{synopsis}", manga["synopsis"]) \
        .replace("{chapters_list}", chapters_list_html)
        
    with open(os.path.join(manga_dir, "index.html"), "w", encoding="utf-8") as f:
        f.write(manga_html)

print("Génération terminée avec succès !")
print("Tous tes fichiers sont prêts dans le dossier 'dist'.")
.
