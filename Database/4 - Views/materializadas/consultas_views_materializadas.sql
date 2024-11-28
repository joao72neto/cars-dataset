-- JOAO SALVADOR 

-- 1 - Analise dos vendedores por periodo

select 
    v."Nome do Vendedor",
    v."Vendas 1P",
    v."Vendas 2P",
    v."Vendas 3P",
    v."Taxa 1P - 2P",
    v."Taxa 2P - 3P",
    v."Taxa 1P - 3P",
    v."Média de Vendas"
from
    vendedores v
where
    v."Vendas 1P" != 0
order by
    v."Vendas 3P" desc;
    
-- 2 - Marcas e modelos mais vendidos por cada vendedor

select
    v."Nome do Vendedor",
    v."Top Modelo (Ult. 8 meses)",
    v."Total Modelos (Ult. 8 meses)",
    v."Top Marca (Ult. 8 meses)",
    v."Total Marcas (Ult. 8 meses)",
    v."Total de Vendas"

from
    vendedores v
order by
    v."Total de Vendas" desc;
    

-- JOAO VITOR

-- 1 - Modelos com Maior Taxa de Crescimento Total da Média de Preço por Marca

SELECT 
    ma.mar_id AS marca_id,
    ma.mar_nome AS marca_nome,
    m.mod_id AS modelo_id,
    m.mod_nome AS modelo_nome,
    mv.taxa_crescimento_total AS taxa_crescimento_total,
    mv.media_preco_1p,
    mv.media_preco_3p
FROM mv_modelos mv
JOIN C##JOAO.modelos m ON mv.mod_id = m.mod_id
JOIN C##JOAO.marcas ma ON m.mod_mar_id = ma.mar_id
WHERE mv.taxa_crescimento_total IS NOT NULL
ORDER BY mv.media_preco_3p desc;

-- 2 - 100 Modelos com Mais Vendas e Taxas de Crescimento da Média de Preço

SELECT 
    mod_id,
    vendas_1p,
    vendas_2p,
    vendas_3p,
    total_vendas
FROM mv_modelos
ORDER BY total_vendas DESC
FETCH FIRST 100 ROWS ONLY;

-- FABIO 

-- Consulta 1

SELECT 
    nome_marca,
    crescimento_1p_para_2p AS crescimento_vendas_1p_2p,
    crescimento_2p_para_3p AS crescimento_vendas_2p_3p,
    qtd_vendas_totais,
    lucro_bruto_total
FROM 
    mv_marcas
WHERE 
    crescimento_1p_para_2p != 'indefinido' AND crescimento_2p_para_3p != 'indefinido'
ORDER BY 
    crescimento_1p_para_2p DESC,
    crescimento_2p_para_3p DESC;
  
-- Consulta 2  
  
SELECT 
    nome_marca,
    lucro_bruto_1p,
    lucro_bruto_2p,
    lucro_bruto_3p,
    lucro_bruto_total,
    qtd_vendas_totais,
    media_preco AS preco_medio,
    estado_que_mais_vendeu
FROM 
    mv_marcas
ORDER BY 
    lucro_bruto_total DESC;


-- GABRIELA

-- Consulta 1

SELECT 
    ano,
    estado,
    COUNT(venda_id) AS vendas_acima_mmr,
    ROUND(AVG(preco_venda), 2) AS preco_medio_acima_mmr
FROM 
    vendas_analise_materializada
WHERE 
    classificacao_preco = 'Acima do MMR'
GROUP BY 
    ano, estado
ORDER BY 
    ano, estado;


-- Consulta 2

SELECT 
    dia_semana,
    COUNT(venda_id) AS total_vendas,
    ROUND(AVG(preco_venda), 2) AS preco_medio_dia_semana,
    ROUND(AVG(diferenca_preco), 2) AS diferenca_preco_media
FROM 
    vendas_analise_materializada
GROUP BY 
    dia_semana
ORDER BY 
    total_vendas;

