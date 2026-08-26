-- ============================================================
-- GRANTS PARA ANON (usuário não logado / visitante)
-- Regra: anon só deve enxergar o que é público, tipo uma
-- vitrine do catálogo (navegar filmes/séries antes de logar).
-- Nada de dados pessoais, fatura, perfil, assinatura, etc.
-- ============================================================

GRANT USAGE ON SCHEMA public TO anon;

-- Catálogo público — visitante pode navegar/ver o que existe na plataforma
GRANT SELECT ON TABLE public.obra TO anon;
GRANT SELECT ON TABLE public.genero TO anon;
GRANT SELECT ON TABLE public.obra_genero TO anon;
GRANT SELECT ON TABLE public.profissional TO anon;
GRANT SELECT ON TABLE public.obra_profissional TO anon;
GRANT SELECT ON TABLE public.episodio TO anon;

-- Planos são geralmente públicos também (página de "assine agora")
GRANT SELECT ON TABLE public.plano TO anon;
GRANT SELECT ON TABLE public.qualidade_resolucao TO anon;

-- ------------------------------------------------------------
-- O QUE ANON *NÃO* DEVE TER, e por quê:
-- ------------------------------------------------------------
-- assinante, perfil, dispositivo, visualizacao,
-- historico_assinatura, fatura, status_cobranca,
-- classificacao_maturidade
--
-- São dados de conta/pessoais ou só fazem sentido pra quem já
-- está logado. Não dar GRANT nenhum pra anon nessas tabelas —
-- nem SELECT. Se não tem GRANT, nem precisa de policy: o
-- Postgres já barra o acesso na raiz (fail-safe melhor que
-- depender só de RLS).
-- ============================================================