drop database if exists agroindustria_db;

create database agroindustria_db;

go

use agroindustria_db;

go

create table setor (
    id int primary key identity(1,1),
    nome varchar(40) not null,
    descricao varchar(255)
);

create table medidas (
    id int primary key identity(1,1),
    id_setor int not null,
    data_hora datetime not null,
    variavel varchar(20) not null,
    valor decimal(10,2) not null,
    foreign key (id_setor) references setor(id)
);

insert into setor (nome, descricao) values
('Moagem', 'Responsável pela extração do caldo da cana-de-açúcar.'),
('Clarificação', 'Remove impurezas do caldo e ajusta pH.'),
('Evaporação', 'Concentra o caldo por remoção de água.'),
('Fermentação', 'Converte açúcares em etanol através de leveduras.'),
('Destilação', 'Separa o etanol produzido na fermentação.'),
('Caldeira', 'Gera vapor para os processos industriais.');

insert into medidas (id_setor, data_hora, variavel, valor) values
(1, '2025-10-09 08:00:00', 'VAZÃO', 210.50),
(1, '2025-10-09 08:10:00', 'TEMP', 32.80),
(2, '2025-10-09 08:20:00', 'PH', 6.45),
(2, '2025-10-09 08:30:00', 'BRIX', 13.20),
(3, '2025-10-09 08:40:00', 'TEMP', 78.50),
(3, '2025-10-09 08:50:00', 'BRIX', 36.70),
(4, '2025-10-09 09:00:00', 'PH', 4.60),
(4, '2025-10-09 09:10:00', 'TEMP', 33.90),
(5, '2025-10-09 09:20:00', 'ETOH', 92.10),
(6, '2025-10-09 09:30:00', 'PRESSÃO', 17.80);

go

select * from setor;

select * from medidas;

select id, variavel, valor
from medidas
order by data_hora desc;

select *
from medidas
where variavel = 'TEMP'
order by valor desc;

select *
from medidas
where variavel = 'BRIX'
and valor between 30 and 80
order by valor asc;

select variavel, count(*) as quantidade
from medidas
group by variavel
order by quantidade desc;

select variavel, avg(valor) as media
from medidas
group by variavel
order by media desc;

select variavel, min(valor) as minimo, max(valor) as maximo
from medidas
group by variavel
order by variavel asc;

select s.nome, avg(m.valor) as media_temperatura
from setor s
inner join medidas m on s.id = m.id_setor
where m.variavel = 'TEMP'
group by s.nome
order by media_temperatura desc;

select s.nome, min(m.valor) as minimo_etoh, max(m.valor) as maximo_etoh
from setor s
inner join medidas m on s.id = m.id_setor
where m.variavel = 'ETOH'
group by s.nome
order by s.nome asc;

select s.nome, count(m.id) as quantidade_medicoes
from setor s
inner join medidas m on s.id = m.id_setor
group by s.nome
order by quantidade_medicoes desc;