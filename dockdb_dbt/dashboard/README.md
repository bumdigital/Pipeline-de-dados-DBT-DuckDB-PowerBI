# Dashboard Power BI

Esta pasta contém o dashboard desenvolvido em **Power BI Desktop** para visualização e análise dos dados processados pelo projeto.

## Arquivo

O dashboard está disponível no arquivo:

`vendas_dashboard.pbix`

Para abri-lo, é necessário possuir o **Power BI Desktop** instalado na máquina.

## Fonte de dados

O dashboard utiliza como fonte de dados o banco **DuckDB** gerado pelo projeto.

Os dados apresentados são provenientes da **camada Gold**, construída com dbt e organizada para consumo analítico.

A conexão entre o Power BI e o DuckDB é realizada por meio de **ODBC**.

## Pré-requisitos

Antes de abrir o dashboard, certifique-se de que:

1. O projeto foi clonado localmente.
2. O ambiente dbt está configurado corretamente.
3. Os modelos foram materializados no DuckDB por meio do dbt.
4. O driver ODBC do DuckDB está instalado.
5. A fonte de dados ODBC utilizada pelo Power BI está configurada para apontar para o banco DuckDB local.

## Gerando os dados

Na raiz do projeto dbt, execute:

```powershell
dbt debug
dbt build
```

O primeiro comando valida a configuração e a conexão do dbt.

O segundo executa os modelos e testes do projeto, materializando as camadas **Bronze**, **Silver** e **Gold**.

## Abrindo o dashboard

Após preparar o banco e configurar a conexão ODBC:

1. Abra o arquivo `vendas_dashboard.pbix` no Power BI Desktop.
2. Caso necessário, atualize as configurações da fonte de dados para utilizar o DSN ODBC configurado na máquina.
3. Clique em **Atualizar** no Power BI para carregar os dados mais recentes.

## Arquitetura

O fluxo de dados utilizado pelo dashboard pode ser resumido da seguinte forma:

`CSV → Bronze → Silver → Gold → Power BI`

O dbt é responsável pelas transformações e pela modelagem dos dados no DuckDB, enquanto o Power BI atua como camada de visualização e consumo analítico.

## Observação

O arquivo `.pbix` é um artefato binário. Ele pode ser armazenado e versionado pelo Git, porém alterações internas no dashboard não podem ser comparadas por meio de `git diff` da mesma forma que arquivos SQL, YAML ou Python.
