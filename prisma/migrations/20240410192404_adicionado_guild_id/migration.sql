-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_race" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "guildId" BIGINT NOT NULL DEFAULT 0,
    "name" TEXT NOT NULL DEFAULT 'N/A'
);
INSERT INTO "new_race" ("id", "name") SELECT "id", "name" FROM "race";
DROP TABLE "race";
ALTER TABLE "new_race" RENAME TO "race";
CREATE TABLE "new_stats" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "guildId" BIGINT NOT NULL DEFAULT 0,
    "str" INTEGER NOT NULL DEFAULT 1,
    "dex" INTEGER NOT NULL DEFAULT 1,
    "sta" INTEGER NOT NULL DEFAULT 1,
    "vel" INTEGER NOT NULL DEFAULT 1,
    "int" INTEGER NOT NULL DEFAULT 1
);
INSERT INTO "new_stats" ("dex", "id", "int", "sta", "str", "vel") SELECT "dex", "id", "int", "sta", "str", "vel" FROM "stats";
DROP TABLE "stats";
ALTER TABLE "new_stats" RENAME TO "stats";
CREATE TABLE "new_classe" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "guildId" BIGINT NOT NULL DEFAULT 0,
    "name" TEXT NOT NULL DEFAULT 'N/A'
);
INSERT INTO "new_classe" ("id", "name") SELECT "id", "name" FROM "classe";
DROP TABLE "classe";
ALTER TABLE "new_classe" RENAME TO "classe";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
