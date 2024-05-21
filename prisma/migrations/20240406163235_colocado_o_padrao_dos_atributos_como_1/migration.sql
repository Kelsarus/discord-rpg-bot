/*
  Warnings:

  - You are about to drop the column `userId` on the `stats` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_stats" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "str" INTEGER NOT NULL,
    "dex" INTEGER NOT NULL,
    "sta" INTEGER NOT NULL,
    "vel" INTEGER NOT NULL,
    "int" INTEGER NOT NULL
);
INSERT INTO "new_stats" ("dex", "id", "int", "sta", "str", "vel") SELECT "dex", "id", "int", "sta", "str", "vel" FROM "stats";
DROP TABLE "stats";
ALTER TABLE "new_stats" RENAME TO "stats";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
