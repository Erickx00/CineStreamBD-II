-- ============================================================
-- RLS: ASSINATURA (HISTÓRICO E FATURAS)
-- ============================================================
-- Usuário autenticado:
--   SELECT apenas dos próprios registros (via id_assinante).
--
-- Administrador:
--   Acesso completo.
--
-- Anônimo:
--   Sem acesso.
-- ============================================================


-- ------------------------------------------------------------
-- HISTORICO_ASSINATURA
-- ------------------------------------------------------------

CREATE POLICY "usuario le seu historico de assinatura"
ON public.historico_assinatura
FOR SELECT
TO authenticated
USING (
  id_assinante IN (
    SELECT id_assinante FROM public.assinante
    WHERE email = (auth.jwt() ->> 'email')
  )
);

CREATE POLICY "admin gerencia historico_assinatura"
ON public.historico_assinatura
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');


-- ------------------------------------------------------------
-- FATURA
-- ------------------------------------------------------------

CREATE POLICY "usuario le suas faturas"
ON public.fatura
FOR SELECT
TO authenticated
USING (
  id_assinante IN (
    SELECT id_assinante FROM public.assinante
    WHERE email = (auth.jwt() ->> 'email')
  )
);

CREATE POLICY "admin gerencia faturas"
ON public.fatura
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');
