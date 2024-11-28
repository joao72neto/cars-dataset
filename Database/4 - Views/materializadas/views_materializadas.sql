
-- Fábio

CREATE MATERIALIZED VIEW mv_marcas AS 
    SELECT 
        estatisticas_marcas.ranking_vendas,
        ma.mar_nome AS nome_marca,
        COALESCE(estatisticas_marcas.moda_preco, 0) AS moda_preco, 
        COALESCE(estatisticas_marcas.media_preco, 0) AS media_preco, 
        COALESCE(estatisticas_marcas.mediana_preco, 0) AS mediana_preco, 
        estatisticas_marcas.primeira_venda,
        estatisticas_marcas.ultima_venda,
        COALESCE(vendas_1p.lucro_bruto_1p, 0) AS lucro_bruto_1p, 
        COALESCE(vendas_2p.lucro_bruto_2p, 0) AS lucro_bruto_2p, 
        COALESCE(vendas_3p.lucro_bruto_3p, 0) AS lucro_bruto_3p, 
        COALESCE(vendas_1p.lucro_bruto_1p, 0) + COALESCE(vendas_2p.lucro_bruto_2p, 0) + COALESCE(vendas_3p.lucro_bruto_3p, 0) AS lucro_bruto_total, 
        COALESCE(vendas_1p.vendas_1p, 0) AS qtd_vendas_1p,
        COALESCE(vendas_2p.vendas_2p, 0) AS qtd_vendas_2p,
        COALESCE(vendas_3p.vendas_3p, 0) AS qtd_vendas_3p,
        COALESCE(vendas_1p.vendas_1p, 0) + COALESCE(vendas_2p.vendas_2p, 0) + COALESCE(vendas_3p.vendas_3p, 0) AS qtd_vendas_totais,
        CASE
            WHEN COALESCE(vendas_1p.vendas_1p, 0) = 0 THEN 'indefinido'
            ELSE ROUND(
                ((COALESCE(vendas_2p.vendas_2p, 0) - COALESCE(vendas_1p.vendas_1p, 0)) * 100.0) / COALESCE(vendas_1p.vendas_1p, 1), 2
            ) || '%' 
        END AS crescimento_1p_para_2p,
        CASE
            WHEN COALESCE(vendas_2p.vendas_2p, 0) = 0 THEN 'indefinido'
            ELSE ROUND(
                ((COALESCE(vendas_3p.vendas_3p, 0) - COALESCE(vendas_2p.vendas_2p, 0)) * 100.0) / COALESCE(vendas_2p.vendas_2p, 1), 2
            ) || '%' 
        END AS crescimento_2p_para_3p,
        estatisticas_marcas.estado_que_mais_vendeu
    FROM 
        C##JOAO.marcas ma
    LEFT JOIN 
        vendas_1p ON vendas_1p.mar_id = ma.mar_id
    LEFT JOIN 
        vendas_2p ON vendas_2p.mar_id = ma.mar_id
    LEFT JOIN 
        vendas_3p ON vendas_3p.mar_id = ma.mar_id
    LEFT JOIN 
        estatisticas_marcas ON estatisticas_marcas.mar_id = ma.mar_id
    ORDER BY 
        estatisticas_marcas.ranking_vendas, ma.mar_nome;
        
-- Gabi   
        
CREATE MATERIALIZED VIEW vendas_analise_materializada AS
    SELECT 
        -- Informações gerais da venda
        vnd_id AS venda_id,
        vnd_data AS data_venda,
        EXTRACT(YEAR FROM vnd_data) AS ano,
        EXTRACT(MONTH FROM vnd_data) AS mes,
        EXTRACT(DAY FROM vnd_data) AS dia,
        vnd_dia_semana AS dia_semana,
        
        -- Informações de localidade e tempo
        vnd_estado AS estado,
        vnd_zona AS zona,               -- Ex: horário de verão ou não
        vnd_fuso_horario AS fuso_horario,
    
        -- Informações financeiras
        vnd_mmr AS valor_mercado,       -- Valor de mercado (MMR) do carro
        vnd_preco AS preco_venda,       -- Preço de venda real
        ROUND(vnd_preco - vnd_mmr, 2) AS diferenca_preco, -- Diferença entre preço de venda e valor de mercado
        
        -- Métricas financeiras
        CASE 
            WHEN vnd_preco > vnd_mmr THEN 'Acima do MMR'
            WHEN vnd_preco < vnd_mmr THEN 'Abaixo do MMR'
            ELSE 'Igual ao MMR'
        END AS classificacao_preco,
        
        -- Resumo de estatísticas de vendas
        COUNT(vnd_id) OVER(PARTITION BY EXTRACT(YEAR FROM vnd_data)) AS total_vendas_ano,
        COUNT(vnd_id) OVER(PARTITION BY vnd_estado) AS total_vendas_estado,
        COUNT(vnd_id) OVER(PARTITION BY EXTRACT(YEAR FROM vnd_data), vnd_estado) AS total_vendas_ano_estado,
        
        -- Estatísticas de preço por ano e estado
        AVG(vnd_preco) OVER(PARTITION BY EXTRACT(YEAR FROM vnd_data)) AS preco_medio_ano,
        AVG(vnd_preco) OVER(PARTITION BY vnd_estado) AS preco_medio_estado,
        AVG(vnd_preco) OVER(PARTITION BY EXTRACT(YEAR FROM vnd_data), vnd_estado) AS preco_medio_ano_estado,
        
        -- Classificação por dia da semana para análise de padrão
        COUNT(vnd_id) OVER(PARTITION BY vnd_dia_semana) AS total_vendas_dia_semana,
        AVG(vnd_preco) OVER(PARTITION BY vnd_dia_semana) AS preco_medio_dia_semana
    
    FROM 
        C##JOAO.vendas
    
    ORDER BY 
        ano, 
        estado, 
        dia_semana;
        

