-- ============================================================
-- RLS: ASSINANTE
-- ============================================================
-- Usuário autenticado:
--   SELECT e UPDATE apenas do próprio registro.
--
-- Administrador:
--   Acesso completo.
--
-- Anônimo:
--   Sem acesso (nenhuma policy = nenhum acesso).
-- ============================================================


-- ------------------------------------------------------------
-- USUÁRIO
-- ------------------------------------------------------------

CREATE POLICY "assinante lê apenas seu registro"
ON public.assinante
FOR SELECT
TO authenticated
USING (
  email = (auth.jwt() ->> 'email')
);

CREATE POLICY "assinante atualiza apenas seu registro"
ON public.assinante
FOR UPDATE
TO authenticated
USING (
  email = (auth.jwt() ->> 'email')
)
WITH CHECK (
  email = (auth.jwt() ->> 'email')
);


-- ------------------------------------------------------------
-- ADMIN
-- ------------------------------------------------------------

CREATE POLICY "admin gerencia assinantes"
ON public.assinante
FOR ALL
TO authenticated
USING (
  ((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin'
)
WITH CHECK (
  ((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin'
);
