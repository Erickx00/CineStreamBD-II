
-- GRANTS — Netflix-like DB (Supabase)
-- Regra geral: GRANT libera o comando no nível do Postgres;
-- quem realmente filtra LINHA a linha são as POLICIES (RLS).
-- Não existe um role Postgres "admin" separado aqui — o admin
-- é identificado via auth.jwt() app_metadata->>'role' = 'admin'
-- dentro das próprias policies. Por isso o GRANT é sempre para
-- "authenticated", e quem bloqueia/libera é a policy.


-- Uso do schema (obrigatório para tudo funcionar)
GRANT USAGE ON SCHEMA public TO authenticated;

-- Sequences (IDENTITY usa sequence interna; sem isso INSERT falha)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO authenticated;

-- ------------------------------------------------------------
-- TABELAS DE CATÁLOGO (somente leitura para usuário comum;
-- escrita só passa se a policy permitir, ex: role admin)
-- ------------------------------------------------------------

-- qualidade_resolucao: usuário só lê (ex: listar planos)
GRANT SELECT ON TABLE public.qualidade_resolucao TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.qualidade_resolucao TO authenticated; -- bloqueado por policy admin

-- plano: usuário lê os planos disponíveis; admin gerencia
GRANT SELECT ON TABLE public.plano TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.plano TO authenticated;

-- status_cobranca: só leitura pro usuário; admin gerencia
GRANT SELECT ON TABLE public.status_cobranca TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.status_cobranca TO authenticated;

-- classificacao_maturidade: leitura livre (usada em perfil)
GRANT SELECT ON TABLE public.classificacao_maturidade TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.classificacao_maturidade TO authenticated;

-- obra, genero, profissional, episodio, obra_genero, obra_profissional:
-- catálogo do catálogo de conteúdo — usuário só lê/navega o catálogo
GRANT SELECT ON TABLE public.obra TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.obra TO authenticated;

GRANT SELECT ON TABLE public.genero TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.genero TO authenticated;

GRANT SELECT ON TABLE public.profissional TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.profissional TO authenticated;

GRANT SELECT ON TABLE public.episodio TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.episodio TO authenticated;

GRANT SELECT ON TABLE public.obra_genero TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.obra_genero TO authenticated;

GRANT SELECT ON TABLE public.obra_profissional TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.obra_profissional TO authenticated;

-- ------------------------------------------------------------
-- DADOS DO PRÓPRIO USUÁRIO (policy restringe pelo dono/email)
-- ------------------------------------------------------------

-- assinante: usuário lê/atualiza só o próprio registro (policy compara email)
GRANT SELECT, UPDATE ON TABLE public.assinante TO authenticated;
GRANT INSERT, DELETE ON TABLE public.assinante TO authenticated; -- normalmente via trigger/signup ou admin

-- perfil: usuário gerencia os próprios perfis (CRUD completo, restrito por policy dono)
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.perfil TO authenticated;

-- dispositivo: usuário registra/remove seus próprios dispositivos
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE public.dispositivo TO authenticated;

-- visualizacao: usuário registra e lê seu próprio histórico de visualização
GRANT SELECT, INSERT, UPDATE ON TABLE public.visualizacao TO authenticated;
GRANT DELETE ON TABLE public.visualizacao TO authenticated; -- geralmente bloqueado por policy (histórico não se apaga)

-- historico_assinatura: usuário só lê o próprio histórico; admin/backend grava
GRANT SELECT ON TABLE public.historico_assinatura TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.historico_assinatura TO authenticated;

-- fatura: usuário só lê suas próprias faturas; admin gerencia tudo (conforme sua policy)
GRANT SELECT ON TABLE public.fatura TO authenticated;
GRANT INSERT, UPDATE, DELETE ON TABLE public.fatura TO authenticated;
