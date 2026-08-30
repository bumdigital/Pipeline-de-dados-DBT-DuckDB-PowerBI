# Projeto de Engenharia de Dados — DuckDB + dbt + Power BI

## 📌 Sobre o projeto

Este projeto foi desenvolvido com o objetivo de praticar, de ponta a ponta, a construção de uma solução analítica de dados utilizando **DuckDB**, **dbt** e **Power BI**.

A solução parte de uma base de vendas em formato CSV e percorre as etapas de ingestão, transformação, qualidade, modelagem dimensional e disponibilização dos dados para consumo analítico.

O projeto utiliza uma arquitetura inspirada no padrão **Medallion Architecture**, organizando os dados nas camadas **Bronze**, **Silver** e **Gold**.

---

## 🏗️ Arquitetura

O fluxo de dados do projeto pode ser resumido da seguinte forma:

```text
CSV
 │
 ▼
Bronze
 │
 ▼
Silver
 │
 ▼
Gold
 │
 ▼
Power BI
```

### Bronze

Responsável pela ingestão dos dados provenientes do arquivo CSV.

Nesta camada, os dados são mantidos próximos à estrutura da fonte original, servindo como ponto inicial para as transformações posteriores.

### Silver

Responsável pela preparação e padronização dos dados.

Nesta etapa são aplicadas transformações necessárias para tornar os dados mais consistentes e adequados para a modelagem analítica, preservando as informações relevantes da origem.

### Gold

Responsável pela modelagem dos dados para consumo analítico.

Foi adotado um **modelo dimensional**, separando os dados entre tabela fato e dimensões:

```text
                dim_cliente
                     │
                     │
dim_produto ─── fato_pedidos ─── dim_localidade
                     │
                     │
                  dim_data
```

A camada Gold é composta por:

* `dim_cliente`
* `dim_produto`
* `dim_localidade`
* `dim_data`
* `fato_pedidos`

Essa estrutura facilita consultas analíticas e a construção do modelo utilizado pelo Power BI.

---

## 📊 Modelo dimensional

### `dim_cliente`

Representa os clientes presentes nas transações.

Principal atributo:

* `id_cliente`

### `dim_produto`

Representa os produtos comercializados.

Principais atributos:

* `id_produto`
* `categoria_produto`

### `dim_localidade`

Representa a localização associada às vendas.

Principais atributos:

* `uf`
* `cidade`

### `dim_data`

Dimensão responsável pela análise temporal.

A partir da data do pedido são disponibilizados atributos como:

* data
* ano
* mês
* trimestre

### `fato_pedidos`

Tabela central do modelo dimensional.

Contém as referências para as dimensões e as principais informações quantitativas e descritivas relacionadas às vendas, como:

* pedido
* cliente
* produto
* localidade
* data
* quantidade
* preço unitário
* percentual de desconto
* valor do frete
* valor bruto
* valor total
* canal de venda
* forma de pagamento
* status do pedido

---

## 🛠️ Tecnologias utilizadas

O projeto utiliza as seguintes tecnologias:

* **Python** — ambiente de desenvolvimento e suporte à execução local;
* **DuckDB** — banco de dados analítico local;
* **dbt (data build tool)** — transformação, modelagem, documentação e testes dos dados;
* **SQL** — desenvolvimento das transformações;
* **Power BI Desktop** — construção da camada de visualização;
* **ODBC** — comunicação entre o Power BI e o DuckDB;
* **Git** — versionamento do projeto.

---

## 📁 Estrutura do projeto

A estrutura principal do repositório segue aproximadamente a organização abaixo:

```text
.
├── data/
│   └── raw/
│       └── base_vendas_dbt_duckdb_100k.csv
│
├── models/
│   ├── bronze/
│   │   ├── vendas_bronze.sql
│   │   └── vendas_bronze.yml
│   │
│   ├── silver/
│   │   ├── vendas_silver.sql
│   │   └── vendas_silver.yml
│   │
│   └── gold/
│       ├── dim_categoria.sql
│       ├── dim_cliente.sql
│       ├── dim_data.sql
│       ├── dim_localidade.sql
│       ├── dim_produto.sql
│       ├── fato_pedidos.sql
│       └── schema.yml
│
├── dashboard/
│
├── macros/
├── tests/
│
├── dbt_project.yml
├── profiles.yml
├── requirements.txt
└── README.md
```

