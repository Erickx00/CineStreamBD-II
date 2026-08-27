# 🎬 StreamFlix DB — Banco de Dados de uma Plataforma de Streaming

Projeto de banco de dados relacional que modela o funcionamento interno de uma plataforma de streaming de vídeo (nos moldes de serviços como Netflix ou Prime Video), cobrindo desde o cadastro de assinantes e perfis até o controle de assinaturas, faturamento, catálogo de obras e histórico de visualizações.

Desenvolvido originalmente para a disciplina de **Banco de Dados I**, o projeto está sendo evoluído com recursos do **Supabase**, incorporando conceitos de segurança e controle de acesso a dados através de **Row Level Security (RLS)**, **Policies** e **Grants**.

---

## 📖 Descrição

O projeto consiste na modelagem e implementação de um banco de dados relacional em **PostgreSQL**, hospedado no **Supabase**, que simula o núcleo de dados de uma plataforma de streaming. O modelo contempla assinantes, planos de assinatura, perfis de usuário, catálogo de obras (filmes e séries), episódios, gêneros, profissionais do audiovisual (atores e diretores), dispositivos, histórico de visualizações e faturamento.

Além da estrutura de dados em si, o projeto avança para uma camada de **segurança e governança de acesso**, definindo quem pode ler, inserir, atualizar ou remover cada tipo de informação no banco — um aspecto essencial em sistemas reais que lidam com dados sensíveis de usuários e cobrança.

---

## 🎯 Objetivo

O objetivo principal é aplicar, na prática, os conceitos fundamentais de modelagem e implementação de bancos de dados relacionais, incluindo:

- Modelagem conceitual e lógica de um domínio realista e com múltiplas entidades inter-relacionadas;
- Definição de chaves primárias, chaves estrangeiras, restrições de integridade e regras de negócio via `CHECK`;
- Implementação do modelo em um SGBD relacional (PostgreSQL);
- Aplicação de mecanismos de segurança e controle de acesso a dados (RLS, Policies e Grants) usando o Supabase como plataforma de gerenciamento.

---

## 💡 Motivação

Plataformas de streaming lidam diariamente com grandes volumes de dados sensíveis: informações pessoais de assinantes, dados de pagamento, hábitos de consumo e preferências de cada perfil. Esse cenário é um excelente estudo de caso para banco de dados, pois exige:

- Um modelo relacional robusto, capaz de representar relacionamentos complexos (assinante → perfis → visualizações, obras → gêneros → profissionais, entre outros);
- Preocupação real com segurança e privacidade, já que nem todo usuário deveria ter acesso irrestrito a todos os dados do sistema.

A escolha do tema surgiu do interesse do grupo em unir a teoria de Banco de Dados I a um cenário próximo da realidade, e posteriormente aprofundar o projeto explorando as ferramentas de segurança oferecidas pelo Supabase, indo além do que normalmente é abordado em um projeto introdutório de disciplina.

---

## 🎓 Contexto acadêmico

Este projeto foi desenvolvido como parte da disciplina de **Banco de Dados I**, com foco inicial em modelagem entidade-relacionamento, normalização e implementação do esquema em SQL. Posteriormente, o projeto foi retomado como um estudo complementar para explorar recursos de bancos de dados modernos baseados em nuvem, utilizando o Supabase para adicionar uma camada de segurança e controle de acesso que não fazia parte do escopo original da disciplina.

---

## 🛠️ Tecnologias utilizadas

- **PostgreSQL** — sistema de gerenciamento de banco de dados relacional;
- **Supabase** — plataforma de backend como serviço (BaaS) utilizada para hospedar e gerenciar o banco de dados, incluindo autenticação e segurança;
- **SQL** — linguagem utilizada para definição do esquema (DDL), consultas e regras de negócio;
- **Row Level Security (RLS)** — mecanismo de segurança em nível de linha do PostgreSQL/Supabase;
- **Policies** — políticas de acesso que definem regras de leitura e escrita por tabela;
- **Grants** — permissões de acesso concedidas a diferentes papéis (roles) do banco.


