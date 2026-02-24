--Pergunta: Existe diferenças, por resultado do hemograma, entre os dispositivos utilizados
--Pacientes testados por dispositivo
SELECT 
    DevTyp,
    COUNT(*) AS n_pacientes
FROM hemograma
GROUP BY DevTyp;

--Médias de parâmetros sanguineos por dispositivo testado
SELECT DevTyp, 
COUNT(*) AS n_pacientes, 
AVG(WBC) AS media_WBC, 
AVG(HGB) AS media_HGB, 
AVG(HCT) AS media_HCT, 
AVG(RBC) AS media_RBC, 
AVG(PLT) AS media_PLT 
FROM hemograma 
GROUP BY DevTyp

--Comparação de variabilidade por dispositivo
SELECT 
    DevTyp,

    SELECT 
    DevTyp,
    AVG(WBC) AS media_WBC,
    sqrt(AVG(WBC * 1.0 * WBC) - (AVG(WBC) * AVG(WBC))) AS desvio_WBC,
    AVG(HGB) AS media_HGB,
    sqrt(AVG(HGB * 1.0 * HGB) - (AVG(HGB) * AVG(HGB))) AS desvio_HGB,
    AVG(HCT) AS media_HCT,
    sqrt(AVG(HCT * 1.0 * HCT) - (AVG(HCT) * AVG(HCT))) AS desvio_HCT,
    AVG(RBC) AS media_RBC,
    sqrt(AVG(RBC * 1.0 * RBC) - (AVG(RBC) * AVG(RBC))) AS desvio_RBC,
    AVG(PLT) AS media_PLT,
    sqrt(AVG(PLT * 1.0 * PLT) - (AVG(PLT) * AVG(PLT))) AS desvio_PLT
FROM hemograma
GROUP BY DevTyp;

SELECT 
DevTyp, 
Gender, 
AVG(WBC) AS media_wbc,
AVG(HGB) AS media_hgb,
AVG(h.HCT) AS media_hct,
AVG(h.RBC) AS media_rbc,
AVG(h.PLT) AS media_plt
FROM hemograma h 
GROUP BY DevTyp , Gender;

SELECT 
   *
FROM hemograma h 
LIMIT 100

SELECT 
    CASE 
        WHEN Gender = 0 THEN 'female' 
        ELSE 'male' 
    END AS genero,
    COUNT(*) AS qtd_wbc_baixa
FROM hemograma
WHERE WBC < 4
GROUP BY 
    CASE 
        WHEN Gender = 0 THEN 'female' 
        ELSE 'male' 
    END;
SELECT 
     CASE 
          WHEN Gender=0 THEN 'female'
          ELSE 'male'
          END AS genero,
     CASE 
          WHEN DevTyp=1 THEN 'disp1'
          ELSE 'disp2'
          END AS disp,
          COUNT(*) AS qt_baixa_disp
FROM hemograma h 
GROUP BY 
     CASE 
        WHEN Gender = 0 THEN 'female' 
        ELSE 'male' 
    END;


