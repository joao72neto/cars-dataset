-- JOÃO SALVADOR

-- View que analisa a qtd de vendas de cada vendedor por período

create or replace view vendas_por_periodo as
    with p1 as (
    
        select 
            hv.hvnd_vdr_id vendedor_id,
            count(*) total_vendas
        from 
            C##JOAO.hvendas hv
        where 
            hv.hvnd_data between '01/01/2014' and '01/08/2014'
        group by 
            hv.hvnd_vdr_id
        
    ),
    
    
    p2 as (
    
        select 
            hv.hvnd_vdr_id vendedor_id,
            count(*) total_vendas
        from 
            C##JOAO.hvendas hv
        where 
            hv.hvnd_data between '01/08/2014' and '01/04/2015'
        group by 
            hv.hvnd_vdr_id
        
    ),
    
    p3 as (
    
        select 
            v.vnd_vdr_id vendedor_id,
            count(*) total_vendas
        from 
            C##JOAO.vendas v
        group by 
            v.vnd_vdr_id
    
    )
    
    select 
        v.vdr_id vendedor_id,
        v.vdr_nome vendedor_nome,
        nvl(p1.total_vendas, 0) vendas_p1,
        nvl(p2.total_vendas, 0) vendas_p2,
        nvl(p3.total_vendas, 0) vendas_p3
    from 
        C##JOAO.vendedores v
        full join p1 on p1.vendedor_id = v.vdr_id
        full join p2 on p2.vendedor_id = v.vdr_id
        full join p3 on p3.vendedor_id = v.vdr_id;
    

-- View que analisa a data de venda de cada vendedor

create or replace view datas as
    with ultima_venda as (
    
        select 
            vr.vdr_id vendedor_id,
            max(vd.vnd_data) ultima_venda
        from 
            C##JOAO.vendedores vr
            join C##JOAO.vendas vd on vd.vnd_vdr_id = vr.vdr_id
        group by 
            vr.vdr_id
    ),
    
    primeira_venda as (
    
        select 
            vr.vdr_id vendedor_id,
            min(hv.hvnd_data) primeira_venda
        from 
            C##JOAO.vendedores vr
            join C##JOAO.hvendas hv on hv.hvnd_vdr_id = vr.vdr_id
        group by 
            vr.vdr_id
    
    )
    
    
    select
        v.vdr_id vendedor_id,
        p.primeira_venda primeira_venda, 
        u.ultima_venda ultima_venda
    from
        C##JOAO.vendedores v
        join primeira_venda p on p.vendedor_id = v.vdr_id
        join ultima_venda u on u.vendedor_id = v.vdr_id;


