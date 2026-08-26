# Política RLS — Catálogo Público

## Objetivo

Tabelas de catálogo têm o mesmo comportamento: leitura livre para todo mundo
(inclusive anônimos) e escrita restrita a administradores.

## Tabelas cobertas

- `plano`
- `qualidade_resolucao`
- `classificacao_maturidade`
- `status_cobranca` *(exceção — ver observação abaixo)*
- `obra`
- `genero`
- `profissional`
- `obra_genero`
- `obra_profissional`
- `episodio`

## Regras

### Usuário anônimo e autenticado
- Podem consultar (SELECT) livremente todas as tabelas de catálogo.

### Administrador
- Acesso completo (ALL) para gerenciar o catálogo.

## Observação — `status_cobranca`

`status_cobranca` é uma tabela de apoio (não é dado pessoal), mas **não** é
liberada para `anon` — apenas `authenticated` tem SELECT. Fora essa diferença,
segue o mesmo padrão de admin com acesso total.

## Matriz de acesso

| Operação | anon | authenticated | admin |
|----------|:----:|:--------------:|:-----:|
| SELECT   | ✅ (exceto status_cobranca) | ✅ | ✅ |
| INSERT/UPDATE/DELETE | ❌ | ❌ | ✅ |

## Policies

Para cada tabela: `todos leem <tabela>` (ou `authenticated le status_cobranca`)
+ `admin gerencia <tabela>`.

Arquivo SQL correspondente: [`supabase/policies/catalogo.sql`](../../supabase/policies/catalogo.sql)
