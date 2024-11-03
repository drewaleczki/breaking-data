-- USO DO ATRIBUTO %TYPE PARA NÃO PRECISAR DECLARAR O TIPO DE DADOS E O TAMANHO DAS COLUNAS DECLARADAS

SET SERVEROUTPUT ON

DECLARE
  v_empno    emp.empno%TYPE;
  v_ename    emp.ename%TYPE;
  v_job      emp.job%TYPE;
  v_mgr      emp.mgr%TYPE;
  v_hiredate emp.hiredate%TYPE;
  v_sal      emp.sal%TYPE;
  v_comm     emp.comm%TYPE;
  v_deptno   emp.deptno%TYPE;

BEGIN
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
  INTO v_empno, v_ename, v_job, v_mgr, v_hiredate, v_sal, v_comm, v_deptno
  FROM emp
 WHERE empno = 7839;
 dbms_output.put_line('Codigo   = ' || v_empno);
 dbms_output.put_line('Nome     = ' || v_ename);
 dbms_output.put_line('Cargo    = ' || v_job);
 dbms_output.put_line('Gerente  = ' || v_mgr);
 dbms_output.put_line('Data     = ' || v_hiredate);
 dbms_output.put_line('Sala     = ' || v_sal);
 dbms_output.put_line('Comissao = ' || v_comm);
 dbms_output.put_line('Depart.  = ' || v_deptno);  
END;
/

-- USO DO ATRIBUTO %ROWTYPE PARA NÃO PRECISAR DECLARAR AS COLUNAS, SIMPLESMENTE ELE TRAZ A TABELA TODA

SET SERVEROUTPUT ON

DECLARE
  emprec emp%rowtype;

BEGIN
SELECT *
  INTO emprec
  FROM emp
 WHERE empno = 7839;
 dbms_output.put_line('Codigo   = ' || emprec.empno);
 dbms_output.put_line('Nome     = ' || emprec.ename);
 dbms_output.put_line('Cargo    = ' || emprec.job);
 dbms_output.put_line('Gerente  = ' || emprec.mgr);
 dbms_output.put_line('Data     = ' || emprec.hiredate);
 dbms_output.put_line('Sala     = ' || emprec.sal);
 dbms_output.put_line('Comissao = ' || emprec.comm);
 dbms_output.put_line('Depart.  = ' || emprec.deptno);  
END;
/

-- CURSOR IMPLÍCITO

DECLARE   
  emprec emp%rowtype; 
BEGIN 
SELECT SUM(sal)    
  INTO emprec.sal   
  FROM emp 
GROUP BY deptno;  
  dbms_output.put_line('Salario = ' || emprec.sal); 
END;
/
ERROR at line 1:
ORA-01422: exact fetch returns more than requested number of rows
ORA-06512: at line 4

-- O ERRO SE DÁ DEVIDO A AUSENCIA DE UM CURSOS EXPLÍCITO, TANTO  O  EXPLICITO QUANTO O  IMPLICITO TEM 4 ATRIBUTOS
-- %FOUND RETORNA (TRUE) CASO ALGUMA TUPLA TENHA SIDO AFETADA
-- %ISOPEN RETORNA (TRUE) CASO O CURSOS SEJA ABERTO
-- %NOTFOUND RETORNA (TRUE) CASO NÃO TENHA ENCONTRADO NENHUMA TUPLA, SE NÃO TRAZ FALSE 
-- %ROWCOUNT RETORNA O NÚMERO DE TUPLAS MANIPULADAS PELO CURSOS

-- EXEMPLO DE DECLARAÇÃO DE UM CURSOR

DECLARE   
  CURSOR cursor_emp IS 
      SELECT deptno, SUM(sal)             
      FROM emp        
     GROUP BY deptno;
…

-- APÓS ISSO USAMOS UM OPEN CURSOR

OPEN nome_cursor;

--  O COMANDO OPEN ALOCA MEMORIA, ANALISA O SELECT, VINCULA AS VARIAVEIS, IDENTIFICA O CONJUNTO ATIVO  ATRAVÉS DA INSTRUÇÃO FETCH  E POSICIONA O INDICADOR ANTES DA PRIMEIRA LINHA DO CONJUNTO

-- EXEMPLO DE INSTRUÇÃO OPEN

DECLARE   
  CURSOR cursor_emp IS 
         SELECT deptno, SUM(sal)             
         FROM emp        
      GROUP BY deptno;
BEGIN
   OPEN cursor_emp;
END;
/

-- RECUPERAÇÃO DAS LINHAS DO CURSOR

FETCH cursor_name
 INTO [variável1, variável2, ...|record_name];

