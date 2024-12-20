-- Transmissions Table 

CREATE TRIGGER HTRS_TG_AUD 
AFTER UPDATE OR DELETE ON HTRANSMISSOES
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30) := SYS_CONTEXT('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_ROWID VARCHAR(20);
    V_TABELA VARCHAR(30) := 'HTRANSMISSOES';
BEGIN
    V_ROWID := :OLD.HTRS_ID;
    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HTRS_ID',:OLD.HTRS_ID,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HTRS_TIPO',:OLD.HTRS_TIPO,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HTRS_DT_ENTRADA',:OLD.HTRS_DT_ENTRADA,NULL,V_USU_BD,V_USU_SO,SYSDATE);
    ELSE
        V_TP_OPERACAO := 'U';
        IF(:OLD.HTRS_ID <> :NEW.HTRS_ID) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HTRS_ID',:OLD.HTRS_ID,:NEW.HTRS_ID,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HTRS_TIPO <> :NEW.HTRS_TIPO) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HTRS_TIPO',:OLD.HTRS_TIPO,:NEW.HTRS_TIPO,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HTRS_DT_ENTRADA <> :NEW.HTRS_DT_ENTRADA) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HTRS_DT_ENTRADA',:OLD.HTRS_DT_ENTRADA,:NEW.HTRS_DT_ENTRADA,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
    END IF;
END;
/

-- Sales Table

CREATE TRIGGER HVND_TG_AUD 
AFTER UPDATE OR DELETE ON HVENDAS
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30) := SYS_CONTEXT('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_ROWID VARCHAR(20);
    V_TABELA VARCHAR(30) := 'HVENDAS';
BEGIN
    V_ROWID := :OLD.HVND_ID;
    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_ID',:OLD.HVND_ID,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_MMR',:OLD.HVND_MMR,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_PRECO',:OLD.HVND_PRECO,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_DIA_SEMANA',:OLD.HVND_DIA_SEMANA,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_DATA',:OLD.HVND_DATA,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_FUSO_HORARIO',:OLD.HVND_FUSO_HORARIO,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_ZONA',:OLD.HVND_ZONA,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_ESTADO',:OLD.HVND_ESTADO,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_VDR_ID',:OLD.HVND_VDR_ID,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_CAR_ID',:OLD.HVND_CAR_ID,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_DT_ENTRADA',:OLD.HVND_DT_ENTRADA,NULL,V_USU_BD,V_USU_SO,SYSDATE);
    ELSE
        V_TP_OPERACAO := 'U';
        IF(:OLD.HVND_ID <> :NEW.HVND_ID) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_ID',:OLD.HVND_ID,:NEW.HVND_ID,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVND_MMR <> :NEW.HVND_MMR) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_MMR',:OLD.HVND_MMR,:NEW.HVND_MMR,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVND_PRECO <> :NEW.HVND_PRECO) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_PRECO',:OLD.HVND_PRECO,:NEW.HVND_PRECO,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVND_DIA_SEMANA <> :NEW.HVND_DIA_SEMANA) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_DIA_SEMANA',:OLD.HVND_DIA_SEMANA,:NEW.HVND_DIA_SEMANA,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVND_DATA <> :NEW.HVND_DATA) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_DATA',:OLD.HVND_DATA,:NEW.HVND_DATA,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVND_FUSO_HORARIO <> :NEW.HVND_FUSO_HORARIO) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_FUSO_HORARIO',:OLD.HVND_FUSO_HORARIO,:NEW.HVND_FUSO_HORARIO,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVND_ZONA <> :NEW.HVND_ZONA) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_ZONA',:OLD.HVND_ZONA,:NEW.HVND_ZONA,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVND_ESTADO <> :NEW.HVND_ESTADO) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_ESTADO',:OLD.HVND_ESTADO,:NEW.HVND_ESTADO,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVND_VDR_ID <> :NEW.HVND_VDR_ID) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_VDR_ID',:OLD.HVND_VDR_ID,:NEW.HVND_VDR_ID,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVND_CAR_ID <> :NEW.HVND_CAR_ID) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_CAR_ID',:OLD.HVND_CAR_ID,:NEW.HVND_CAR_ID,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVND_DT_ENTRADA <> :NEW.HVND_DT_ENTRADA) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVND_DT_ENTRADA',:OLD.HVND_DT_ENTRADA,:NEW.HVND_DT_ENTRADA,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
    END IF;
END;
/

-- Sellers Table

