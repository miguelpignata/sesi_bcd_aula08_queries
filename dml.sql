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