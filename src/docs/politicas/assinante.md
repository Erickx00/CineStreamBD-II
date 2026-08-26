# Política RLS — Assinante

## Objetivo

Garantir que um usuário autenticado consiga consultar e atualizar somente o
próprio registro na tabela `public.assinante`. Administradores possuem acesso
completo. Usuários anônimos não têm acesso.

## Regras

### Usuário autenticado
- Pode consultar o próprio registro.
- Pode atualizar o próprio registro.

Identificação via e-mail do JWT:
```sql
auth.jwt() ->> 'email'
```
O e-mail precisa corresponder ao campo `public.assinante.email`.

### Administrador
Usuários com `app_metadata.role = 'admin'` possuem acesso completo (ALL).

### Usuário anônimo
O papel `anon` não possui nenhuma policy nesta tabela — sem acesso.

## Matriz de acesso

| Operação | anon | authenticated       | admin |
|----------|:----:|:--------------------:|:-----:|
| SELECT   | ❌   | próprio registro     | ✅    |
| INSERT   | ❌   | ❌                    | ✅    |
| UPDATE   | ❌   | próprio registro     | ✅    |
| DELETE   | ❌   | ❌                    | ✅    |

## Policies

- `assinante lê apenas seu registro`
- `assinante atualiza apenas seu registro`
- `admin gerencia assinantes`

Arquivo SQL correspondente: [`supabase/policies/assinante.sql`](../../supabase/policies/assinante.sql)
