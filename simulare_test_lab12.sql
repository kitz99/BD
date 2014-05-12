--Rezolvari

--Problema1
select * from MAGAZIN m, STOC s, PRODUS pr 
      where m.id_magazin = s.cod_magazin and pr.id_produs = s.cod_produs and pr.denumire='nexus 7' 
      and s.pret = (select min(pret) from STOC s, PRODUS p where p.id_produs = s.cod_produs and p.denumire = 'nexus 7');
      
--Problema2
select id_producator, nume, count(distinct b), count(distinct i)
from
(select pd.id_producator, PD.NUME,
decode(M.ORAS, 'Bucuresti', s.cod_magazin, null) b,
decode(M.ORAS, 'Iasi', s.cod_magazin, null) i
from produs p, producator pd, stoc s, magazin m
where p.cod_producator = pd.id_producator
and p.id_produs = s.cod_produs
and s.cod_magazin = m.id_magazin)
group by id_producator, nume
having count(distinct b) >= 2 and count(distinct i) >=1 ;