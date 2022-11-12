# Cria grupo de administradores
INSERT INTO auth_group (name) VALUES('admin');

# Insere todas permissões para o grupo de administradores
INSERT INTO auth_group_permissions (group_id, permission_id)
SELECT auth_group.id, auth_permission.id FROM auth_group, auth_permission;

# Insere todos usuários no grupo de administradores
INSERT INTO auth_user_groups (user_id, group_id)
SELECT auth_user.id, auth_group.id FROM auth_user, auth_group;