-- FETCH - É a instrução utilizada para extrair dados de um conjunto ativo. Avança o indicador para a proxima linha do conjunto ativo e le os dados da linha atual para as variaveis de saida.
-- NOME_CURSOR - É um  identificador para o cursor
-- VÁRIAVEL - Armazena a saida dos resultados. O numero de variaveis deve ser compativel com o numero de colunas.
-- RECORD_NAME - É o registro em que os dados são recuperados e armazenados, pode ser declarada usando o %ROWTYPE

-- EXEMPLO DE EXECUÇÃO

DECLARE
  emprec emp%rowtype;   
  CURSOR cursor_emp IS 
         SELECT deptno, SUM(sal)             
          FROM emp        
        GROUP BY deptno;
BEGIN
   OPEN cursor_emp;
   FETCH cursor_emp INTO emprec.deptno, emprec.sal;
   dbms_output.put_line
    ('Departamento: ' || emprec.deptno);
   dbms_output.put_line
    ('Salario     : ' || emprec.sal);
END;
/

-- Desse modo ele só executa o FETCH uma vez, para ele ler cada uma das linhas do conjunto precisamos agregar um loop

-- EXEMPLO COM LOOP

DECLARE
  emprec emp%rowtype;   
  CURSOR cursor_emp IS 
         SELECT deptno, SUM(sal)             
          FROM emp        
        GROUP BY deptno;
BEGIN
   OPEN cursor_emp;
   LOOP
      FETCH cursor_emp INTO emprec.deptno, emprec.sal;
      EXIT WHEN cursor_emp%notfound;
      dbms_output.put_line
        ('Departamento: ' || emprec.deptno);
      dbms_output.put_line
        ('Salario     : ' || emprec.sal);
   END LOOP;
END;
/

-- Após a execução é indicado fechar o cursos para liberar a memória alocada para essa execução.

-- EXEMPLO DE FECHAMENTO DE CURSOR

DECLARE
  emprec emp%rowtype;   
  CURSOR cursor_emp IS 
         SELECT deptno, SUM(sal)             
          FROM emp        
        GROUP BY deptno;
BEGIN
   OPEN cursor_emp;
   LOOP
      FETCH cursor_emp INTO emprec.deptno, emprec.sal;
      EXIT WHEN cursor_emp%notfound;
      dbms_output.put_line
        ('Departamento: ' || emprec.deptno);
      dbms_output.put_line
        ('Salario     : ' || emprec.sal);
   END LOOP;
   CLOSE cursor_emp;
END;
/

-- Um cursor só é executado quando ele é aberto com o OPEN;

-- LOOPS DE CURSOR FOR

FOR nome_registro IN nome_cursor LOOP
    Instruções;
END LOOP;

--  Acima temos uma sintaxe simples, composta pelo

-- LOOP DE CURSOS FOR COMPLETO

DECLARE   
  CURSOR cursor_emp IS          
    SELECT deptno, SUM(sal) soma           
    FROM emp          
  GROUP BY deptno; 
BEGIN    
  FOR emprec IN cursor_emp LOOP        
    dbms_output.put_line
      ('Departamento: ' || emprec.deptno);       
    dbms_output.put_line
      ('Salario     : ' || emprec.soma);    
  END LOOP; 
END; 
/

-- Com o FOR não precisamos declarar as variaveis do cursor, somente agregando o IS no final dele e abrindo o FOR após o BEGIN pois ele repete a execução até encerrar o LOOP

-- LOOPS DE CURSOR USANDO SUBCONSULTA

BEGIN    
  FOR emprec IN (SELECT deptno, SUM(sal) soma 
    FROM emp GROUP BY deptno) 
  LOOP        
    dbms_output.put_line
      ('Departamento: ' || emprec.deptno);        
    dbms_output.put_line
      ('Salario     : ' || emprec.soma);    
  END LOOP; 
END; 
/

-- Com uma subconsulta, as variaveis são definidas automaticamente, desse modo é como um cursor explicito imbutido na Clausula IN  atrelado a um Loop de repetição. O que simplifica mais ainda o uso de um Cursor.

-- CURSOS DE ATUALIZAÇÃO

DECLARE
  emprec emp%rowtype;   
  CURSOR cursor_emp IS 
         SELECT empno, sal             
          FROM emp
            FOR UPDATE; 
BEGIN
   OPEN cursor_emp;
   LOOP
      FETCH cursor_emp INTO emprec.empno, emprec.sal;
      EXIT WHEN cursor_emp%notfound;
      UPDATE emp
      SET sal = sal * 1.05
      WHERE CURRENT OF cursor_emp;
   END LOOP;
   CLOSE cursor_emp;
END;
/

--  Nesse exemplo as linhas extraidas pro conjunto são bloqueadas para evitar alterações de outros usuários e a cada iteração do laço atualiza o salário com +5%.