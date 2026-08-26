# Política RLS — Assinatura (Histórico e Faturas)

## Objetivo

Garantir que dados sensíveis vinculados à assinatura — histórico e faturas —
só possam ser lidos pelo próprio dono. Escrita é restrita a administradores.

## Tabelas cobertas

- `historico_assinatura`
- `fatura`

## Regras

### Usuário autenticado
- Pode **ler** (SELECT) apenas os registros vinculados ao seu `id_assinante`.
- Não pode inserir, atualizar ou apagar registros.

A vinculação é feita via subquery:
```sql
id_assinante IN (
  SELECT id_assinante FROM public.assinante
  WHERE email = (auth.jwt() ->> 'email')
)
```

### Administrador
- Acesso completo (ALL) em ambas as tabelas.

### Usuário anônimo
- Sem acesso.

## Matriz de acesso

| Operação | anon | authenticated       | admin |
|----------|:----:|:--------------------:|:-----:|
| SELECT   | ❌   | próprios registros   | ✅    |
| INSERT   | ❌   | ❌                    | ✅    |
| UPDATE   | ❌   | ❌                    | ✅    |
| DELETE   | ❌   | ❌                    | ✅    |

## Policies

- `usuario le seu historico de assinatura`
- `admin gerencia historico_assinatura`
- `usuario le suas faturas`
- `admin gerencia faturas`

Arquivo SQL correspondente: [`supabase/policies/assinatura.sql`](../../supabase/policies/assinatura.sql)
