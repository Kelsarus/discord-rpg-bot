const { SlashCommandBuilder } = require('discord.js');
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

module.exports = {
    data: new SlashCommandBuilder()
        .setName('status')
        .setDescription('Exibe seu status.')
        .addUserOption(option => option.setName('user').setDescription('Usuário').setRequired(false)),
    async execute(interaction) {
        try {
            let user = interaction.options.getUser('user');
            if (!user) {
                user = interaction.user
            }
            // Convertendo o ID do usuário para um número inteiro
            const userId = parseInt(user.id);

            // Buscar os atributos do personagem do usuário no banco de dados
            let stats = await prisma.stats.findUnique({
                where: {
                    id: userId
                }
            });
            let race = await prisma.race.findUnique({
                where: {
                    id: userId
                }
            })
            let classe = await prisma.classe.findUnique({
                where: {
                    id: userId
                }
            })

            // Se não houver um registro para o usuário, criar um novo
            if (!stats) {
                stats = await prisma.stats.create({
                    data: {
                        id: userId,
                        str: 1,
                        dex: 1,
                        agi: 1,
                        int: 1,
                        sab: 1,
                        car: 1
                    }
                });
            }
            if (!race) {
                race = await prisma.race.create({
                    data: {
                        id: userId
                    }
                })
            }
            if (!classe) {
                classe = await prisma.classe.create({
                    data: {
                        id: userId
                    }
                })
            }

            // Exibir os atributos do personagem
            await interaction.reply(`⩩ ──・──・・✧ ・・──・── ⩩
        FICHA DE PERSONAGEM
⩩ ──・──・・✧ ・・──・── ⩩
Nome: ${user.tag}
Raça: ${race.name}
Classe: ${classe.name}
⩩ ──・──・・✧ ・・──・── ⩩
FOR: ${stats.str}
CON: ${stats.dex}
AGI: ${stats.agi}
INT: ${stats.int}
SAB: ${stats.sab}
CAR: ${stats.car}
⩩ ──・──・・✧ ・・──・── ⩩`);
        } catch (error) {
            console.error('Erro ao buscar o status do personagem:', error);
            await interaction.reply('Ocorreu um erro ao buscar o seu status.');
        } finally {
            await prisma.$disconnect();
        }
    },
};