CREATE TRIGGER HVDR_TG_AUD 
AFTER UPDATE OR DELETE ON HVENDEDORES
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30) := SYS_CONTEXT('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_ROWID VARCHAR(20);
    V_TABELA VARCHAR(30) := 'HVENDEDORES';
BEGIN
    V_ROWID := :OLD.HVDR_ID;
    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVDR_ID',:OLD.HVDR_ID,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVDR_NOME',:OLD.HVDR_NOME,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVDR_DT_ENTRADA',:OLD.HVDR_DT_ENTRADA,NULL,V_USU_BD,V_USU_SO,SYSDATE);
    ELSE
        V_TP_OPERACAO := 'U';
        IF(:OLD.HVDR_ID <> :NEW.HVDR_ID) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVDR_ID',:OLD.HVDR_ID,:NEW.HVDR_ID,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVDR_NOME <> :NEW.HVDR_NOME) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVDR_NOME',:OLD.HVDR_NOME,:NEW.HVDR_NOME,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HVDR_DT_ENTRADA <> :NEW.HVDR_DT_ENTRADA) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HVDR_DT_ENTRADA',:OLD.HVDR_DT_ENTRADA,:NEW.HVDR_DT_ENTRADA,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
    END IF;
END;
/

-- Colors Table

CREATE TRIGGER HCOR_TG_AUD 
AFTER UPDATE OR DELETE ON HCORES
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30) := SYS_CONTEXT('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_ROWID VARCHAR(20);
    V_TABELA VARCHAR(30) := 'HCORES';
BEGIN
    V_ROWID := :OLD.HCOR_ID;
    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCOR_ID',:OLD.HCOR_ID,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCOR_NOME',:OLD.HCOR_NOME,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCOR_DT_ENTRADA',:OLD.HCOR_DT_ENTRADA,NULL,V_USU_BD,V_USU_SO,SYSDATE);
    ELSE
        V_TP_OPERACAO := 'U';
        IF(:OLD.HCOR_ID <> :NEW.HCOR_ID) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCOR_ID',:OLD.HCOR_ID,:NEW.HCOR_ID,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HCOR_NOME <> :NEW.HCOR_NOME) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCOR_NOME',:OLD.HCOR_NOME,:NEW.HCOR_NOME,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HCOR_DT_ENTRADA <> :NEW.HCOR_DT_ENTRADA) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCOR_DT_ENTRADA',:OLD.HCOR_DT_ENTRADA,:NEW.HCOR_DT_ENTRADA,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
    END IF;
END;
/

-- Cars Table

CREATE TRIGGER HCAR_TG_AUD 
AFTER UPDATE OR DELETE ON HCARROS
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30) := SYS_CONTEXT('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_ROWID VARCHAR(20);
    V_TABELA VARCHAR(30) := 'HCARROS';
BEGIN
    V_ROWID := :OLD.HCAR_ID;
    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_ID',:OLD.HCAR_ID,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_VIN',:OLD.HCAR_VIN,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_ODOMETRO',:OLD.HCAR_ODOMETRO,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_CONDICAO',:OLD.HCAR_CONDICAO,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_ANO',:OLD.HCAR_ANO,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_MOD_ID',:OLD.HCAR_MOD_ID,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_MOD_ID_EXT',:OLD.HCAR_VIN,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_MOD_ID_INT',:OLD.HCAR_VIN,NULL,V_USU_BD,V_USU_SO,SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_DT_ENTRADA',:OLD.HCAR_DT_ENTRADA,NULL,V_USU_BD,V_USU_SO,SYSDATE);
    ELSE
        V_TP_OPERACAO := 'U';
        IF(:OLD.HCAR_ID <> :NEW.HCAR_ID) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_ID',:OLD.HCAR_ID,:NEW.HCAR_ID,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HCAR_VIN <> :NEW.HCAR_VIN) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_VIN',:OLD.HCAR_VIN,:NEW.HCAR_VIN,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HCAR_ODOMETRO <> :NEW.HCAR_ODOMETRO) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_ODOMETRO',:OLD.HCAR_ODOMETRO,:NEW.HCAR_ODOMETRO,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HCAR_CONDICAO <> :NEW.HCAR_CONDICAO) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_CONDICAO',:OLD.HCAR_CONDICAO,:NEW.HCAR_CONDICAO,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HCAR_ANO <> :NEW.HCAR_ANO) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_ANO',:OLD.HCAR_ANO,:NEW.HCAR_ANO,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HCAR_MOD_ID <> :NEW.HCAR_MOD_ID) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_MOD_ID',:OLD.HCAR_MOD_ID,:NEW.HCAR_MOD_ID,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HCAR_COR_ID_EXT <> :NEW.HCAR_COR_ID_EXT) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_COR_ID_EXT',:OLD.HCAR_COR_ID_EXT,:NEW.HCAR_COR_ID_EXT,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HCAR_COR_ID_INT <> :NEW.HCAR_COR_ID_INT) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_COR_ID_INT',:OLD.HCAR_COR_ID_INT,:NEW.HCAR_COR_ID_INT,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
        IF(:OLD.HCAR_DT_ENTRADA <> :NEW.HCAR_DT_ENTRADA) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HCAR_DT_ENTRADA',:OLD.HCAR_DT_ENTRADA,:NEW.HCAR_DT_ENTRADA,V_USU_BD,V_USU_SO,SYSDATE);
        END IF;
    END IF;
