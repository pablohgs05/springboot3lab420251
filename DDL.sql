-- Criação do banco de dados
DROP DATABASE IF EXISTS sistema_produtos;
CREATE DATABASE sistema_produtos;
USE sistema_produtos;

-- Tabelas

DROP TABLE IF EXISTS uau_usuario_autorizacao;
DROP TABLE IF EXISTS aut_autorizacao;
DROP TABLE IF EXISTS ant_anotacao;
DROP TABLE IF EXISTS cot_cotacao;
DROP TABLE IF EXISTS des_desejo;
DROP TABLE IF EXISTS con_conteudo;
DROP TABLE IF EXISTS rev_revisao;
DROP TABLE IF EXISTS tra_trabalho;
DROP TABLE IF EXISTS pro_produto;
DROP TABLE IF EXISTS usr_usuario;

CREATE TABLE usr_usuario (
  usr_id BIGINT AUTO_INCREMENT,
  usr_nome VARCHAR(20) NOT NULL,
  usr_senha VARCHAR(150) NOT NULL,
  PRIMARY KEY (usr_id),
  UNIQUE (usr_nome)
);

CREATE TABLE aut_autorizacao (
  aut_id BIGINT AUTO_INCREMENT,
  aut_nome VARCHAR(20) NOT NULL,
  PRIMARY KEY (aut_id),
  UNIQUE (aut_nome)
);