---

## ⚙️ Funcionalidades principais

O modelo de dados permite representar e gerenciar:

- **Assinantes**, com dados cadastrais e status da conta (ativa/inativa);
- **Planos de assinatura**, com quantidade máxima de telas simultâneas e qualidade de resolução (SD, Full-HD, 4K);
- **Histórico de assinaturas**, registrando trocas de plano ao longo do tempo, com datas e valores cobrados;
- **Faturamento**, com faturas mensais e status de cobrança (pendente, paga, atrasada ou estornada);
- **Dispositivos** vinculados a cada assinante;
- **Perfis**, cada um com nome de exibição, avatar e classificação etária (infantil, adolescente ou adulto);
- **Catálogo de obras** (filmes e séries), com título, sinopse, ano de lançamento e idade mínima recomendada;
- **Episódios**, organizados por temporada, para obras do tipo série;
- **Gêneros**, associados a uma ou mais obras;
- **Profissionais** (atores e diretores), associados às obras em que atuaram;
- **Visualizações**, registrando data/hora, porcentagem assistida e dispositivo utilizado por cada perfil.

---

## 🏗️ Arquitetura / Estrutura geral

O banco de dados é composto por entidades centrais que se relacionam em torno de três grandes eixos:

1. **Gestão de assinantes** — `assinante`, `plano`, `historico_assinatura`, `fatura`, `status_cobranca`, `dispositivo`;
2. **Perfis e consumo de conteúdo** — `perfil`, `classificacao_maturidade`, `visualizacao`;
3. **Catálogo de conteúdo** — `obra`, `episodio`, `genero`, `obra_genero`, `profissional`, `obra_profissional`, `qualidade_resolucao`.

Essas entidades se conectam por meio de chaves estrangeiras e tabelas associativas (como `obra_genero` e `obra_profissional`), permitindo relacionamentos muitos-para-muitos, enquanto restrições `CHECK` garantem a integridade de dados como status de cobrança, classificação etária e qualidade de resolução.

O esquema completo, com a definição de todas as tabelas, chaves e restrições, está disponível no script SQL do repositório.

[Documentaçao](https://github.com/Erickx00/cinestream-db)

---

## 🔐 Segurança e controle de acesso

Como parte da evolução do projeto no Supabase, foram implementados mecanismos de **Row Level Security (RLS)**, **Policies** e **Grants**, com o objetivo de restringir o acesso aos dados de acordo com o perfil de quem realiza a consulta — evitando, por exemplo, que um usuário tenha acesso a dados de faturamento ou de visualização de outros assinantes.

Esse controle é fundamental em sistemas que armazenam dados pessoais e financeiros, sendo uma prática essencial em ambientes de produção reais. A implementação técnica detalhada de cada Policy e Grant (tabelas afetadas, papéis envolvidos e regras aplicadas) está descrita na documentação específica do projeto, referenciada na seção abaixo.

---

## 📄 Documentação

A documentação técnica completa do projeto —  seus relacionamentos, e a especificação de todas as Policies e Grants implementadas — está disponível em:

[Documentaçao](https://github.com/Erickx00/cinestream-db)

---

## 👥 Integrantes

- Erick — [GitHub](https://github.com/Erickx00)
- Pedro — [GitHub](https://github.com/PH-dev30)
- Arley — [GitHub](https://github.com/c/LINK)
- Wesley — [GitHub](https://github.com/DevKardozo)

---

## 📌 Considerações finais

Este projeto representa a evolução de um trabalho acadêmico de Banco de Dados I em direção a práticas mais próximas do que é utilizado em ambientes de produção, unindo modelagem relacional sólida a mecanismos de segurança oferecidos por uma plataforma moderna como o Supabase. O resultado é um material que serve tanto como exercício de fixação dos conceitos da disciplina quanto como referência prática de aplicação de RLS, Policies e Grants em um cenário realista.