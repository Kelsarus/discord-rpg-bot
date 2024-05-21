-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_classe" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL DEFAULT 'N/A'
);
INSERT INTO "new_classe" ("id", "name") SELECT "id", "name" FROM "classe";
DROP TABLE "classe";
ALTER TABLE "new_classe" RENAME TO "classe";
CREATE TABLE "new_race" (
    "id" BIGINT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL DEFAULT 'N/A'
);
INSERT INTO "new_race" ("id", "name") SELECT "id", "name" FROM "race";
DROP TABLE "race";
ALTER TABLE "new_race" RENAME TO "race";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
