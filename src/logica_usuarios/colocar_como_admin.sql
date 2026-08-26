-- Define o papel (role) do usuário como "admin"
-- COALESCE garante que raw_app_meta_data seja um JSON válido
-- O operador || adiciona/atualiza a propriedade "role"
-- O WHERE garante que apenas o usuário com este e-mail seja alterado

UPDATE auth.users 
SET raw_app_meta_data =
    COALESCE(raw_app_meta_data, '{}'::jsonb)
    || '{"role": "admin"}'::jsonb 
WHERE email = 'admin@admin.com';