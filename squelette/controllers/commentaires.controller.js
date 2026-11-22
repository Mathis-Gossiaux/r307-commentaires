// CONTROLEUR des commentaires.
// A ECRIRE : une fonction (req, res, next) par route de CONTRAT.md, comme dans
// controllers/articles.controller.js :
//   1. lire req.params, req.query, req.body ;
//   2. verifier la forme : 400 si un champ obligatoire manque ;
//   3. appeler le service (services/commentaires.service.js) ;
//   4. choisir le code (200, 201 ou 204). Toute erreur part vers next(err).
// Le controleur ne parle JAMAIS a la base : pas de pool ici, seulement le service.
const service = require('../services/commentaires.service');
const ErreurHttp = require('../utils/erreur-http');

function listerParArticle(req, res, next) {
  service.lister(Number(req.params.id))
    .then((liste) => res.json(liste))
    .catch(next);
}

function creer(req, res, next) {
  const { nom, texte } = req.body || {};
  if (!nom || !texte) {
    return next(new ErreurHttp(400, 'champ manquant', 'Les champs nom et texte ne peuvent pas être vides'));
  }
  service.creer(Number(req.params.id), { nom, texte })
    .then((commentaire) => res.status(201).json(commentaire))
    .catch(next);
}

function parVisiteur(req, res, next) {
  const { nom } = req.query;
  if (!nom) return next(new ErreurHttp(400, 'nom manquant', 'Le nom est obligatoire'));
  service.parVisiteur(nom)
    .then((liste) => res.json(liste))
    .catch(next);
}

function trouver(req, res, next) {
  service.trouver(Number(req.params.id))
    .then((commentaire) => res.json(commentaire))
    .catch(next);
}

function modifier(req, res, next) {
  const { texte } = req.body || {};
  if (!texte) return next(new ErreurHttp(400, 'texte manquant', 'Le champ texte est obligatoire'));
  service.modifier(Number(req.params.id), { texte })
    .then((commentaire) => res.json(commentaire))
    .catch(next);
}

function supprimer(req, res, next) {
  service.supprimer(Number(req.params.id))
    .then(() => res.status(204).end())
    .catch(next);
}

module.exports = { listerParArticle, creer, parVisiteur, trouver, modifier, supprimer };