# Política RLS — Visualização

## Objetivo

O usuário registra e consulta apenas o próprio histórico de visualizações.
Não há DELETE liberado para o usuário (nem para si mesmo). Administradores
têm acesso completo. Anônimos não têm acesso.

## Regras

### Usuário autenticado
- Pode ler (SELECT) as próprias visualizações.
- Pode registrar (INSERT) novas visualizações.
- Pode atualizar (UPDATE) as próprias visualizações (ex: progresso assistido).
- **Não** pode deletar (nenhuma policy de DELETE para o usuário).

Vinculação via `id_assinante`:
```sql
id_assinante IN (
  SELECT id_assinante FROM public.assinante
  WHERE email = (auth.jwt() ->> 'email')
)
```

### Administrador
- Acesso completo (ALL), incluindo DELETE.

### Usuário anônimo
- Sem acesso.

## Matriz de acesso

| Operação | anon | authenticated        | admin |
|----------|:----:|:---------------------:|:-----:|
| SELECT   | ❌   | próprias visualizações | ✅   |
| INSERT   | ❌   | próprias visualizações | ✅   |
| UPDATE   | ❌   | próprias visualizações | ✅   |
| DELETE   | ❌   | ❌                      | ✅   |

## Policies

- `usuario le suas visualizacoes`
- `usuario registra suas visualizacoes`
- `usuario atualiza suas visualizacoes`
- `admin gerencia visualizacoes`

Arquivo SQL correspondente: [`supabase/policies/visualizacao.sql`](../../supabase/policies/visualizacao.sql)
