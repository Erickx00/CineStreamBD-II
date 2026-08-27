-- ============================================================
-- Função: handle_new_user_role
-- Objetivo:
-- Define automaticamente a role "user" para novos usuários
-- criados no Supabase Auth.
-- ============================================================

CREATE OR REPLACE FUNCTION public.handle_new_user_role()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = ''
AS $$
BEGIN
    UPDATE auth.users
    SET raw_app_meta_data =
        COALESCE(raw_app_meta_data, '{}'::jsonb)
        || '{"role": "user"}'::jsonb
    WHERE id = NEW.id;

    RETURN NEW;
END;
$$;

-- ============================================================
-- Trigger: on_auth_user_created_role
-- Objetivo:
-- Executar automaticamente a função acima sempre que um
-- novo usuário for criado no Supabase Auth.
-- ============================================================

CREATE OR REPLACE TRIGGER on_auth_user_created_role
AFTER INSERT ON auth.users
FOR EACH ROW
EXECUTE FUNCTION public.handle_new_user_role();