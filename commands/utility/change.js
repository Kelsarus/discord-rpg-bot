const { SlashCommandBuilder } = require('discord.js');
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

module.exports = {
    data: new SlashCommandBuilder()
        .setName('change')
        .setDescription('Altera os atributos do personagem de um usuário.')
        .addUserOption(option => option.setName('user').setDescription('Usuário').setRequired(true))
        .addStringOption(option => option.setName('atributo').setDescription('Atributo').setRequired(true))
        .addIntegerOption(option => option.setName('quantidade').setDescription('Quantidade').setRequired(true)),
    async execute(interaction) {
        // Verifica se o usuário tem permissão de administrador
        if (!interaction.member.permissions.has('8')) {
            return await interaction.reply('Você não tem permissão para usar este comando.');
        }

        // Obtém o usuário mencionado na interação
        const user = interaction.options.getUser('user');
        if (!user) {
            return await interaction.reply('Por favor, mencione o usuário para o qual deseja alterar os atributos.');
        }

        // Obtém o nome do atributo e a quantidade fornecidos pelo usuário
        const atributo = interaction.options.getString('atributo').toLowerCase();
        const quantidade = interaction.options.getInteger('quantidade');

        // Verifica se o atributo fornecido é válido
        const atributosValidos = ['str', 'dex', 'agi', 'int', 'sab', 'car'];
        if (!atributosValidos.includes(atributo)) {
            return await interaction.reply('Atributo inválido. Os atributos válidos são: str, dex, agi, int, sab, car.');
        }

        // Cria uma nova instância de PrismaClient

        try {
            // Convertendo o ID do usuário mencionado para um número inteiro
            const userId = parseInt(user.id);

            // Atualiza o atributo do personagem no banco de dados
            await prisma.stats.update({
                where: { id: userId },
                data: {
                    [atributo]: quantidade
                }
            });

            await interaction.reply(`Atributo ${atributo} alterado para ${quantidade} com sucesso para o usuário ${user.tag}!`);
        } catch (error) {
            console.error('Erro ao alterar os atributos do personagem:', error);
            await interaction.reply('Ocorreu um erro ao alterar os atributos do personagem.');
        } finally {
            // Desconecta o PrismaClient após a conclusão da execução
            await prisma.$disconnect();
        }
    },
};