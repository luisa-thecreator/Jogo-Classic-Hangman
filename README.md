# 🎮 Jogo da Forca / Jogo Classic Hangman (Processing)

## 📌 Sobre o projeto
Este projeto consiste em uma implementação do clássico **Jogo da Forca**, desenvolvido utilizando a linguagem **Processing (Java)**. O objetivo do jogo é adivinhar uma palavra secreta, tentando letras antes que o número máximo de erros seja atingido.

O projeto foi desenvolvido como atividade acadêmica, com foco em lógica de programação, interação com o usuário e construção de interface gráfica.

---

## 🧠 Como funciona
- O jogo seleciona aleatoriamente uma palavra de uma lista pré-definida.
- O jogador deve clicar nas letras disponíveis na tela.
- A cada erro, uma parte da forca é desenhada.
- O jogador vence ao descobrir todas as letras da palavra.
- O jogador perde ao atingir o número máximo de erros (6).

---

## 🎮 Controles
- 🖱️ **Clique nas letras** para tentar adivinhar a palavra.
- 🔄 **Botão "Novo jogo"** reinicia a partida.

---

## ⚙️ Tecnologias utilizadas
- **Processing (Java)**
- Estruturas de dados como:
  - `HashSet`
  - Arrays
- Interface gráfica com renderização em tempo real

---

## 🧩 Estrutura do código
- `setup()` → inicializa o jogo e configura a tela  
- `draw()` → atualiza a interface continuamente  
- `iniciarNovoJogo()` → reinicia o jogo  
- `calcularLayout()` → define posições dos elementos na tela  

Controle de:
- letras tentadas  
- número de erros  
- estado do jogo  

---

## 📝 Palavras disponíveis
O jogo utiliza um conjunto fixo de palavras em português, como:
- ABACAXI  
- COMPUTADOR  
- GALAXIA  
- UNIVERSO  
- TECNOLOGIA  
*(entre outras)*

---

## 🎯 Objetivos de aprendizagem
- Aplicar lógica condicional e estruturas de repetição  
- Trabalhar com interface gráfica no Processing  
- Manipular eventos de clique  
- Organizar código de forma modular  

---

## 🚀 Como executar
1. Instale o **Processing**  
2. Crie uma pasta com o mesmo nome do arquivo (`Jogo_da_Forca`)  
3. Coloque o arquivo `.pde` dentro da pasta  
4. Abra no Processing  
5. Clique em **Run (▶)**  

---

## 📚 Observações
- O projeto utiliza idioma padrão **pt-BR**  
- Interface simples e intuitiva  
- Código organizado para facilitar manutenção e melhorias  
