# 📊 Projeto SQL - Análise de Hemogramas

Este projeto reúne consultas SQL aplicadas a uma base de dados de hemogramas, com o objetivo de explorar diferenças entre sexo e dispositivos de medição.  
É parte do meu portfólio de projetos de análise de dados.

---

## 🎯 Objetivos
- Comparar médias de parâmetros sanguíneos (HGB, HCT, RBC, PLT, WBC) por sexo.
- Avaliar diferenças entre dispositivos de medição (`DevTyp`).
- Calcular variabilidade, erro padrão e proporção de valores anormais.
- Explorar estatísticas descritivas e distribuições.

---

## 📂 Estrutura do Projeto


- **scripts/analises_basicas.sql** → consultas iniciais (médias por sexo, correlações simples).
- **scripts/comparacao_dispositivos.sql** → comparação entre dispositivos, variabilidade e proporções.
- **scripts/estatisticas_descritivas.sql** → estatísticas descritivas e distribuições.

---

## 🛠️ Tecnologias
- SQL (testado em SQLite/PostgreSQL)
- Dataset fictício de hemogramas

---

## 📈 Principais Insights
- O **dispositivo 2** apresentou médias menores de WBC e maior proporção de valores anormais.
- O **dispositivo 1** mostrou maior variabilidade nos resultados.
- Diferenças entre sexos foram observadas em HGB e HCT, conforme esperado.
- O tamanho da amostra influencia diretamente a precisão das médias (erro padrão menor no dispositivo 2).

---

## 🚀 Como usar
1. Clone este repositório:
   ```bash
   git clone https://github.com/shgutierrez/projeto-hemograma-sql.git
