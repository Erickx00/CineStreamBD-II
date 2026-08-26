# Política RLS — Dispositivo

## Objetivo

O usuário gerencia livremente (ALL) os dispositivos vinculados à sua própria
assinatura. Administradores têm acesso completo. Anônimos não têm acesso.

## Regras

### Usuário autenticado
- Pode fazer SELECT, INSERT, UPDATE e DELETE nos próprios dispositivos.

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

| Operação | anon | authenticated     | admin |
|----------|:----:|:------------------:|:-----:|
| SELECT   | ❌   | próprios dispositivos | ✅ |
| INSERT   | ❌   | próprios dispositivos | ✅ |
| UPDATE   | ❌   | próprios dispositivos | ✅ |
| DELETE   | ❌   | próprios dispositivos | ✅ |

## Policies

- `usuario gerencia seus dispositivos`
- `admin gerencia dispositivos`

Arquivo SQL correspondente: [`supabase/policies/dispositivo.sql`](../../supabase/policies/dispositivo.sql)
