resource "vault_mount" "kvv2" {
  path    = "my-kvv2"
  type    = "kv"
  options = { version = "2" }
}

resource "vault_kv_secret_v2" "db_root" {
  mount = vault_mount.kvv2.path
  name  = "pgx-root"
  data_json_wo = jsonencode(
    {
      password = "root-user-password"
    }
  )
  data_json_wo_version = 1
}

ephemeral "vault_kvv2_secret" "db_secret" {
  mount    = vault_mount.kvv2.path
  mount_id = vault_mount.kvv2.id
  name     = vault_kv_secret_v2.db_root.name
}

resource "vault_database_secret_backend_connection" "postgres" {
  backend       = vault_mount.db.path
  name          = "postrgres-db"
  allowed_roles = ["*"]

  postgresql {
    connection_url          = "postgresql://{{username}}:{{password}}@localhost:5432/postgres"
    password_authentication = ""
    username                = "postgres"
    password_wo             = tostring(ephemeral.vault_kvv2_secret.db_secret.data.password)
    password_wo_version     = 1
  }
}