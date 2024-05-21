/*
  Warnings:

  - The primary key for the `stats` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `stats` table. The data in that column could be lost. The data in that column will be cast from `Int` to `BigInt`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
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
