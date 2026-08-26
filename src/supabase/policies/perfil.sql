-- ============================================================
-- RLS: PERFIL
-- ============================================================
-- Usuário autenticado:
--   ALL (SELECT/INSERT/UPDATE/DELETE) apenas dos próprios
--   perfis (via id_assinante).
--
-- Administrador:
--   Acesso completo.
--
-- Anônimo:
--   Sem acesso.
-- ============================================================


-- ------------------------------------------------------------
-- USUÁRIO
-- ------------------------------------------------------------

CREATE POLICY "usuario gerencia seus perfis"
ON public.perfil
FOR ALL
TO authenticated
USING (
  id_assinante IN (
    SELECT id_assinante FROM public.assinante
    WHERE email = (auth.jwt() ->> 'email')
  )
)
WITH CHECK (
  id_assinante IN (
    SELECT id_assinante FROM public.assinante
    WHERE email = (auth.jwt() ->> 'email')
  )
);


-- ------------------------------------------------------------
-- ADMIN
-- ------------------------------------------------------------

CREATE POLICY "admin gerencia perfis"
ON public.perfil
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');
