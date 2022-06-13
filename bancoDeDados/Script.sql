-- 01 
-- Criação de tabelas --
CREATE TABLE livro (
    livro_id int not null AUTO_INCREMENT,
    nome varchar(255),
    ano int,
    maximo_tempo_reserva int,
    prateleira int,
    primary key (livro_id)
);

INSERT INTO livro (nome, ano, maximo_tempo_reserva, prateleira)
VALUES ('Duna', 1984, 5, 26);

-- EXERCICIO 01 - sem a utilização do AVG
select livro_id,
	   nome as "Nome do livro",
	   maximo_tempo_reserva
	from livro
	where maximo_tempo_reserva > 11;

select prateleira, avg(maximo_tempo_reserva) AS avg_reserva
FROM livro 
GROUP BY prateleira;

-- Utilizando AVG
select livro_id, nome, maximo_tempo_reserva 
from livro 
where  maximo_tempo_reserva >
	(select avg(maximo_tempo_reserva) 
	 from livro 
     where prateleira = prateleira)
     order by maximo_tempo_reserva asc;


-- EXERCICIO 02 Criando as tabelas --
CREATE TABLE mentores (
    mentor_id int not null AUTO_INCREMENT,
    nome varchar(255),
    sala_de_aula varchar(255),
    primary key (mentor_id)
);

INSERT INTO mentores (nome, sala_de_aula)
VALUES ('Socrates', 'Sala de Aula Jobs');

drop table posts;

CREATE TABLE livraria.posts (
    post_id int not null AUTO_INCREMENT,
    mentor_id int not null,
    descricao varchar(255),
    primary key (post_id),
    foreign key (mentor_id) references mentores(mentor_id)  
);

foreign key (post_id) references posts(post_id)

INSERT INTO posts (mentor_id, descricao)
VALUES (3, 'Post 03');
	
-- EXERCICIO 02 Criando as tabelas --
CREATE TABLE livraria.curtidas (
    mentor_id int not null,
    post_id int not null,
    primary key (post_id, mentor_id)
);

INSERT INTO curtidas (mentor_id, post_id)
VALUES (1,1), (3,2), (3,3);	

-- Ex 02 Parte 01 
select mentores.nome, 
	   count(nome) as "Total de curtidas"
	from mentores
	inner join curtidas on curtidas.mentor_id = mentores.mentor_id
	group by mentores.nome
	order by nome;
	
-- Ex 02 Parte 02 
select mentores.sala_de_aula, posts.post_id
	from mentores
	inner join posts on  posts.post_id = mentores.mentor_id;


-- Ex 02 Parte 03 
select sala_de_aula, avg(post_id)
as media
from mentores 
inner join curtidas on mentores.mentor_id = curtidas.mentor_id
group by (sala_de_aula)
order by sala_de_aula desc;