END;
/

-- Table Makes

CREATE TRIGGER HMAR_TG_AUD 
AFTER UPDATE OR DELETE ON hmarcas
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30) := SYS_CONTEXT('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_ROWID VARCHAR(20);
    V_TABELA VARCHAR(30) := 'HMARCAS';
BEGIN
    V_ROWID := :OLD.hmar_id;
    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMAR_ID', :OLD.hmar_id, NULL, V_USU_BD, V_USU_SO, SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMAR_NOME', :OLD.hmar_nome, NULL, V_USU_BD, V_USU_SO, SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA,V_ROWID,V_TP_OPERACAO,'HMAR_DT_ENTRADA',:OLD.HMAR_DT_ENTRADA,NULL,V_USU_BD,V_USU_SO,SYSDATE);
    ELSE
        V_TP_OPERACAO := 'U';
        IF(:OLD.hmar_id <> :NEW.hmar_id) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMAR_ID', :OLD.hmar_id, :NEW.hmar_id, V_USU_BD, V_USU_SO, SYSDATE);
        END IF;
        IF(:OLD.hmar_nome <> :NEW.hmar_nome) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMAR_NOME', :OLD.hmar_nome, :NEW.hmar_nome, V_USU_BD, V_USU_SO, SYSDATE);
        END IF;
        IF(:OLD.hmar_dt_entrada <> :NEW.hmar_dt_entrada) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMAR_DT_ENTRADA', :OLD.hmar_dt_entrada, :NEW.hmar_dt_entrada, V_USU_BD, V_USU_SO, SYSDATE);
        END IF;
    END IF;
END;
/


-- Table Models

CREATE TRIGGER HMOD_TG_AUD
AFTER UPDATE OR DELETE ON hmodelos
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30) := SYS_CONTEXT('USERENV','CURRENT_USER');
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_ROWID VARCHAR(20);
    V_TABELA VARCHAR(30) := 'HMODELOS';
BEGIN
    V_ROWID := :OLD.hmod_id;
    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_ID', :OLD.hmod_id, NULL, V_USU_BD, V_USU_SO, SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_NOME', :OLD.hmod_nome, NULL, V_USU_BD, V_USU_SO, SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_BODY', :OLD.hmod_body, NULL, V_USU_BD, V_USU_SO, SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_TRIM', :OLD.hmod_trim, NULL, V_USU_BD, V_USU_SO, SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_MAR_ID', :OLD.hmod_mar_id, NULL, V_USU_BD, V_USU_SO, SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_TRS_ID', :OLD.hmod_trs_id, NULL, V_USU_BD, V_USU_SO, SYSDATE);
        C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_DT_ENTRADA', :OLD.hmod_dt_entrada, NULL, V_USU_BD, V_USU_SO, SYSDATE);
    ELSE
        V_TP_OPERACAO := 'U';
        IF(:OLD.hmod_id <> :NEW.hmod_id) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_ID', :OLD.hmod_id, :NEW.hmod_id, V_USU_BD, V_USU_SO, SYSDATE);
        END IF;
        IF(:OLD.hmod_nome <> :NEW.hmod_nome) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_NOME', :OLD.hmod_nome, :NEW.hmod_nome, V_USU_BD, V_USU_SO, SYSDATE);
        END IF;
        IF(:OLD.hmod_body <> :NEW.hmod_body) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_BODY', :OLD.hmod_body, :NEW.hmod_body, V_USU_BD, V_USU_SO, SYSDATE);
        END IF;
        IF(:OLD.hmod_trim <> :NEW.hmod_trim) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_TRIM', :OLD.hmod_trim, :NEW.hmod_trim, V_USU_BD, V_USU_SO, SYSDATE);
        END IF;
        IF(:OLD.hmod_mar_id <> :NEW.hmod_mar_id) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_MAR_ID', :OLD.hmod_mar_id, :NEW.hmod_mar_id, V_USU_BD, V_USU_SO, SYSDATE);
        END IF;
        IF(:OLD.hmod_trs_id <> :NEW.hmod_trs_id) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_TRS_ID', :OLD.hmod_trs_id, :NEW.hmod_trs_id, V_USU_BD, V_USU_SO, SYSDATE);
        END IF;
        IF(:OLD.hmod_dt_entrada <> :NEW.hmod_dt_entrada) THEN
            C##AUDITORIA.PROC_AUDITORIA(V_TABELA, V_ROWID, V_TP_OPERACAO, 'HMOD_DT_ENTRADA', :OLD.hmod_dt_entrada, :NEW.hmod_dt_entrada, V_USU_BD, V_USU_SO, SYSDATE);
        END IF;
    END IF;
END;
/

