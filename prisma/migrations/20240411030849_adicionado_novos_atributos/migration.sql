/*
  Warnings:

  - You are about to drop the column `sta` on the `stats` table. All the data in the column will be lost.
  - You are about to drop the column `vel` on the `stats` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_stats" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "str" INTEGER NOT NULL DEFAULT 1,
    "dex" INTEGER NOT NULL DEFAULT 1,
    "agi" INTEGER NOT NULL DEFAULT 1,
    "int" INTEGER NOT NULL DEFAULT 1,
    "sab" INTEGER NOT NULL DEFAULT 1,
    "car" INTEGER NOT NULL DEFAULT 1
);
INSERT INTO "new_stats" ("dex", "id", "int", "str") SELECT "dex", "id", "int", "str" FROM "stats";
DROP TABLE "stats";
ALTER TABLE "new_stats" RENAME TO "stats";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
