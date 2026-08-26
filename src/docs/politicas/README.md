# Políticas de Segurança — RLS

Documentação das políticas de Row Level Security (RLS) utilizadas no banco de dados.

## Modelo de autorização

Existem três papéis principais de acesso:

### Administrador
Identificado por:
```sql
((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin'
```
Pode gerenciar (SELECT/INSERT/UPDATE/DELETE) os registros de todas as tabelas.

### Usuário autenticado
Identificado pelo e-mail presente no JWT:
```sql
auth.jwt() ->> 'email'
```
O acesso aos dados vinculados à assinatura é feito através do `id_assinante`
correspondente ao e-mail autenticado (via `public.assinante`).

### Usuário anônimo (`anon`)
Pode consultar apenas as tabelas consideradas catálogo público.

## Regras gerais

| Tipo de dado          | Anon   | Autenticado     | Admin |
|------------------------|:------:|:---------------:|:-----:|
| Catálogo público        | SELECT | SELECT          | ALL   |
| Status de cobrança      | —      | SELECT          | ALL   |
| Dados da assinatura     | —      | Próprios        | ALL   |
| Histórico de assinatura | —      | Próprio (leitura)| ALL  |
| Faturas                 | —      | Próprias (leitura)| ALL |
| Dispositivos            | —      | Próprios (ALL)  | ALL   |
| Perfis                  | —      | Próprios (ALL)  | ALL   |
| Visualizações           | —      | Próprias (SELECT/INSERT/UPDATE) | ALL |

## Documentação por área

- [Assinante](./assinante.md)
- [Catálogo](./catalogo.md)
- [Assinatura (histórico e faturas)](./assinatura.md)
- [Dispositivos](./dispositivo.md)
- [Perfis](./perfil.md)
- [Visualizações](./visualizacao.md)

## SQL correspondente

Os scripts executáveis (`CREATE POLICY ...`) ficam em `supabase/policies/`,
um arquivo por área, seguindo o mesmo agrupamento desta documentação.
