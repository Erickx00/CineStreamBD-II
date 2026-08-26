-- ============================================================
-- RLS: CATÁLOGO PÚBLICO
-- ============================================================
-- Tabelas: plano, qualidade_resolucao, classificacao_maturidade,
--          status_cobranca (exceção: sem acesso anon),
--          obra, genero, profissional, obra_genero,
--          obra_profissional, episodio
--
-- Anônimo e autenticado:
--   SELECT livre (exceto status_cobranca, só authenticated).
--
-- Administrador:
--   Acesso completo.
-- ============================================================


-- ------------------------------------------------------------
-- PLANO
-- ------------------------------------------------------------

CREATE POLICY "todos leem planos"
ON public.plano
FOR SELECT
TO authenticated, anon
USING (true);

CREATE POLICY "admin gerencia planos"
ON public.plano
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');


-- ------------------------------------------------------------
-- QUALIDADE_RESOLUCAO
-- ------------------------------------------------------------

CREATE POLICY "todos leem qualidade"
ON public.qualidade_resolucao
FOR SELECT
TO authenticated, anon
USING (true);

CREATE POLICY "admin gerencia qualidade"
ON public.qualidade_resolucao
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');


-- ------------------------------------------------------------
-- CLASSIFICACAO_MATURIDADE
-- ------------------------------------------------------------

CREATE POLICY "todos leem classificacao"
ON public.classificacao_maturidade
FOR SELECT
TO authenticated, anon
USING (true);

CREATE POLICY "admin gerencia classificacao"
ON public.classificacao_maturidade
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');


-- ------------------------------------------------------------
-- STATUS_COBRANCA (exceção: sem acesso anon)
-- ------------------------------------------------------------

CREATE POLICY "authenticated le status_cobranca"
ON public.status_cobranca
FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "admin gerencia status_cobranca"
ON public.status_cobranca
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');


-- ------------------------------------------------------------
-- OBRA
-- ------------------------------------------------------------

CREATE POLICY "todos leem obras"
ON public.obra
FOR SELECT
TO authenticated, anon
USING (true);

CREATE POLICY "admin gerencia obras"
ON public.obra
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');


-- ------------------------------------------------------------
-- GENERO
-- ------------------------------------------------------------

CREATE POLICY "todos leem generos"
ON public.genero
FOR SELECT
TO authenticated, anon
USING (true);

CREATE POLICY "admin gerencia generos"
ON public.genero
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');


-- ------------------------------------------------------------
-- PROFISSIONAL
-- ------------------------------------------------------------

CREATE POLICY "todos leem profissionais"
ON public.profissional
FOR SELECT
TO authenticated, anon
USING (true);

CREATE POLICY "admin gerencia profissionais"
ON public.profissional
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');


-- ------------------------------------------------------------
-- OBRA_GENERO
-- ------------------------------------------------------------

CREATE POLICY "todos leem obra_genero"
ON public.obra_genero
FOR SELECT
TO authenticated, anon
USING (true);

CREATE POLICY "admin gerencia obra_genero"
ON public.obra_genero
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');


-- ------------------------------------------------------------
-- OBRA_PROFISSIONAL
-- ------------------------------------------------------------

CREATE POLICY "todos leem obra_profissional"
ON public.obra_profissional
FOR SELECT
TO authenticated, anon
USING (true);

CREATE POLICY "admin gerencia obra_profissional"
ON public.obra_profissional
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');


-- ------------------------------------------------------------
-- EPISODIO
-- ------------------------------------------------------------

CREATE POLICY "todos leem episodios"
ON public.episodio
FOR SELECT
TO authenticated, anon
USING (true);

CREATE POLICY "admin gerencia episodios"
ON public.episodio
FOR ALL
TO authenticated
USING (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin')
WITH CHECK (((auth.jwt() -> 'app_metadata') ->> 'role') = 'admin');