-- JOÃO SALVADOR

create materialized view vendedores as
    select 
        vp.vendedor_nome "Nome do Vendedor",
        vp.vendas_p1 "Vendas 1P",
        vp.vendas_p2 "Vendas 2P",
        vp.vendas_p3 "Vendas 3P",
        d.primeira_venda "Primeira Venda",
        d.ultima_venda "Última Venda",
        c.nome_marca "Top Marca (Ult. 8 meses)",
        c.total_marcas "Total Marcas (Ult. 8 meses)",
        c.nome_modelo "Top Modelo (Ult. 8 meses)",
        c.total_modelos "Total Modelos (Ult. 8 meses)",
        c.maior_ano "Carro Mais Novo Vendido (Ult. 8 meses)",
        c.maior_quilometragem "Maior Quilom.(Ult. 8 meses)",
        c.menor_quilometragem "Menor Quilom.(Ult. 8 meses)",
        e.taxa_1p_2p "Taxa 1P - 2P",
        e.taxa_2p_3p "Taxa 2P - 3P",
        e.taxa_1p_3p "Taxa 1P - 3P",
        e.media_vendas "Média de Vendas",  
        e.total_vendas "Total de Vendas"
    from 
        vendas_por_periodo vp
        join datas d on d.vendedor_id = vp.vendedor_id
        join carros c on c.vendedor_id = vp.vendedor_id
        join estatisticas e on e.vendedor_id = vp.vendedor_id;
        
        
        
-- JOÃO VITOR

