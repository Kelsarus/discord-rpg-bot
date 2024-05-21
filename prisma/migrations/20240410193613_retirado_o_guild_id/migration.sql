/*
  Warnings:

  - You are about to drop the column `guildId` on the `race` table. All the data in the column will be lost.
  - You are about to drop the column `guildId` on the `classe` table. All the data in the column will be lost.
  - You are about to drop the column `guildId` on the `stats` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_race" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL DEFAULT 'N/A'
);
INSERT INTO "new_race" ("id", "name") SELECT "id", "name" FROM "race";
DROP TABLE "race";
ALTER TABLE "new_race" RENAME TO "race";
CREATE TABLE "new_classe" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL DEFAULT 'N/A'
);
INSERT INTO "new_classe" ("id", "name") SELECT "id", "name" FROM "classe";
DROP TABLE "classe";
ALTER TABLE "new_classe" RENAME TO "classe";
CREATE TABLE "new_stats" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "str" INTEGER NOT NULL DEFAULT 1,
    "dex" INTEGER NOT NULL DEFAULT 1,
    "sta" INTEGER NOT NULL DEFAULT 1,
    "vel" INTEGER NOT NULL DEFAULT 1,
    "int" INTEGER NOT NULL DEFAULT 1
);
INSERT INTO "new_stats" ("dex", "id", "int", "sta", "str", "vel") SELECT "dex", "id", "int", "sta", "str", "vel" FROM "stats";
DROP TABLE "stats";
ALTER TABLE "new_stats" RENAME TO "stats";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
