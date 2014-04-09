CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_name" varchar(255) NOT NULL, "pwd" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime, "user_type" varchar(255), "email" varchar(255));
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20140408002306');

INSERT INTO schema_migrations (version) VALUES ('20140408031125');

INSERT INTO schema_migrations (version) VALUES ('20140408032743');
