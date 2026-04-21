1. HTML /
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page de Sélection</title>
    <style>
        /* --- Style global de la page --- */
        body {
            background-color: #050505; /* Fond noir */
            color: #ffffff; /* Texte en blanc */
            font-family: Arial, sans-serif;
            display: flex; /* Pour aligner les deux cadres côte à côte */
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            gap: 50px; /* L'espace qui sépare les deux cadrages */
        }

        /* --- Style des cadrages (les deux grandes boîtes) --- */
        .cadrage {
            background-color: #1a1a1a; /* Un noir légèrement plus clair pour qu'on voie le cadre */
            border: 3px solid transparent; /* Bordure invisible par défaut */
            border-radius: 25px; /* Le carré avec des rondeurs pour le cadre */
            padding: 30px;
            width: 300px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            transition: all 0.4s ease; /* Animation fluide */
        }

        /* --- Style des images --- */
        .cadrage img {
            width: 200px;
            height: 200px;
            object-fit: cover;
            border: 3px solid transparent; /* Bordure invisible par défaut */
            border-radius: 20px; /* Le carré avec des rondeurs pour l'image */
            margin-bottom: 15px;
            transition: all 0.4s ease;
        }

        /* --- Style du sous-titre --- */
        .sous-titre {
            font-size: 1.2rem;
            margin-bottom: 25px;
            font-weight: bold;
        }

        /* --- Style des boutons --- */
        .cadrage a.bouton {
            display: inline-block;
            background-color: transparent;
            color: #ffffff;
            text-decoration: none;
            font-size: 1.1rem;
            font-weight: bold;
            padding: 15px 30px;
            border: 3px solid #555555; /* Bordure grise par défaut */
            border-radius: 15px; /* Le carré avec des rondeurs pour le bouton */
            transition: all 0.3s ease; /* Animation fluide */
        }

        /* =====================================================================
           EFFETS DE SURVOL (HOVER) AU CURSEUR
           ===================================================================== */

        /* 1. Quand on pointe UNIQUEMENT sur le bouton */
        .cadrage a.bouton:hover {
            transform: scale(1.15); /* Le bouton grossit bien */
            border-color: #00ff00; /* Contour du bouton en vert */
            /* Effet "brouillé" / lumineux autour du bouton */
            box-shadow: 0 0 20px 5px rgba(0, 255, 0, 0.6); 
            background-color: rgba(0, 255, 0, 0.1);
        }

        /* 2. Quand on pointe sur TOUT LE CADRAGE */
        .cadrage:hover {
            border-color: #00ff00; /* Le cadrage se met en vert */
            box-shadow: 0 0 15px rgba(0, 255, 0, 0.2);
        }

        /* Quand on pointe sur le cadrage, l'image prend aussi le contour vert */
        .cadrage:hover img {
            border-color: #00ff00;
        }

        /* Quand on pointe sur le cadrage, le bouton prend aussi le contour vert 
           (même si on n'est pas directement sur le bouton) */
        .cadrage:hover a.bouton {
            border-color: #00ff00;
        }
    </style>
</head>
<body>

    <div class="cadrage">
        <img src="" alt="Image descriptive 1">
        
        <div class="sous-titre">Sous-titre du premier choix</div>
        
        <a href="" class="bouton">Aller sur le site 1</a>
    </div>

    <div class="cadrage">
        <img src="" alt="Image descriptive 2">
        
        <div class="sous-titre">Sous-titre du deuxième choix</div>
        
        <a href="" class="bouton">Aller sur le site 2</a>
    </div>

</body>
</html>
.
