-- ============================================================
-- RLS: VISUALIZACAO
-- ============================================================
-- Usuário autenticado:
--   SELECT / INSERT / UPDATE apenas das próprias visualizações
--   (via id_assinante). Sem DELETE para o usuário.
--
-- Administrador:
--   Acesso completo (incluindo DELETE).
--
-- Anônimo:
--   Sem acesso.
-- ============================================================


-- ------------------------------------------------------------
-- USUÁRIO
-- ------------------------------------------------------------

CREATE POLICY "usuario le suas visualizacoes"
ON public.visualizacao
FOR SELECT
TO authenticated
USING (
  id_assinante IN (
    SELECT id_assinante FROM public.assinante
    WHERE email = (auth.jwt() ->> 'email')
  )
);

CREATE POLICY "usuario registra suas visualizacoes"
ON public.visualizacao
FOR INSERT
TO authenticated
WITH CHECK (
  id_assinante IN (
    SELECT id_assinante FROM public.assinante
    WHERE email = (auth.jwt() ->> 'email')
  )
);

CREATE POLICY "usuario atualiza suas visualizacoes"
ON public.visualizacao
FOR UPDATE
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

CREATE POLICY "admin gerencia visualizacoes"
ON public.visualizacao
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');
