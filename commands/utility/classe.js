const { SlashCommandBuilder } = require('discord.js');
const { PrismaClient } = require('@prisma/client');

module.exports = {
    data: new SlashCommandBuilder()
        .setName('classe')
        .setDescription('Define a classe de um usuário.')
        .addStringOption(option => option.setName('classe').setDescription('Classe').setRequired(true))
        .addUserOption(option => option.setName('user').setDescription('Usuário').setRequired(false)),
    async execute(interaction) {
        // Verifica se o usuário tem permissão de administrador
        if (!interaction.member.permissions.has('8')) {
            return await interaction.reply('Você não tem permissão para usar este comando.');
        }

        // Obtém o usuário mencionado na interação
        let user = interaction.options.getUser('user');
        if (!user) {
            user = interaction.user
        }

        // Obtém a raça e a classe fornecidas pelo usuário
        const classe = interaction.options.getString('classe');

        // Cria uma nova instância de PrismaClient
        const prisma = new PrismaClient();

        try {
            // Convertendo o ID do usuário mencionado para um número inteiro
            const userId = parseInt(user.id);

            // Atualiza a raça e a classe do personagem no banco de dados
            await prisma.classe.update({
                where: { id: userId },
                data: {
                    name: { set: classe }
                }
            });

            await interaction.reply(`Classe definida com sucesso para o usuário ${user.tag}: ${classe}!`);
        } catch (error) {
            console.error('Erro ao definir a classe do personagem:', error);
            await interaction.reply('Ocorreu um erro ao definir a classe do personagem.');
        } finally {
            // Desconecta o PrismaClient após a conclusão da execução
            await prisma.$disconnect();
        }
    },
};