-- EXEMPLO DE ERRO DE SINTAXE

SELET * FROM emp;

-- EXEMPLO DE ERRO DE SINTAXE COM DIVISOR POR ZERO

SET SERVEROUTPUT ON

DECLARE
   cinco NUMBER := 5;
BEGIN
  dbms_output.put_line(cinco / (cinco - cinco) ); -- 5 / 0 vai dar erro pois não é possivel realizar uma divisão
END;
/

DECLARE
*
ERROR at line 1:
ORA-01476: divisor is equal to zero
ORA-06512: at line 4

-- ESTRUTURA DE EXCEPTION NO PL/SQL

EXCEPTION -- Indica o início do bloco
WHEN exceção1 [OR exceção2 …] THEN -- exceção indica o nome definido da exceção que precisa ser definido anteriormente pelo usuário
  comando1; -- indica uma ou mais instruções PL/SQL
  comando2;
  …
[WHEN exceção3 [OR exceção4 …] THEN
  comando1;
  comando2;
  …]
[WHEN OTHERS THEN -- indica uma clausula de tratamento de exceções opcional que intercepta qualquer exceção que não foi explicitamente tratada
  comando1;
  comando2;
  …]

-- EXCEÇÕES PREDEFINIDAS NOMEADAS

-- Exceção ZERO_DIVIDE

SET SERVEROUTPUT ON

DECLARE
    cinco   NUMBER := 5;
BEGIN
    dbms_output.put_line(cinco / (cinco - cinco) );
EXCEPTION
    WHEN zero_divide THEN
        dbms_output.put_line('Divisao por zero');
    WHEN OTHERS THEN
        dbms_output.put_line('Erro imprevisto');
END;
/

-- O erro persiste mas ao invés de receber o erro ORA-01476 o usuário recebe a mensagem

-- FUNÇÕES DE CAPTURA DE ERRO

CREATE TABLE erros
(usuario  VARCHAR2(30),
 data     DATE,
 cod_erro NUMBER,
 msg_erro VARCHAR2(100));

SET SERVEROUTPUT ON

DECLARE
   cod   erros.cod_erro%TYPE;
   msg   erros.msg_erro%TYPE;    
   cinco NUMBER := 5; 
BEGIN    
  DBMS_OUTPUT.PUT_LINE (cinco / ( cinco - cinco )); 
EXCEPTION    
  WHEN ZERO_DIVIDE THEN
        cod := SQLCODE;
        msg := SUBSTR(SQLERRM, 1, 100);
        insert into erros values (USER, SYSDATE, cod, msg);    
  WHEN OTHERS THEN         
        DBMS_OUTPUT.PUT_LINE ('Erro imprevisto'); END;
/

-- Aqui usamos o SQLERR (Função NUMERIC que retorna o erro do ocorrido) e o SQLCODE  (Função TEXT que devolve o texto do erro)