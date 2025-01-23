USE db_architecte;
 
/* 1. Sélectionner l'identifiant, le nom de tous les clients dont le numéro de téléphone commence par '04' */
SELECT client_ref, client_nom
FROM clients
WHERE client_telephone LIKE "04%";
 
/* 2. Sélectionner l'identifiant, le nom et le type de tous les clients qui sont des particuliers */
SELECT client_ref, client_nom, type_client_libelle
FROM clients 
JOIN type_clients ON type_clients.type_client_id = clients.type_client_id
WHERE type_client_libelle = "Particulier";
 
/* 3. Sélectionner l'identifiant, le nom et le type de tous les clients qui ne sont pas des particuliers */
SELECT client_ref, client_nom, type_client_libelle
FROM clients 
JOIN type_clients ON type_clients.type_client_id = clients.type_client_id
WHERE type_client_libelle != "Particulier";
 
/* 4. Sélectionner les projets qui ont été livrés en retard */
SELECT *
FROM projets
WHERE projet_date_fin_effective > projet_date_fin_prevue;
 
/* 5. Sélectionner la date de dépôt, la date de fin prévue, les superficies, le prix de tous les projets avec le nom du client et le nom de l'architecte associés au projet */
SELECT projet_date_depot, projet_date_fin_prevue, projet_superficie_totale, projet_prix, client_nom, emp_nom
FROM projets
JOIN clients ON clients.client_ref = projets.client_ref
JOIN employes ON employes.emp_matricule = projets.emp_matricule
JOIN fonctions ON fonctions.fonction_id = employes.fonction_id;
 
/* 6. Sélectionner tous les projets (dates, superficies, prix) avec le nombre d'intervenants autres que le client et l'architecte */
SELECT participer.projet_ref, projet_date_depot, projet_superficie_totale, projet_prix, COUNT(participer.emp_matricule)
FROM projets
JOIN participer ON participer.projet_ref = projets.projet_ref
GROUP BY participer.projet_ref;
 
/* 7. Sélectionner les types de projets avec, pour chacun d'entre eux, le nombre de projets associés et le prix moyen pratiqué */
SELECT tp.type_projet_id, tp.type_projet_libelle, COUNT(projet_ref), AVG(projet_prix)
FROM type_projets tp
JOIN projets ON projets.type_projet_id = tp.type_projet_id
GROUP BY tp.type_projet_libelle;
 
/* 8. Sélectionner les types de travaux avec, pour chacun d'entre eux, la superficie du projet la plus grande */
SELECT tp.type_travaux_id, tp.type_travaux_libelle, max(projet_superficie_totale)
FROM type_travaux tp
JOIN projets ON projets.type_travaux_id = tp.type_travaux_id
GROUP BY tp.type_travaux_id;
 
/* 9. Sélectionner l'ensembles des projets (dates, prix) avec les informations du client (nom, telephone, adresse), le type de travaux et le type de projet. */
SELECT projet_date_depot, projet_prix, client_nom, client_telephone, adresse_ville, type_travaux_libelle, type_projet_libelle
FROM projets
JOIN clients ON clients.client_ref = projets.client_ref
JOIN adresses ON adresses.adresse_id = projets.adresse_id
JOIN type_travaux ON type_travaux.type_travaux_id = projets.type_travaux_id
JOIN type_projets ON type_projets.type_projet_id = projets.type_projet_id;
 
/* 10. Sélectionner les projets dont l'adresse est identique au client associé */
SELECT projet_ref, projets.adresse_id, clients.adresse_id
FROM projets
JOIN clients ON clients.client_ref = projets.client_ref
JOIN adresses ON adresses.adresse_id = projets.adresse_id
WHERE projets.adresse_id = clients.adresse_id;