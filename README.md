# Aula 08 - Banco de Dados: Queries e DQL

Repositório criado para a atividade da Aula 08 da disciplina de Banco de Dados, focada em comandos DQL (Data Query Language), junções (`JOIN`), funções de agregação (`COUNT`, `SUM`, `AVG`), agrupamentos (`GROUP BY`) e ordenações (`ORDER BY`).

---

## 📁 Estrutura do Repositório
- `ddldml.sql`: Script responsável por recriar o banco de dados (`gestao_pedidos`), suas tabelas e inserir a massa de dados inicial (clientes, telefones, produtos e pedidos).
- `dql.sql`: Arquivo contendo as 15 consultas solicitadas na atividade prática.

---

## 🚀 Como Executar
1. Certifique-se de que o **XAMPP** está com o **MySQL** ativo.
2. Abra o **MySQL Workbench** e execute o script `ddldml.sql` para estruturar e popular o banco de dados.
3. Abra e execute as consultas contidas no arquivo `dql.sql` para testar os resultados.

---

## 💻 Script SQL DDL (Desenvolvimanto: Criação do Banco de dados)
```sql
drop database if exists gestao_pedidos;
create database gestao_pedidos;
use gestao_pedidos;
create table produto(
    id int not null primary key auto_increment,
    nome varchar(100) not null
);
create table telefone(
    id int not null primary key auto_increment,
    id_cliente int not null,
    numero varchar(100) not null unique,
    tipo enum('Residencial', 'Comercial', 'Celular') not null
);
create table cliente(
    id int not null primary key auto_increment,
    nome varchar(100) not null,
    cep varchar(11) not null,
    numero varchar(10),
    complemento varchar(100)
);
create table pedido(
    id int not null primary key auto_increment,
    id_cliente int not null,
    id_produto int not null,
    quantidade int not null,
    valor_unitario decimal(10,2) not null,
    subtotal decimal(10,2) default (valor_unitario * quantidade)
);

alter table telefone add constraint fk_telefones foreign key (id_cliente) references cliente(id);
alter table pedido add constraint fk_faz foreign key (id_cliente) references cliente(id);
alter table pedido add constraint fk_possui foreign key (id_produto) references produto(id);

describe produto;
describe telefone;
describe cliente;
describe pedido;
show tables;
```

---

## 🗂️ Script SQL DML(Manipulação: População com dados de teste)
```sql
use gestao_pedidos;
insert into cliente(nome, complemento, numero, cep) values
("Ana Maria Silva",null,"21","13905-522"),
("Valentina Oliveira","Ap:19 Bloco:2","12","13903-333"),
("Enzo Martins","Ap: 19"," 195B","13903-235");

insert into telefone(id_cliente,numero,tipo) values
(1,"19 99987-8789","Celular"),
(1,"19 99980-4848","Celular"),
(2,"19 98450-1212","Residencial"),
(3,"19 99988-2121","Celular"),
(3,"19 99777-2222","Residencial"),
(3,"19 99900-1010","Comercial");

insert into produto(nome) values
("Impressora laser"),
("Impressora deskjet"),
("Impressora matricial"),
("Impressora mobile");

insert into pedido(id,id_produto,id_cliente,quantidade,valor_unitario) values
(1005,1,1,5,1500.00),
(1006,2,1,3,350.00),
(1007,3,2,1,190.00),
(1008,4,3,6,980.00);

select * from cliente;
select * from telefone;
select * from produto;
select * from pedido;
```

---

## 🗃️🔍 Queries de busca:

1. Listando produtos:
```sql
SELECT id, nome FROM produto ORDER BY nome ASC;
```
2. Produtos mais recentes:
```sql
SELECT * FROM produto ORDER BY id DESC LIMIT 5;
```
3. Maiores pedidos:
```sql
SELECT id, quantidade, valor_unitario FROM pedido ORDER BY valor_unitario DESC;
```
4. Primeiros pedidos:
```sql
SELECT * FROM pedido ORDER BY id DESC LIMIT 10;
```
5. Pedidos com nomes dos clientes:
```sql
SELECT 
    p.id AS id_pedido,
    c.nome AS nome_cliente,
    p.quantidade,
    p.valor_unitario
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id;
```
6. Pedidos com nome do produto:
```sql
SELECT 
    p.id AS id_pedido,
    pr.nome AS nome_produto,
    p.quantidade,
    p.valor_unitario
FROM pedido p
JOIN produto pr ON p.id_produto = pr.id;
```
7. Pedidos completos:
```sql
SELECT 
    p.id AS id_pedido,
    c.nome AS nome_cliente,
    pr.nome AS nome_produto,
    p.quantidade,
    p.valor_unitario,
    p.subtotal
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id
JOIN produto pr ON p.id_produto = pr.id;
```
8. Os 5 pedidos de maior valor:
```sql
SELECT 
    c.nome AS nome_cliente,
    pr.nome AS nome_produto,
    p.subtotal
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id
JOIN produto pr ON p.id_produto = pr.id
ORDER BY p.subtotal DESC
LIMIT 5;
```
9. Quantidade de clientes:
```sql
SELECT COUNT(*) AS total_clientes FROM cliente;
```
10. Quantidade de produtos:
```sql
SELECT COUNT(*) AS total_produtos FROM produto;
```
11. Quantidade de pedidos por cliente:
```sql
SELECT 
    c.nome AS nome_cliente,
    COUNT(p.id) AS quantidade_pedidos
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
GROUP BY c.id, c.nome;
```
12. Quantidade de pedidos por produto:
```sql
SELECT 
    pr.nome AS nome_produto,
    COUNT(p.id) AS vezes_pedido
FROM produto pr
JOIN pedido p ON pr.id = p.id_produto
GROUP BY pr.id, pr.nome
ORDER BY vezes_pedido DESC;
```
13. Valor total dos pedidos:
```sql
SELECT SUM(subtotal) AS valor_total_geral FROM pedido;
```
14. Quantidade média por pedido:
```sql
SELECT AVG(quantidade) AS media_quantidade_por_pedido FROM pedido;
```
15. Total vendido por produto:
```sql
SELECT 
    pr.nome AS nome_produto,
    SUM(p.subtotal) AS total_vendido
FROM produto pr
JOIN pedido p ON pr.id = p.id_produto
GROUP BY pr.id, pr.nome
ORDER BY total_vendido DESC;
```
