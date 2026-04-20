1. HTML /
<div style="background-color: #2d2d2d; padding: 30px; border-radius: 10px; text-align: center; margin-top: 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.3);">
    <h2 style="color: #ffffff; font-family: Arial, sans-serif;">Envoyer un fichier sur Discord</h2>
    
    <p style="color: #bbbbbb; font-family: Arial, sans-serif;">Sélectionne un fichier (image, vidéo, audio, python...) depuis ton PC :</p>
    
    <input type="file" id="selecteur-fichier" style="margin: 20px 0; color: white; background: #1e1e1e; padding: 10px; border-radius: 5px; cursor: pointer; width: 80%;">
    
    <br>
    
    <button id="bouton-envoi" style="padding: 15px 30px; background-color: #5865F2; color: white; font-weight: bold; font-size: 16px; border: none; border-radius: 8px; cursor: pointer; transition: background-color 0.3s;">
        Envoyer vers Discord
    </button>

    <p id="message-statut" style="margin-top: 20px; font-weight: bold; font-family: Arial, sans-serif; font-size: 16px;"></p>
</div>
.

2. JAVASCRIPT /
// C'est ici que tu dois coller l'URL de ton Webhook Discord entre les guillemets !
const urlWebhookDiscord = "COLLE_TON_URL_ICI";

// On récupère les éléments de la page HTML
const boutonEnvoi = document.getElementById('bouton-envoi');
const selecteurFichier = document.getElementById('selecteur-fichier');
const messageStatut = document.getElementById('message-statut');

// Quand tu cliques sur le bouton, cette fonction s'active
boutonEnvoi.addEventListener('click', async function() {
    
    // On vérifie si tu as bien sélectionné un fichier
    if (selecteurFichier.files.length === 0) {
        messageStatut.innerText = "⚠️ Oups ! Tu as oublié de sélectionner un fichier.";
        messageStatut.style.color = "#ffa500"; // Couleur orange
        return; // On arrête tout si pas de fichier
    }

    // On vérifie si l'URL Discord a bien été remplacée
    if (urlWebhookDiscord === "COLLE_TON_URL_ICI" || urlWebhookDiscord === "") {
        messageStatut.innerText = "⚠️ Attention ! Tu n'as pas mis ton lien Discord dans le code GitHub.";
        messageStatut.style.color = "#ffa500";
        return;
    }

    // On récupère le fichier exact que tu as choisi
    const fichierAEnvoyer = selecteurFichier.files[0];
    
    // On prépare le paquet (le formulaire de données) pour l'envoyer à Discord
    const paquetDonnees = new FormData();
    paquetDonnees.append('file', fichierAEnvoyer);
    
    // On peut même ajouter un petit message qui accompagnera le fichier sur Discord
    paquetDonnees.append('content', '🚀 **Nouveau fichier reçu depuis le site DSLDL !**');

    // On met à jour le texte pour te dire que ça travaille
    messageStatut.innerText = "⏳ Envoi en cours vers ton serveur Discord, patiente un instant...";
    messageStatut.style.color = "#3498db"; // Couleur bleue

    try {
        // C'est ici que la magie opère : on expédie le paquet vers Discord
        const reponse = await fetch(urlWebhookDiscord, {
            method: 'POST',
            body: paquetDonnees
        });

        // On vérifie si Discord a bien accepté le fichier
        if (reponse.ok) {
            messageStatut.innerText = "✅ Succès total ! Le fichier est arrivé sur Discord.";
            messageStatut.style.color = "#2ecc71"; // Couleur verte
            
            // On vide la sélection pour que tu puisses en envoyer un autre
            selecteurFichier.value = ""; 
        } else {
            // Si Discord refuse, on affiche l'erreur
            messageStatut.innerText = "❌ Une erreur s'est produite lors de l'envoi : " + reponse.statusText;
            messageStatut.style.color = "#e74c3c"; // Couleur rouge
        }
        
    } catch (erreur) {
        // Si ta connexion coupe ou si l'URL est cassée
        messageStatut.innerText = "❌ Impossible de contacter Discord : " + erreur.message;
        messageStatut.style.color = "#e74c3c";
    }
});
.
