CREATE TABLE IF NOT EXISTS usuario (
    id_usuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(100),
    avatar VARCHAR(255),
    banner VARCHAR(255),
    data_nasc DATE,
    tipo INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Conta (
    id_conta INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    renda DECIMAL(10,2) NOT NULL,
    progresso DECIMAL(10,2) NOT NULL,
    status INT,
    fk_usuario INT NOT NULL,
    FOREIGN KEY (fk_usuario) REFERENCES Usuario (id_usuario)
);

CREATE TABLE IF NOT EXISTS Objetivo (
    id_objetivo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    categoria VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS ObjetivoConta (
    id_objetivo_conta INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    fk_conta INT NOT NULL,
    fk_objetivo INT NOT NULL,
    descricao VARCHAR(100),
    done INT,
    valor_total DECIMAL(10,2),
    valor_inicial DECIMAL(10,2),
    tempo_estimado DATETIME(0),
    pontuacao DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fk_conta) REFERENCES Conta (id_conta),
    FOREIGN KEY (fk_objetivo) REFERENCES Objetivo (id_objetivo)
);

CREATE TABLE IF NOT EXISTS Task (
    id_task INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    categoria VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS TaskObjetivo (
    id_task_objetivo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    fk_task INT NOT NULL,
    fk_objetivo INT NOT NULL,
    ordem INT NOT NULL,
    FOREIGN KEY(fk_task) REFERENCES Task (id_task),
    FOREIGN KEY(fk_objetivo) REFERENCES Objetivo (id_objetivo)
);

CREATE TABLE IF NOT EXISTS TaskObjetivoConta (
    descricao VARCHAR(100),
    done INT,
    pontuacao DECIMAL(10,2),
    valor DECIMAL(10,2),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_objetivo_conta INT NOT NULL,
    fk_task_objetivo INT NOT NULL,
    FOREIGN KEY (fk_objetivo_conta) REFERENCES ObjetivoConta (id_objetivo_conta),
    FOREIGN KEY (fk_task_objetivo)  REFERENCES  TaskObjetivo (id_task_objetivo),
    PRIMARY KEY (fk_objetivo_conta, fk_task_objetivo)
);

CREATE TABLE IF NOT EXISTS Movimentacao (
    id_movimentacao INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    valor DECIMAL(10,2),
    topico VARCHAR(100),
    descricao VARCHAR(100),
    tipo VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_objetivo_conta INT NOT NULL,
    FOREIGN KEY (fk_objetivo_conta) REFERENCES ObjetivoConta (id_objetivo_conta)
);

CREATE TABLE IF NOT EXISTS MovimentacaoFixa  (
    id_movimentacao_fixa INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    categoria VARCHAR(100),
    descricao VARCHAR(100),
    valor DECIMAL(10,2),
    tipo VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_conta INT NOT NULL,
    FOREIGN KEY (fk_conta) REFERENCES Conta (id_conta)
);

CREATE TABLE IF NOT EXISTS Dica (
    id_dica INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(45) NULL,
    descricao VARCHAR(255) NULL,
    tema VARCHAR(45) NULL
);

CREATE TABLE IF NOT EXISTS Topico (
    id_topico INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(45) NULL,
    conteudo VARCHAR(255) NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_conta INT NOT NULL,
    FOREIGN KEY (fk_conta) REFERENCES Conta (id_conta)
);

CREATE TABLE IF NOT EXISTS Comentario (
    id_comentario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    conteudo VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_conta INT NOT NULL,
    fk_topico INT NOT NULL,
    fk_comentario INT,
    FOREIGN KEY (fk_comentario) REFERENCES Comentario (id_comentario),
    FOREIGN KEY (fk_conta) REFERENCES Conta (id_conta),
    FOREIGN KEY (fk_topico) REFERENCES Topico (id_topico)
);

CREATE TABLE IF NOT EXISTS Likes (
    fk_topico INT NOT NULL,
    fk_conta INT NOT NULL,
    FOREIGN KEY(fk_topico) REFERENCES Topico (id_topico),
    FOREIGN KEY(fk_conta) REFERENCES Conta (id_conta),
    PRIMARY KEY (fk_topico, fk_conta)
);

INSERT INTO Objetivo(categoria)
VALUES ('Viagem Internacional'),
       ('Viagem Nacional'),
       ('Comprar casa própria'),
       ('Comprar carro'),
       ('Faculdade'),
       ('Quitação de Dívida'),
       ('Compras Gerais');

INSERT INTO Task(categoria)
VALUES ('Economizar'),
       ('Procurar Hotel'),
       ('Comprar Malas de Viagem');
