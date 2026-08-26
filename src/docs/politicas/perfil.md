# Política RLS — Perfil

## Objetivo

O usuário gerencia livremente (ALL) os perfis vinculados à sua própria
assinatura (ex: perfis dentro da conta, estilo "perfil por membro da família").
Administradores têm acesso completo. Anônimos não têm acesso.

## Regras

### Usuário autenticado
- Pode fazer SELECT, INSERT, UPDATE e DELETE nos próprios perfis.

Vinculação via `id_assinante`:
```sql
id_assinante IN (
  SELECT id_assinante FROM public.assinante
  WHERE email = (auth.jwt() ->> 'email')
)
```

### Administrador
- Acesso completo (ALL).

### Usuário anônimo
- Sem acesso.

## Matriz de acesso

| Operação | anon | authenticated | admin |
|----------|:----:|:--------------:|:-----:|
| SELECT   | ❌   | próprios perfis | ✅   |
| INSERT   | ❌   | próprios perfis | ✅   |
| UPDATE   | ❌   | próprios perfis | ✅   |
| DELETE   | ❌   | próprios perfis | ✅   |

## Policies

- `usuario gerencia seus perfis`
- `admin gerencia perfis`

Arquivo SQL correspondente: [`supabase/policies/perfil.sql`](../../supabase/policies/perfil.sql)
