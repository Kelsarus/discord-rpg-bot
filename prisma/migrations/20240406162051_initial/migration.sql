-- CreateTable
CREATE TABLE "stats" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "str" INTEGER NOT NULL,
    "dex" INTEGER NOT NULL,
    "sta" INTEGER NOT NULL,
    "vel" INTEGER NOT NULL,
    "int" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "stats_userId_key" ON "stats"("userId");
