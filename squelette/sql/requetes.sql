-- =============================================================================
-- PARTIE A · Question 3 · Six requetes
-- Sous chaque question : votre requete, puis le resultat obtenu, en commentaire.
-- =============================================================================

-- R1. Les commentaires de l'article 2, du plus recent au plus ancien : nom, texte.
SELECT texte
FROM commentaires
JOIN articles ON articles.id == commentaires.article_id
WHERE article.id = 2
ORDER BY commentaires.cree_le;

-- R2. Le nombre de commentaires de CHAQUE article, y compris ceux qui n'en ont aucun :
--     id, titre, nb_commentaires.


-- R3. Les articles qui n'ont aucun commentaire : id, titre.


-- R4. Pour chaque auteur, le nombre total de commentaires reçus sur ses articles,
--     du plus commente au moins commente.


-- R5. Les visiteurs (nom) qui ont commenté plus d'un article.


-- R6. Les trois commentaires les plus recents, avec le titre de leur article.

