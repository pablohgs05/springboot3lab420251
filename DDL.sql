drop table if exists usr_usuario cascade;
create table usr_usuario (
  usr_id bigint generated always as identity,
  usr_nome varchar(20) not null,
  usr_senha varchar(150) not null,
  primary key (usr_id),
  unique (usr_nome)
);

drop table if exists aut_autorizacao cascade;
create table aut_autorizacao (
  aut_id bigint generated always as identity,
  aut_nome varchar(20) not null,
  primary key (aut_id),
  unique (aut_nome)
);

drop table if exists uau_usuario_autorizacao cascade;
create table uau_usuario_autorizacao (
  usr_id bigint not null,
  aut_id bigint not null,
  primary key (usr_id, aut_id),
  foreign key (usr_id) references usr_usuario (usr_id) on delete restrict on update cascade,
  foreign key (aut_id) references aut_autorizacao (aut_id) on delete restrict on update cascade
);

drop table if exists pro_produto cascade;
create table pro_produto (
  pro_id bigint generated always as identity,
  pro_descricao varchar(100) not null,
  pro_data_hora_anuncio timestamp not null,
  pro_data_hora_lancamento timestamp,
  primary key (pro_id),
  unique(pro_descricao)
);

drop table if exists des_desejo cascade;
create table des_desejo (
  des_id bigint generated always as identity,
  des_lembrete varchar(100),
  des_data_hora_inclusao timestamp not null,
  des_nivel_interesse int not null,
  des_pro_id bigint not null,
  foreign key (des_pro_id) references pro_produto(pro_id),
  unique(des_data_hora_inclusao, des_pro_id),
  primary key (des_id)
);

drop table if exists cot_cotacao cascade;
create table cot_cotacao (
  cot_id bigint generated always as identity,
  cot_data_hora timestamp not null,
  cot_valor float not null,
  cot_comentario varchar(100),
  cot_pro_id bigint not null,
  foreign key (cot_pro_id) references pro_produto(pro_id),
  unique(cot_data_hora, cot_pro_id),
  primary key (cot_id)
);

drop table if exists ant_anotacao cascade;
create table ant_anotacao (
  ant_id bigint generated always as identity,
  ant_texto varchar(256) not null,
  ant_data_hora timestamp not null,
  ant_usr_id bigint not null,
  primary key (ant_id),
  foreign key (ant_usr_id) references usr_usuario(usr_id),
  unique(ant_data_hora, ant_usr_id)
);

drop table if exists tra_trabalho cascade;
create table tra_trabalho (
  tra_id bigint generated always as identity,
  tra_titulo varchar(100) not null unique,
  tra_data_hora_entrega timestamp not null,
  tra_descricao varchar(200),
  tra_grupo varchar(20) not null,
  tra_nota int,
  tra_justificativa varchar(100),
  primary key (tra_id),
  unique(tra_titulo,tra_grupo)
);

drop table if exists rev_revisao cascade;
create table rev_revisao (
  rev_id bigint generated always as identity,
  rev_comentario varchar(100) not null,
  rev_data_hora timestamp not null,
  rev_gravidade int,
  rev_tra_id bigint not null,
  foreign key (rev_tra_id) references tra_trabalho(tra_id),
  unique(rev_data_hora, rev_tra_id),
  primary key (rev_id)
);

drop table if exists con_conteudo cascade;
create table con_conteudo (
  con_id bigint generated always as identity,
  con_texto varchar(200) not null,
  con_data_hora_criacao timestamp not null,
  con_data_hora_publicacao timestamp,
  con_tra_id bigint not null,
  foreign key (con_tra_id) references tra_trabalho(tra_id),
  unique(con_texto, con_tra_id),
  primary key (con_id)
);



insert into usr_usuario (usr_nome, usr_senha) 
  values ('admin', '$2a$10$i3.Z8Yv1Fwl0I5SNjdCGkOTRGQjGvHjh/gMZhdc3e7LIovAklqM6C');
insert into aut_autorizacao (aut_nome) 
  values ('ROLE_ADMIN');
insert into uau_usuario_autorizacao (usr_id, aut_id) 
  values (1, 1);
insert into pro_produto (pro_descricao, pro_data_hora_anuncio, pro_data_hora_lancamento)
  values ('Novo Smartphone', '2025-01-01 09:00', '2025-02-01 10:00'),
         ('Laptop Gamer', '2025-03-01 11:00', null);
insert into des_desejo (des_lembrete, des_data_hora_inclusao, des_nivel_interesse, des_pro_id)
  values ('Gostaria muito de ter esse smartphone', '2025-01-02 10:00', 5, 1),
         ('Preciso de um laptop novo', '2025-03-02 12:00', 4, 2);
insert into cot_cotacao (cot_data_hora, cot_valor, cot_comentario, cot_pro_id)
  values ('2025-01-03 10:00', 2999.99, 'Garantia de 2 anos', 1),
         ('2025-03-03 12:00', 4999.99, 'Inclui acessórios', 2);
insert into ant_anotacao(ant_texto, ant_data_hora, ant_usr_id) 
  values('Meu novo projeto', '2023-08-01 19:10', 1);
insert into tra_trabalho (tra_titulo, tra_data_hora_entrega, tra_descricao, tra_grupo, tra_nota, tra_justificativa) 
  values ('TG', '2025-05-10 10:00', 'Trabalho de graduação', 'Alpha', 6, 'Bom, mas falta conteúdo'),
         ('Guia de instalação', '2025-06-01 17:00', 'Guia para instalação do software', 'Beta', null, 'Incompleto');
insert into rev_revisao (rev_comentario, rev_data_hora, rev_gravidade, rev_tra_id)
  values ('O título precisa melhorar', '2025-05-10 11:20', null, 1),
         ('Use um corretor automárico!', '2025-05-12 17:00', 3, 1);
insert into con_conteudo (con_texto, con_data_hora_criacao, con_data_hora_publicacao, con_tra_id)
  values ('Aqui vai uma introdução', '2025-05-10 10:02', '2025-05-10 10:30', 1),
         ('Meu trabalho inteiro é isso!', '2025-06-01 17:02', null, 2);

--Comente essa linha se o usuario ja existir
create user spring with password 'pass123';

--Permite que o usuario spring possa acessar o banco de dados
grant update, delete, insert, select on all tables in schema public to spring;