-- View que analisa o tipo de carros mais vendedido por cada vendedor
create or replace view carros as 
    with top_marca as (
    
        select 
            vdr_id vendedor_id,
            mar_nome,
            total_marcas
        from (
        
            select 
                vr.vdr_id,
                ma.mar_nome,
                count(*) total_marcas,
                row_number() over (partition by vr.vdr_id order by count(*) desc) rk
            from
                C##JOAO.vendedores vr
                join C##JOAO.vendas vd on vr.vdr_id = vd.vnd_vdr_id
                join C##JOAO.carros c on vd.vnd_car_id = c.car_id
                join C##JOAO.modelos m on c.car_mod_id = m.mod_id
                join C##JOAO.marcas ma on m.mod_mar_id = ma.mar_id
            group by
                vr.vdr_id,
                ma.mar_nome
                
        )where rk = 1
        
    
    ),
    
    top_modelo as (
    
        select 
            vdr_id vendedor_id,
            mod_nome,
            total_modelos
        from (
        
            select 
                vr.vdr_id,
                m.mod_nome,
                count(*) total_modelos,
                row_number() over (partition by vr.vdr_id order by count(*) desc) rk
            from
                C##JOAO.vendedores vr
                join C##JOAO.vendas vd on vr.vdr_id = vd.vnd_vdr_id
                join C##JOAO.carros c on vd.vnd_car_id = c.car_id
                join C##JOAO.modelos m on c.car_mod_id = m.mod_id
            group by
                vr.vdr_id,
                m.mod_nome
                
        )where rk = 1
        
    ),
    
    top_ano as (
    
        select 
            vdr_id vendedor_id,
            max(c.car_ano) maior_ano
        from 
            C##JOAO.vendedores vr
            join C##JOAO.vendas vd on vr.vdr_id = vd.vnd_vdr_id
            join C##JOAO.carros c on vd.vnd_car_id = c.car_id
        group by
            vr.vdr_id
            
    ),
    
    maior_quilometragem as (
        
        select 
            vdr_id vendedor_id,
            max(c.car_odometro) maior_quilometragem
        from 
            C##JOAO.vendedores vr
            join C##JOAO.vendas vd on vr.vdr_id = vd.vnd_vdr_id
            join C##JOAO.carros c on vd.vnd_car_id = c.car_id
        group by
            vr.vdr_id
    
    ),
    
    menor_quilometragem as (
    
        select 
            vdr_id vendedor_id,
            min(c.car_odometro) menor_quilometragem
        from 
            C##JOAO.vendedores vr
            join C##JOAO.vendas vd on vr.vdr_id = vd.vnd_vdr_id
            join C##JOAO.carros c on vd.vnd_car_id = c.car_id
        group by
            vr.vdr_id
    )
    
    
    select 
        v.vdr_id vendedor_id,
        tma.mar_nome nome_marca,
        tma.total_marcas,
        tmo.mod_nome nome_modelo,
        tmo.total_modelos,
        ta.maior_ano,
        maq.maior_quilometragem,
        meq.menor_quilometragem
    from 
        C##JOAO.vendedores v
        join top_marca tma on tma.vendedor_id = v.vdr_id
        join top_modelo tmo on tmo.vendedor_id = v.vdr_id
        join top_ano ta on ta.vendedor_id = v.vdr_id
        join maior_quilometragem maq on maq.vendedor_id = v.vdr_id
        join menor_quilometragem meq on meq.vendedor_id = v.vdr_id;

-- View que analisa os dados das vendas dos vendedores

create or replace view estatisticas as
    select 
        vp.vendedor_id,
        vp.vendas_p1,
        vp.vendas_p2,
        vp.vendas_p3,
        
        case
            when vp.vendas_p1 = 0 and vp.vendas_p2 > 0 then '100%'
            when vp.vendas_p1 = 0 and vp.vendas_p2 = 0 then '(Sem Vendas)'
            else to_char(ROUND(((vp.vendas_p2 - vp.vendas_p1) / vp.vendas_p1) * 100, 0), '999999') || '%' 
        end taxa_1p_2p,
    
        case
            when vp.vendas_p2 = 0 and vp.vendas_p3 > 0 then '100%'
            when vp.vendas_p2 = 0 and vp.vendas_p3 = 0 then '(Sem Vendas)'
            else to_char(ROUND(((vp.vendas_p3 - vp.vendas_p2) / vp.vendas_p2) * 100, 0), '999999') || '%' 
        end taxa_2p_3p,
    
        case
            when vp.vendas_p1 = 0 and vp.vendas_p3 > 0 then '100%'
            when vp.vendas_p1 = 0 and vp.vendas_p3 = 0 then '(Sem Vendas)'
            else to_char(ROUND(((vp.vendas_p3 - vp.vendas_p1) / vp.vendas_p1) * 100, 0), '999999') || '%' 
        end taxa_1p_3p,
    
        round(
            (nvl(vp.vendas_p1, 0) + nvl(vp.vendas_p2, 0) + nvl(vp.vendas_p3, 0)) / 
            (case when vp.vendas_p1 is null then 0 else 1 end +
             case when vp.vendas_p2 is null then 0 else 1 end + 
             case when vp.vendas_p3 is null then 0 else 1 end), 
             0
        ) media_vendas, 
        
        (vp.vendas_p1 + vp.vendas_p2 + vp.vendas_p3) total_vendas
    from
        vendas_por_periodo vp;
        
        
