--o dispositivo 1 é padrão, será usado como controle e o dispositivo 2 como teste: 
--comparar os resultados entre os dois dispositivos para uma amostra de 100 indivíduos escolhidos aleatoriamente

SELECT *
FROM hemograma h 
ORDER BY RANDOM()
LIMIT 100;

SELECT 
    h1.ID,
    h1.Gender,
    h1.WBC AS wbc_dev1,
    h2.WBC AS wbc_dev2,
    h1.HGB AS hgb_dev1,
    h2.HGB AS hgb_dev2,
    h1.HCT AS hct_dev1,
    h2.HCT AS hct_dev2,
    h1.RBC AS rbc_dev1,
    h2.RBC AS rbc_dev2,
    h1.PLT AS plt_dev1,
    h2.PLT AS plt_dev2
FROM (
    SELECT *
    FROM hemograma
    ORDER BY RANDOM()
    LIMIT 100
) amostra
JOIN hemograma h1 ON amostra.ID = h1.ID AND h1.DevTyp = 1
JOIN hemograma h2 ON amostra.ID = h2.ID AND h2.DevTyp = 2;

--não houve resultados, vamos tentar diagnosticar

-- Ver os primeiros registros
SELECT * FROM hemograma LIMIT 10;

-- Ver os valores distintos de DevTyp
SELECT DISTINCT DevTyp FROM hemograma;

-- Ver quantos registros por ID
SELECT ID, COUNT(*) 
FROM hemograma
GROUP BY ID
ORDER BY COUNT(*) DESC
LIMIT 20;
--depois desta análise, ficou claro que existe apenas um registro por dispositivo, com este cenário, podemos ver algumas coisas nesta base
--estatística descritiva para cada dispositivo
SELECT 
    DevTyp,
    AVG(WBC) AS media_wbc,
    MIN(WBC) AS min_wbc,
    MAX(WBC) AS max_wbc,
    AVG(HGB) AS media_hgb,
    AVG(HCT) AS media_hct,
    AVG(RBC) AS media_rbc,
    AVG(PLT) AS media_plt
FROM hemograma
GROUP BY DevTyp;
--Distribuição por sexo e dispositivo
SELECT 
    DevTyp,
    CASE WHEN Gender = 0 THEN 'female' ELSE 'male' END AS genero,
    COUNT(*) AS qtd_individuos,
    AVG(WBC) AS media_wbc
FROM hemograma
GROUP BY DevTyp, genero;--o dispositivo 2 parece registrar valores de médias de wbc menores, para ambos sexos
--Frequência de valores anormais por dispositivo
SELECT 
    DevTyp,
    SUM(CASE WHEN WBC < 4 OR WBC > 11 THEN 1 ELSE 0 END) AS qtd_wbc_anormal,
    SUM(CASE WHEN HGB < 12 OR HGB > 16 THEN 1 ELSE 0 END) AS qtd_hgb_anormal,
    SUM(CASE WHEN HCT < 36 OR HCT > 46 THEN 1 ELSE 0 END) AS qtd_hct_anormal,
    SUM(CASE WHEN RBC < 4.2 OR RBC > 5.9 THEN 1 ELSE 0 END) AS qtd_rbc_anormal,
    SUM(CASE WHEN PLT < 150 OR PLT > 450 THEN 1 ELSE 0 END) AS qtd_plt_anormal
FROM hemograma
GROUP BY DevTyp;--o dispositivo 2 detectou mais quantidade de valores anormais na base de dados
--Comparar variabilidade (desvio padrão)
SELECT 
    DevTyp,
    AVG(WBC) AS media_wbc,
    printf("%.2f", sqrt(AVG((WBC - (SELECT AVG(WBC) FROM hemograma WHERE DevTyp = h.DevTyp))*(WBC - (SELECT AVG(WBC) FROM hemograma WHERE DevTyp = h.DevTyp))))) AS desvio_wbc
FROM hemograma h
GROUP BY DevTyp;--o dispositivo 1 tem uma variabilidade maior para wbc
--o dispositivo 2 pode estar mais “sensível” ou calibrado para detectar desvios, enquanto o 1 tem medidas mais dispersas??
--vamos calcular o erro padrão da média, para sabermos o quanto essas média estimada pode variar se repetirmos a amostragem. 
--É útil para comparar a precisão das médias entre os dispositivos
SELECT 
    DevTyp,
    AVG(WBC) AS media_wbc,
    COUNT(WBC) AS n,
    -- variância amostral
    SUM((WBC - (SELECT AVG(WBC) FROM hemograma WHERE DevTyp = h.DevTyp)) * 
        (WBC - (SELECT AVG(WBC) FROM hemograma WHERE DevTyp = h.DevTyp))) / 
        (COUNT(WBC) - 1) AS variancia,
    -- desvio padrão
    sqrt(SUM((WBC - (SELECT AVG(WBC) FROM hemograma WHERE DevTyp = h.DevTyp)) * 
             (WBC - (SELECT AVG(WBC) FROM hemograma WHERE DevTyp = h.DevTyp))) / 
             (COUNT(WBC) - 1)) AS desvio_padrao,
    -- erro padrão
    sqrt(SUM((WBC - (SELECT AVG(WBC) FROM hemograma WHERE DevTyp = h.DevTyp)) * 
             (WBC - (SELECT AVG(WBC) FROM hemograma WHERE DevTyp = h.DevTyp))) / 
             (COUNT(WBC) - 1)) / sqrt(COUNT(WBC)) AS erro_padrao
FROM hemograma h
GROUP BY DevTyp;--O n maior do dispositivo 2 (206 vs 94) explica o erro padrão bem mais baixo: quanto maior a amostra, mais precisa a média.
--O dispositivo 1 tem variabilidade enorme → pode ser ruído do aparelho, calibragem diferente ou até outliers.
--O dispositivo 2 parece mais consistente (desvio padrão pequeno e erro padrão baixo), mas registra médias menores.
--Já vimos que o dispositivo 2 detecta mais anormais. Podemos calcular a proporção (%) de anormais em cada dispositivo e comparar.
SELECT 
    DevTyp,
    COUNT(*) AS total_individuos,
    SUM(CASE WHEN WBC < 4 OR WBC > 11 THEN 1 ELSE 0 END) AS qtd_anormais,
    ROUND(100.0 * SUM(CASE WHEN WBC < 4 OR WBC > 11 THEN 1 ELSE 0 END) / COUNT(*), 2) AS perc_anormais
FROM hemograma
GROUP BY DevTyp;

--exportar dados para rodar um teste de normalidade no R
SELECT ID, DevTyp, Gender, WBC,HCT, PLT 
FROM hemograma;