<<<<<<< HEAD
# 📊 Projeto SQL - Análise de Hemogramas

Este projeto reúne consultas SQL aplicadas a uma base de dados de hemogramas, com o objetivo de explorar diferenças entre sexo e dispositivos de medição.  
É parte do meu portfólio de projetos de análise de dados.

---
## 🧩 Objetivo Geral
  O projeto aplica técnicas de análise de dados em exames laboratoriais, explorando padrões e insights que possam apoiar estudos clínicos e científicos.
## 🎯 Objetivos específicos
- Comparar médias de parâmetros sanguíneos (HGB, HCT, RBC, PLT, WBC) por sexo.
- Avaliar diferenças entre dispositivos de medição (`DevTyp`).
- Calcular variabilidade, erro padrão e proporção de valores anormais.
- Explorar estatísticas descritivas e distribuições.
## 📊 Fonte dos Dados

Os dados utilizados neste projeto foram extraídos do artigo:

Safa S. Abdul-Jabbar, Alaa K. Farhan.  
*Hematology Patients Dataset in Iraq (2022)*.  
Computer Science Dept., University of Baghdad e University of Technology, Baghdad.  

O dataset contém informações de **300 pacientes**, com **28 variáveis de exames de hemograma (CBC)**, coletados no Hematology Center da Medical City em 2022.  
Esses dados foram disponibilizados em formato Excel, permitindo limpeza e análise em diferentes linguagens de programação.

Agradecimentos especiais ao Hematology Center e ao Dr. Mohammed Saleem Abbas pela colaboração na coleta dos dados.

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
-Clone este repositório:
   ```bash
   git clone https://github.com/shgutierrez/projeto-hemograma-sql.git
=======
# projeto-hemograma-sql
Scripts em SQlite para verificar diferenças entre dois dispositivos de análises hematológicas em um banco de dados
>>>>>>> 92059f8104e654438e5a6954fde627bd672add1b

## 👩‍💻 Autoria
Desenvolvido por **Sheila Gutierrez** como parte da formação como Analista de Dados.