-- FÁBIO

CREATE OR REPLACE VIEW vendas_1p AS
    SELECT
        ma.mar_id,
        COUNT(*) AS vendas_1p,
        SUM(hv.hvnd_preco) AS lucro_bruto_1p
    FROM C##JOAO.hVendas hv
    JOIN C##JOAO.carros c ON hv.hvnd_car_id = c.car_id
    JOIN C##JOAO.modelos m ON c.car_mod_id = m.mod_id
    JOIN C##JOAO.marcas ma ON m.mod_mar_id = ma.mar_id
    WHERE
        hv.hvnd_data >= TO_DATE('01/01/2014', 'DD/MM/YYYY')
        AND hv.hvnd_data < TO_DATE('01/08/2014', 'DD/MM/YYYY')
    GROUP BY ma.mar_id;


CREATE OR REPLACE VIEW vendas_2p AS
    SELECT
        ma.mar_id,
        COUNT(*) AS vendas_2p,
        SUM(hv.hvnd_preco) AS lucro_bruto_2p
    FROM C##JOAO.hVendas hv
    JOIN C##JOAO.carros c ON hv.hvnd_car_id = c.car_id
    JOIN C##JOAO.modelos m ON c.car_mod_id = m.mod_id
    JOIN C##JOAO.marcas ma ON m.mod_mar_id = ma.mar_id
    WHERE
        hv.hvnd_data >= TO_DATE('01/08/2014', 'DD/MM/YYYY')
        AND hv.hvnd_data < TO_DATE('01/04/2015', 'DD/MM/YYYY')
    GROUP BY ma.mar_id;


CREATE OR REPLACE VIEW vendas_3p AS
    SELECT
        ma.mar_id,
        COUNT(*) AS vendas_3p,
        SUM(v.vnd_preco) AS lucro_bruto_3p
    FROM C##JOAO.vendas v
    JOIN C##JOAO.carros c ON v.vnd_car_id = c.car_id
    JOIN C##JOAO.modelos m ON c.car_mod_id = m.mod_id
    JOIN C##JOAO.marcas ma ON m.mod_mar_id = ma.mar_id
    WHERE
        v.vnd_data >= TO_DATE('01/04/2015', 'DD/MM/YYYY')
    GROUP BY ma.mar_id;


CREATE OR REPLACE VIEW estatisticas_marcas AS
    SELECT 
        ma.mar_id,
        ROUND(STATS_MODE(COALESCE(v.vnd_preco, hv.hvnd_preco)), 2) AS moda_preco,
        ROUND(AVG(COALESCE(v.vnd_preco, hv.hvnd_preco)), 2) AS media_preco,
        ROUND(MEDIAN(COALESCE(v.vnd_preco, hv.hvnd_preco)), 2) AS mediana_preco,
        MIN(hv.hvnd_data) AS primeira_venda,
        MAX(v.vnd_data) AS ultima_venda,
        RANK() OVER (ORDER BY COUNT(DISTINCT COALESCE(v.vnd_id, hv.hvnd_id)) DESC) AS ranking_vendas,
        (SELECT v.vnd_estado
         FROM C##JOAO.vendas v
         JOIN C##JOAO.carros c ON v.vnd_car_id = c.car_id
         JOIN C##JOAO.modelos m ON c.car_mod_id = m.mod_id
         WHERE m.mod_mar_id = ma.mar_id
         GROUP BY v.vnd_estado
         ORDER BY COUNT(v.vnd_id) DESC
         FETCH FIRST 1 ROW ONLY) AS estado_que_mais_vendeu
    FROM C##JOAO.marcas ma
    JOIN C##JOAO.modelos m ON ma.mar_id = m.mod_mar_id
    JOIN C##JOAO.carros c ON m.mod_id = c.car_mod_id
    LEFT JOIN C##JOAO.vendas v ON c.car_id = v.vnd_car_id
    LEFT JOIN C##JOAO.hVendas hv ON c.car_id = hv.hvnd_car_id
    GROUP BY ma.mar_id;
