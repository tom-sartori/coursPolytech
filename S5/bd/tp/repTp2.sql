1. Donner, pour chaque niveau, le nombre d’exercices disponibles.

SELECT n.NIVEAU, COUNT(IDEX) 
FROM EXERCICE e 
RIGHT JOIN NIVEAU n ON e.NIVEAU = n.NIVEAU
GROUP BY n.NIVEAU

NIVEAU 	COUNT(IDEX)
3eme 		1
4eme 		3
5eme 		3
6eme 		4


2. Donner, pour chaque professeur (NOM) et pour chaque niveau existant, le nombre de devoirs créés, rangés dans l’ordre alphabétique du nom du professeur. Si un professeur n’a créé aucun devoir sur un niveau, il devra apparaitre 0 pour son nombre de devoirs créés dans ce niveau.

SELECT p.NOM, n.NIVEAU, COUNT(d.IDD)
FROM PROF p 
RIGHT JOIN DEVOIR d ON p.IDP = d.PROF_CREATEUR
JOIN NIVEAU n ON d.NIVEAU = n.NIVEAU
GROUP BY p.NOM, n.NIVEAU
ORDER BY 1, 2


NOM	NIVEAU	COUNT(d.IDD)	
Batman	3eme	1	
Bioman	3eme	1	
Bioman	4eme	1	
Bioman	5eme	1	
Hulk		3eme	1	
James Bond	5eme	1	
James Bond	6eme	2	
Superman	4eme	1	
Zorro		4eme	1	


3. Donner pour chaque élève (nom et prénom) et chaque notion disponible, le nombre d’exercices traitant de cette notion sur lesquels il a été évalué. S’il n’a pas été évalué sur une notion, on affichera 0 dans la colonne correspondante.

SELECT el.NOM, el.PRENOM, n.NOTION, COUNT(ex.IDEX)
FROM ELEVE el
LEFT JOIN PASSAGE p ON el.IDEL = p.IDEL
LEFT JOIN DEVOIR d ON p.IDD = d.IDD
JOIN CONTENU c ON d.IDD = c.IDD
RIGHT JOIN EXERCICE ex ON c.IDEX = ex.IDEX
RIGHT JOIN NOTION n ON ex.IDEX = n.IDEXO
GROUP BY el.NOM, el.PRENOM, n.NOTION
ORDER BY 1, 2, 3 

NOM		PRENOM	NOTION		COUNT(ex.IDEX)	
CHOUMIN	KHALIL	calcul litteral	1	
CHOUMIN	KHALIL	geometrie		2	
DUPONT	ARNAUD	calcul litteral	2	
DUPONT	ARNAUD	calcul numerique	8	
DUPONT	ARNAUD	geometrie		3	
DUPONT	MAXIME	calcul litteral	3	
DUPONT	MAXIME	geometrie		2	
GOMAZ		GILLE		calcul litteral	4	
GOMAZ		GILLE		calcul numerique	2	
GOMAZ		GILLE		geometrie		1	
RAMI		ALEXANDRE	calcul litteral	1	
RAMI		ALEXANDRE	calcul numerique	2	
RAMI		ALEXANDRE	geometrie		2	
VIGROS	HELENE	calcul litteral	9	
VIGROS	HELENE	calcul numerique	3	
VIGROS	HELENE	geometrie		3






SELECT NIVEAU
FROM NIVEAU 
where NIVEAU IN (
	(SELECT NIVEAU
	FROM NIVEAU)
	MINUS 
	(SELECT NIVEAU
FROM EXERCICE)
)



4. 

SELECT p.IDD, NOTE, SUM(bareme), NOTE / SUM(bareme)
FROM PASSAGE p 	
JOIN ELEVE e ON p.IDEL = e.IDEL
JOIN CONTENU c ON p.IDD = c.IDD
WHERE nom = 'Dupont' 
AND prenom = 'Arnaud'  
AND NOTE = (
    	SELECT MIN(NOTE)
 	FROM PASSAGE p 
   	JOIN ELEVE e ON p.IDEL = e.IDEL
	WHERE nom = 'Dupont' AND prenom = 'Arnaud')
GROUP BY IDD, NOTE



