CREATE TABLE uau_usuario_autorizacao (
  usr_id BIGINT NOT NULL,
  aut_id BIGINT NOT NULL,
  PRIMARY KEY (usr_id, aut_id),
  FOREIGN KEY (usr_id) REFERENCES usr_usuario(usr_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (aut_id) REFERENCES aut_autorizacao(aut_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE pro_produto (
  pro_id BIGINT AUTO_INCREMENT,
  pro_descricao VARCHAR(100) NOT NULL,
  pro_data_hora_anuncio DATETIME NOT NULL,
  pro_data_hora_lancamento DATETIME,
  PRIMARY KEY (pro_id),
  UNIQUE (pro_descricao)
);

CREATE TABLE des_desejo (
  des_id BIGINT AUTO_INCREMENT,
  des_lembrete VARCHAR(100),
  des_data_hora_inclusao DATETIME NOT NULL,
  des_nivel_interesse INT NOT NULL,
  des_pro_id BIGINT NOT NULL,
  PRIMARY KEY (des_id),
  UNIQUE (des_data_hora_inclusao, des_pro_id),
  FOREIGN KEY (des_pro_id) REFERENCES pro_produto(pro_id)
);

CREATE TABLE cot_cotacao (
  cot_id BIGINT AUTO_INCREMENT,
  cot_data_hora DATETIME NOT NULL,
  cot_valor FLOAT NOT NULL,
  cot_comentario VARCHAR(100),
  cot_pro_id BIGINT NOT NULL,
  PRIMARY KEY (cot_id),
  UNIQUE (cot_data_hora, cot_pro_id),
  FOREIGN KEY (cot_pro_id) REFERENCES pro_produto(pro_id)
);

CREATE TABLE ant_anotacao (
  ant_id BIGINT AUTO_INCREMENT,
  ant_texto VARCHAR(256) NOT NULL,
  ant_data_hora DATETIME NOT NULL,
  ant_usr_id BIGINT NOT NULL,
  PRIMARY KEY (ant_id),
  UNIQUE (ant_data_hora, ant_usr_id),
  FOREIGN KEY (ant_usr_id) REFERENCES usr_usuario(usr_id)
);

CREATE TABLE tra_trabalho (
  tra_id BIGINT AUTO_INCREMENT,
  tra_titulo VARCHAR(100) NOT NULL,
  tra_data_hora_entrega DATETIME NOT NULL,
  tra_descricao VARCHAR(200),
  tra_grupo VARCHAR(20) NOT NULL,
  tra_nota INT,
  tra_justificativa VARCHAR(100),
  PRIMARY KEY (tra_id),
  UNIQUE (tra_titulo, tra_grupo)
);

CREATE TABLE rev_revisao (
  rev_id BIGINT AUTO_INCREMENT,
  rev_comentario VARCHAR(100) NOT NULL,
  rev_data_hora DATETIME NOT NULL,
  rev_gravidade INT,
  rev_tra_id BIGINT NOT NULL,
  PRIMARY KEY (rev_id),
  UNIQUE (rev_data_hora, rev_tra_id),
  FOREIGN KEY (rev_tra_id) REFERENCES tra_trabalho(tra_id)
);

CREATE TABLE con_conteudo (
  con_id BIGINT AUTO_INCREMENT,
  con_texto VARCHAR(200) NOT NULL,
  con_data_hora_criacao DATETIME NOT NULL,
  con_data_hora_publicacao DATETIME,
  con_tra_id BIGINT NOT NULL,
  PRIMARY KEY (con_id),
  UNIQUE (con_texto, con_tra_id),
  FOREIGN KEY (con_tra_id) REFERENCES tra_trabalho(tra_id)
);

-- Dados iniciais

INSERT INTO usr_usuario (usr_nome, usr_senha) 
VALUES ('admin', '$2a$10$i3.Z8Yv1Fwl0I5SNjdCGkOTRGQjGvHjh/gMZhdc3e7LIovAklqM6C');

INSERT INTO aut_autorizacao (aut_nome) 
VALUES ('ROLE_ADMIN');

INSERT INTO uau_usuario_autorizacao (usr_id, aut_id) 
VALUES (1, 1);

INSERT INTO pro_produto (pro_descricao, pro_data_hora_anuncio, pro_data_hora_lancamento)
VALUES ('Novo Smartphone', '2025-01-01 09:00:00', '2025-02-01 10:00:00'),
       ('Laptop Gamer', '2025-03-01 11:00:00', NULL);

INSERT INTO des_desejo (des_lembrete, des_data_hora_inclusao, des_nivel_interesse, des_pro_id)
VALUES ('Gostaria muito de ter esse smartphone', '2025-01-02 10:00:00', 5, 1),
       ('Preciso de um laptop novo', '2025-03-02 12:00:00', 4, 2);

INSERT INTO cot_cotacao (cot_data_hora, cot_valor, cot_comentario, cot_pro_id)
VALUES ('2025-01-03 10:00:00', 2999.99, 'Garantia de 2 anos', 1),
       ('2025-03-03 12:00:00', 4999.99, 'Inclui acessórios', 2);

INSERT INTO ant_anotacao(ant_texto, ant_data_hora, ant_usr_id) 
VALUES ('Meu novo projeto', '2023-08-01 19:10:00', 1);

INSERT INTO tra_trabalho (tra_titulo, tra_data_hora_entrega, tra_descricao, tra_grupo, tra_nota, tra_justificativa) 
VALUES ('TG', '2025-05-10 10:00:00', 'Trabalho de graduação', 'Alpha', 6, 'Bom, mas falta conteúdo'),
       ('Guia de instalação', '2025-06-01 17:00:00', 'Guia para instalação do software', 'Beta', NULL, 'Incompleto');

INSERT INTO rev_revisao (rev_comentario, rev_data_hora, rev_gravidade, rev_tra_id)
VALUES ('O título precisa melhorar', '2025-05-10 11:20:00', NULL, 1),
       ('Use um corretor automárico!', '2025-05-12 17:00:00', 3, 1);

INSERT INTO con_conteudo (con_texto, con_data_hora_criacao, con_data_hora_publicacao, con_tra_id)
VALUES ('Aqui vai uma introdução', '2025-05-10 10:02:00', '2025-05-10 10:30:00', 1),
       ('Meu trabalho inteiro é isso!', '2025-06-01 17:02:00', NULL, 2);
