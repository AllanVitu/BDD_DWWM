/*exo1*/
-- Quels sont les vols au départ de Paris entre 12h et 14h ?
select * from vol where VD = 'PARIS' and HD between 12 and 14 ;
/*exo2*/
-- Quels sont les pilotes dont le nom commence par "S" ?
select * from PILOTE where PILNOM like 'S%'
/*exo3*/
-- Pour chaque ville, donner le nombre et les capacites minimum et maximum des avions qui s y trouvent.
SELECT 
    COUNT(*) AS nbAvion, 
    MIN(CAP) AS CapMini, 
    MAX(CAP) AS CapMax, 
    LOC 
FROM 
    your_table_name
GROUP BY 
    LOC;

/*exo4*/
-- Pour chaque ville, donner la capacite moyenne des avions qui s y trouvent et cela par type d avion.
select count (*)as [nbAvion],avg (CAP)as [capMoyen], LOC, AVMARQ from AVION group by LOC, AVMARQ order by LOC;
/*exo5*/
-- Quelle est la capacite moyenne des avions pour chaque ville ayant plus de 1 avion ?
select count (AV) as [numAvion],avg (CAP) as [CapMoyen], LOC from AVION group by LOC having Count(AV) > 1; 
/*6*/
-- Quels sont les noms des pilotes qui habitent dans la ville de localisation d'un Airbus 
select PILNOM, ADR from PILOTE where ADR in (select LOC from AVION where AVMARQ = 'AIRBUS');
select PILNOM, ADR, LOC from PILOTE, AVION where ADR = LOC and AVMARQ = 'AIRBUS';
/*7*/
-- Quels sont les noms des pilotes qui conduisent un Airbus et qui habitent dans la ville de localisation d'un Airbus ?
select PILNOM from PILOTE where ADR in(select LOC from AVION where AVMARQ = 'AIRBUS') and
PIL in (select PIL from VOL, AVION where AVION.AV = VOL.AV and AVMARQ = 'AIRBUS');
select distinct PILNOM, ADR from VOL, AVION, PILOTE where VOL.AV = AVION.AV and PILOTE.PIL = VOL.PIL and 
AVMARQ = 'AIRBUS' and ADR in(select LOC from AVION where AVMARQ = 'AIRBUS');
/*8*/
-- Quels sont les noms des pilotes qui conduisent un Airbus ou qui habitent dans la ville de localisation d'un Airbus ?
select PILNOM from PILOTE where ADR in(select LOC from AVION where AVMARQ = 'AIRBUS') or
PIL in (select PIL from VOL, AVION where AVION.AV = VOL.AV and AVMARQ = 'AIRBUS');
/*9*/
-- Quels sont les noms des pilotes qui conduisent un Airbus sauf ceux qui habitent dans la ville de localisation d'un Airbus ?
select PILNOM from PILOTE where ADR not in(select LOC from AVION where AVMARQ = 'AIRBUS') and
PIL in (select PIL from VOL, AVION where AVION.AV = VOL.AV and AVMARQ = 'AIRBUS');
/*10*/
-- Quels sont les vols ayant un trajet identique ( VD, VA ) à ceux assurés par Serge ?
select id_VOL, PILNOM, VD, VA from VOL,PILOTE where VOL.PIL = PILOTE.PIL and VD 
in(select VD from VOL, PILOTE where VOL.PIL = PILOTE.PIL and PILNOM = 'SERGE') and
VA in(select VA from VOL, PILOTE where VOL.PIL = PILOTE.PIL and PILNOM = 'SERGE') and PILNOM <> 'SERGE';
/*11*/
-- Donner toutes les paires de pilotes habitant la même ville ( sans doublon )
select P1.PILNOM, P2.PILNOM from PILOTE P1, PILOTE P2 
where P1.ADR = P2.ADR and P1.PILNOM < P2.PILNOM;

-- 12	Quels sont les noms des pilotes 
-- qui conduisent un avion que conduit aussi le pilote n°1 ?

select pil,pilnom from pilote where pil in(select distinct pil from vol where av in (select av from vol where pil=1)) and pil!=1;

-- 13	Donner toutes les paires de villes telles qu'un avion localisé 
-- dans la ville de depart soit conduit par un pilote residant dans la ville darrivee

SELECT vd,va, loc, adr, pilnom from vol,pilote,avion where vol.pil=pilote.pil and vol.av=avion.av
and  vd=loc and adr=va;

-- 14	Sélectionner les numéros des pilotes qui conduisent tous les Airbus ?

select distinct pilnom from pilote,avion,vol where vol.pil=pilote.pil and avion.av=vol.av 
and vol.av =all(select vol.av from vol,avion where vol.av=avion.av and avmarq='AIRBUS');