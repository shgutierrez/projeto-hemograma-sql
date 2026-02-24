--Análise básica da base de dados e entendimento do problema. Análise exploratória (verificar difereneças de leitura em pacientes agrupados por sexo)
SELECT 
    CASE WHEN Gender = 0 THEN 'Feminino' ELSE 'Masculino' END AS sexo,
    AVG(HCT) AS media_hematocrito
FROM hemograma
GROUP BY sexo;

--Hemoglobina por sexo
SELECT 
    CASE WHEN Gender = 0 THEN 'Feminino' ELSE 'Masculino' END AS sexo,
    AVG(HGB) AS media_hemoglobina
FROM hemograma
GROUP BY sexo;

--Correlação RBC vs HCT (simples média agrupada)
SELECT AVG(RBC) AS media_rbc, AVG(HCT) AS media_hct
FROM hemograma;

--Plaquetas por sexo
SELECT 
    CASE WHEN Gender = 0 THEN 'Feminino' ELSE 'Masculino' END AS sexo,
    AVG(PLT) AS media_plaquetas,
    AVG(MPV) AS media_mpv,
    AVG(PLCR) AS media_plcr
FROM hemograma
GROUP BY sexo;

--Diferença por dispositivo
SELECT DevTyp, AVG(HGB) AS media_hgb, AVG(HCT) AS media_hct
FROM hemograma
GROUP BY DevTyp;

--Contagem de parâmetros alterados por sexo (Gender) para hgb e hct
SELECT 
    CASE WHEN Gender = 0 THEN 'Feminino' ELSE 'Masculino' END AS sexo,
    SUM(CASE WHEN (Gender = 1 AND (HGB < 13.5 OR HGB > 17.5)) 
              OR (Gender = 0 AND (HGB < 12.0 OR HGB > 15.5)) 
             THEN 1 ELSE 0 END) AS alterados_hgb,
    SUM(CASE WHEN (Gender = 1 AND (HCT < 41 OR HCT > 53)) 
              OR (Gender = 0 AND (HCT < 36 OR HCT > 46)) 
             THEN 1 ELSE 0 END) AS alterados_hct
FROM hemograma
GROUP BY sexo;