CREATE MATERIALIZED VIEW mv_modelos AS
    WITH vendas_1p AS (
        SELECT
            m.mod_id,
            COUNT(*) AS vendas_1p,
            ROUND(STATS_MODE(hv.hvnd_preco), 2) AS moda_preco_1p,
            ROUND(AVG(hv.hvnd_preco), 2) AS media_preco_1p,
            ROUND(MEDIAN(hv.hvnd_preco), 2) AS mediana_preco_1p,
            MIN(hv.hvnd_data) AS primeira_venda_1p,
            MAX(hv.hvnd_data) AS ultima_venda_1p
        FROM C##JOAO.hVendas hv
        JOIN C##JOAO.carros c ON hv.hvnd_car_id = c.car_id
        JOIN C##JOAO.modelos m ON c.car_mod_id = m.mod_id
        WHERE
            hv.hvnd_data >= TO_DATE('01/01/2014', 'DD/MM/YYYY')
            AND hv.hvnd_data < TO_DATE('01/08/2014', 'DD/MM/YYYY')
        GROUP BY m.mod_id
    ),
    vendas_2p AS (
        SELECT
            m.mod_id,
            COUNT(*) AS vendas_2p,
            ROUND(STATS_MODE(hv.hvnd_preco), 2) AS moda_preco_2p,
            ROUND(AVG(hv.hvnd_preco), 2) AS media_preco_2p,
            ROUND(MEDIAN(hv.hvnd_preco), 2) AS mediana_preco_2p,
            MIN(hv.hvnd_data) AS primeira_venda_2p,
            MAX(hv.hvnd_data) AS ultima_venda_2p
        FROM C##JOAO.hVendas hv
        JOIN C##JOAO.carros c ON hv.hvnd_car_id = c.car_id
        JOIN C##JOAO.modelos m ON c.car_mod_id = m.mod_id
        WHERE
            hv.hvnd_data >= TO_DATE('01/08/2014', 'DD/MM/YYYY')
            AND hv.hvnd_data < TO_DATE('01/04/2015', 'DD/MM/YYYY')
        GROUP BY m.mod_id
    ),
    vendas_3p AS (
        SELECT
            m.mod_id,
            COUNT(*) AS vendas_3p,
            ROUND(STATS_MODE(v.vnd_preco), 2) AS moda_preco_3p,
            ROUND(AVG(v.vnd_preco), 2) AS media_preco_3p,
            ROUND(MEDIAN(v.vnd_preco), 2) AS mediana_preco_3p,
            MIN(v.vnd_data) AS primeira_venda_3p,
            MAX(v.vnd_data) AS ultima_venda_3p
        FROM C##JOAO.vendas v
        JOIN C##JOAO.carros c ON v.vnd_car_id = c.car_id
        JOIN C##JOAO.modelos m ON c.car_mod_id = m.mod_id
        WHERE
            v.vnd_data >= TO_DATE('01/04/2015', 'DD/MM/YYYY')
        GROUP BY m.mod_id
    )
    SELECT 
        m.mod_id,
        m.mod_nome,
        NVL(v1.vendas_1p, 0) AS vendas_1p,
        NVL(v1.moda_preco_1p, 0) AS moda_preco_1p,
        NVL(v1.media_preco_1p, 0) AS media_preco_1p,
        NVL(v1.mediana_preco_1p, 0) AS mediana_preco_1p,
        NVL(TO_CHAR(v1.primeira_venda_1p, 'DD-MM-YYYY'), 'Sem Data') AS primeira_venda_1p,
        NVL(TO_CHAR(v1.ultima_venda_1p, 'DD-MM-YYYY'), 'Sem Data') AS ultima_venda_1p,
        
        NVL(v2.vendas_2p, 0) AS vendas_2p,
        NVL(v2.moda_preco_2p, 0) AS moda_preco_2p,
        NVL(v2.media_preco_2p, 0) AS media_preco_2p,
        NVL(v2.mediana_preco_2p, 0) AS mediana_preco_2p,
        NVL(TO_CHAR(v2.primeira_venda_2p, 'DD-MM-YYYY'), 'Sem Data') AS primeira_venda_2p,
        NVL(TO_CHAR(v2.ultima_venda_2p, 'DD-MM-YYYY'), 'Sem Data') AS ultima_venda_2p,
        
        CASE 
            WHEN v1.media_preco_1p IS NOT NULL AND v2.media_preco_2p IS NOT NULL 
            THEN ROUND(((v2.media_preco_2p - v1.media_preco_1p) / v1.media_preco_1p) * 100, 2)
            ELSE 0
        END AS taxa_crescimento_media_preco_2p,
        
        NVL(v3.vendas_3p, 0) AS vendas_3p,
        NVL(v3.moda_preco_3p, 0) AS moda_preco_3p,
        NVL(v3.media_preco_3p, 0) AS media_preco_3p,
        NVL(v3.mediana_preco_3p, 0) AS mediana_preco_3p,
        NVL(TO_CHAR(v3.primeira_venda_3p, 'DD-MM-YYYY'), 'Sem Data') AS primeira_venda_3p,
        NVL(TO_CHAR(v3.ultima_venda_3p, 'DD-MM-YYYY'), 'Sem Data') AS ultima_venda_3p,
        
        CASE 
            WHEN v2.media_preco_2p IS NOT NULL AND v3.media_preco_3p IS NOT NULL 
            THEN ROUND(((v3.media_preco_3p - v2.media_preco_2p) / v2.media_preco_2p) * 100, 2)
            ELSE 0
        END AS taxa_crescimento_media_preco_3p,
        
        CASE 
            WHEN v1.media_preco_1p IS NOT NULL AND v3.media_preco_3p IS NOT NULL 
            THEN ROUND(((v3.media_preco_3p - v1.media_preco_1p) / v1.media_preco_1p) * 100, 2)
            ELSE 0
        END AS taxa_crescimento_total,
    
        NVL(v1.vendas_1p, 0) + NVL(v2.vendas_2p, 0) + NVL(v3.vendas_3p, 0) AS total_vendas
    FROM C##JOAO.modelos m
    LEFT JOIN vendas_1p v1 ON m.mod_id = v1.mod_id
    LEFT JOIN vendas_2p v2 ON m.mod_id = v2.mod_id
    LEFT JOIN vendas_3p v3 ON m.mod_id = v3.mod_id;


    
    
    
        