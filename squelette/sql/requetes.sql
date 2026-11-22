-- =============================================================================
-- PARTIE A · Question 3 · Six requetes
-- Sous chaque question : votre requete, puis le resultat obtenu, en commentaire.
-- =============================================================================

-- R1. Les commentaires de l'article 2, du plus recent au plus ancien : nom, texte.
SELECT texte
FROM commentaires
WHERE article_id = 2
ORDER BY cree_le;

/*
| texte |
| :--- |
| Le noyer est magnifique. Combien de temps pour le séchage ? |
| Des photos de la pose seraient les bienvenues. |
 */

-- R2. Le nombre de commentaires de CHAQUE article, y compris ceux qui n'en ont aucun :
--     id, titre, nb_commentaires.
SELECT articles.id, articles.titre, COUNT(commentaires.id) AS nb_commentaires
FROM articles
LEFT JOIN commentaires ON commentaires.article_id = articles.id
GROUP BY articles.id, articles.titre
ORDER BY articles.id;

/*
| id | titre | nb\_commentaires |
| :--- | :--- | :--- |
| 1 | Choisir son bois pour une table de jardin | 3 |
| 2 | Une bibliothèque sur mesure à Besançon | 2 |
| 3 | Huile ou vernis : ce qui protège vraiment | 0 |
| 4 | Restaurer une chaise paillée | 1 |
| 5 | Une cuisine en chêne massif à Dole | 2 |
| 6 | Affûter ses ciseaux à bois | 0 |
 */

-- R3. Les articles qui n'ont aucun commentaire : id, titre.
SELECT articles.id, articles.titre
FROM articles
WHERE NOT EXISTS (
    SELECT 1
    FROM commentaires
    WHERE commentaires.article_id = articles.id
);

/*
| id | titre |
| :--- | :--- |
| 6 | Affûter ses ciseaux à bois |
| 3 | Huile ou vernis : ce qui protège vraiment |
 */

-- R4. Pour chaque auteur, le nombre total de commentaires reçus sur ses articles,
--     du plus commente au moins commente.
SELECT auteurs.id, auteurs.prenom AS auteur, COUNT(commentaires.id) AS nb_commentaires
FROM auteurs
JOIN articles ON articles.auteur_id = auteurs.id
LEFT JOIN commentaires ON commentaires.article_id = articles.id
GROUP BY auteurs.id, auteurs.prenom
ORDER BY nb_commentaires DESC;

/*
| id | auteur | nb\_commentaires |
| :--- | :--- | :--- |
| 1 | Marc | 5 |
| 3 | Théo | 2 |
| 2 | Sophie | 1 |
 */

-- R5. Les visiteurs (nom) qui ont commenté plus d'un article.
SELECT nom, COUNT(DISTINCT article_id) AS nb_articles
FROM commentaires
GROUP BY nom
HAVING COUNT(DISTINCT article_id) > 1;

/*
| nom | nb\_articles |
| :--- | :--- |
| Claire | 2 |
 */

-- R6. Les trois commentaires les plus recents, avec le titre de leur article.
SELECT c.id, c.nom, c.texte, c.cree_le, a.titre AS titre_article
FROM commentaires c
JOIN articles a ON a.id = c.article_id
ORDER BY c.cree_le DESC
LIMIT 3;

/*
| id | nom | texte | cree\_le | titre\_article |
| :--- | :--- | :--- | :--- | :--- |
| 8 | Karim | Superbe travail. | 2026-10-18 17:47:00.000000 +00:00 | Une cuisine en chêne massif à Dole |
| 7 | Claire | Aucune vis visible : comment sont fixés les caissons ? | 2026-10-16 12:22:00.000000 +00:00 | Une cuisine en chêne massif à Dole |
| 6 | Lucie | J'ai une chaise à faire refaire, vous prenez les commandes ? | 2026-10-09 07:00:00.000000 +00:00 | Restaurer une chaise paillée |
 */