> A estrutura pode apresentar pequenas diferenças conforme a organização final adotada no repositório.

---

## ⚙️ Preparação do ambiente

### 1. Clonar o repositório

```bash
git clone <URL_DO_REPOSITORIO>
cd <NOME_DO_REPOSITORIO>
```

### 2. Criar o ambiente virtual

No Windows:

```powershell
python -m venv .venv
```

Ative o ambiente:

```powershell
.\.venv\Scripts\Activate.ps1
```

### 3. Instalar as dependências

```powershell
pip install -r requirements.txt
```

---

## 🔧 Configuração do dbt

O projeto utiliza o adapter do DuckDB para permitir que o dbt execute os modelos diretamente sobre o banco local.

Para validar a configuração:

```powershell
dbt debug
```

Se a configuração estiver correta, o dbt deverá confirmar a conexão com o DuckDB.

---

## ▶️ Executando o projeto

Com o ambiente virtual ativado, execute:

```powershell
dbt build
```

Esse comando executa os modelos e os testes configurados no projeto.

O fluxo esperado é:

```text
CSV
 ↓
vendas_bronze
 ↓
vendas_silver
 ↓
dimensões + fato_pedidos
```

Também é possível executar apenas os modelos:

```powershell
dbt run
```

Ou executar somente os testes:

```powershell
dbt test
```

---

## 🧪 Qualidade dos dados

O projeto utiliza os recursos de testes do dbt para realizar verificações básicas de qualidade.

Entre as validações aplicadas estão:

* `not_null`
* `unique`
* testes de relacionamento entre fato e dimensões
* validação da existência de registros nos modelos

Os testes ajudam a garantir que as principais chaves e relacionamentos do modelo permaneçam consistentes durante a execução do pipeline.

---

## 📈 Dashboard Power BI

A etapa final do projeto consiste na construção de um dashboard no **Power BI Desktop** utilizando a camada Gold como fonte de dados.

O modelo dimensional criado no DuckDB é disponibilizado ao Power BI através de uma conexão **ODBC**.

O dashboard apresenta uma visão geral das vendas, incluindo indicadores e análises como:

* faturamento total;
* quantidade vendida;
* quantidade de pedidos;
* ticket médio;
* faturamento ao longo do tempo;
* faturamento por categoria;
* faturamento por UF;
* filtros por período, categoria e localização.

O arquivo do Power BI é disponibilizado junto ao repositório como um artefato do projeto.

Para utilizá-lo localmente, é necessário possuir o **Power BI Desktop** instalado e configurar a conexão ODBC com o banco DuckDB conforme a documentação específica disponível no projeto.

---

## 🧠 Conceitos praticados

Além da implementação técnica, o projeto foi utilizado para exercitar conceitos importantes de Engenharia e Modelagem de Dados, incluindo:

* arquitetura em camadas;
* separação de responsabilidades entre Bronze, Silver e Gold;
* transformação de dados com dbt;
* testes de qualidade;
* identificação do grão dos dados;
* identificação de entidades;
* definição de dimensões e fatos;
* modelagem dimensional;
* relacionamentos entre tabelas;
* definição de medidas analíticas;
* construção de uma camada preparada para BI;
* integração entre DuckDB e Power BI.

---

## 🎯 Resultado

Ao final do projeto, foi construída uma solução analítica local completa:

```text
Fonte de Dados
     │
     ▼
    CSV
     │
     ▼
   DuckDB
     │
     ├── Bronze
     │
     ├── Silver
     │
     └── Gold
          │
          ▼
    Modelo Dimensional
          │
          ▼
       Power BI
          │
          ▼
       Dashboard
```

O projeto demonstra como ferramentas leves e executadas localmente podem ser combinadas para construir um pipeline de dados organizado, testável, versionável e preparado para consumo analítico.

---

## 📚 Objetivo de aprendizado

Mais do que produzir um dashboard final, o principal objetivo deste projeto foi percorrer o ciclo completo de construção de uma solução de dados.

O exercício permitiu conectar conceitos que muitas vezes são estudados separadamente — ingestão, transformação, qualidade, modelagem e visualização — dentro de um único fluxo.

Dessa forma, o projeto funciona também como material prático de estudo sobre **Engenharia de Dados, Analytics Engineering e Modelagem Dimensional**.
