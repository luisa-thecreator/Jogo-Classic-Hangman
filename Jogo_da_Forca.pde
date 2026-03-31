/**
 * Jogo da Forca — Processing (copie este arquivo para uma pasta de sketch com o mesmo nome).
 * Clique nas letras; botao "Novo jogo" reinicia.
 */
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;

final int MAX_ERROS = 6;
final String[] PALAVRAS = {
  "ABACAXI", "AVENTURA", "BIBLIOTECA", "CACHORRO", "CADEIRA", "CAMINHADA",
  "CHOCOLATE", "COMPUTADOR", "CORAGEM", "DESCOBERTA", "ENIGMA", "ESCOLA",
  "ESTRELA", "FELICIDADE", "FLORESTA", "GALAXIA", "GUITARRA", "HARMONIA",
  "JANELA", "LABORATORIO", "LIVRO", "MONTANHA", "MUSICA", "OCEANO",
  "PALAVRA", "PIRAMIDE", "PLANETA", "PRAIA", "PROGRAMA", "SORRISO",
  "TECNOLOGIA", "TELEFONE", "UNIVERSO", "VIAGEM", "VITORIA"
};

String palavraSecreta;
Set<Character> letrasTentadas = new HashSet<Character>();
int erros;
boolean jogoTerminado;
String statusMsg = "Boa sorte!";
/** 0 = ativa, 1 = acerto (desativada), 2 = erro (desativada) */
int[] teclaEstado = new int[26];

float cardX, cardY, cardW, cardH;
float hangLeft, hangTop, hangW, hangH;
float novoX, novoY, novoW, novoH;
float letCellW, letCellH, letGridLeft, letGridTop;
PFont fontTitulo, fontSub, fontMono, fontUI, fontBotao;

void setup() {
  size(720, 560);
  Locale.setDefault(Locale.forLanguageTag("pt-BR"));
  smooth(8);
  fontTitulo = createFont("Arial Bold", 26);
  fontSub = createFont("Arial", 13);
  fontMono = createFont("Courier New Bold", 28);
  fontUI = createFont("Arial", 15);
  fontBotao = createFont("Arial Bold", 14);
  calcularLayout();
  iniciarNovoJogo();
}

void calcularLayout() {
  cardX = 28;
  cardY = 88;
  cardW = width - 56;
  cardH = height - cardY - 28;
  hangLeft = cardX + 24;
  hangTop = cardY + 22;
  hangW = min(300, cardW * 0.42f);
  hangH = 175;
  letGridLeft = cardX + 24;
  letGridTop = hangTop + hangH + 100;
  letCellW = (cardW - 48 - 12 * 5) / 13f;
  letCellH = 36;
  novoW = 120;
  novoH = 36;
  novoX = cardX + (cardW - novoW) / 2f;
  novoY = height - 28 - novoH;
}

void draw() {
  desenharGradiente();
  textAlign(CENTER, CENTER);

  fill(255, 252, 248);
  textFont(fontTitulo);
  text("Jogo da Forca", width / 2f, 36);

  fill(255, 230, 210);
  textFont(fontSub);
  text("Clique nas letras para descobrir a palavra secreta", width / 2f, 62);

  desenharCartao();
  desenharForca(hangLeft, hangTop, hangW, hangH, erros);
  desenharPalavra();
  desenharStatusETentativas();
  desenharTeclado();
  desenharBotaoNovoJogo();
}

void desenharGradiente() {
  color c0 = color(45, 32, 72);
  color c1 = color(120, 55, 95);
  for (int y = 0; y < height; y++) {
    float t = y / (float) height;
    stroke(lerpColor(c0, c1, t));
    line(0, y, width, y);
  }
}

void desenharCartao() {
  pushStyle();
  rectMode(CORNER);
  fill(255, 255, 255, 236);
  stroke(255, 255, 255, 120);
  strokeWeight(1.2f);
  rect(cardX, cardY, cardW, cardH, 22);
  popStyle();
}

void desenharPalavra() {
  textFont(fontMono);
  textAlign(CENTER, CENTER);
  float y = hangTop + hangH + 22;
  StringBuilder sb = new StringBuilder();
  for (int i = 0; i < palavraSecreta.length(); i++) {
    char ch = palavraSecreta.charAt(i);
    if (letrasTentadas.contains(ch)) {
      sb.append(ch);
    } else {
      sb.append("_");
    }
    if (i < palavraSecreta.length() - 1) {
      sb.append(" ");
    }
  }
  fill(35, 40, 55);
  text(sb.toString(), cardX + cardW / 2f, y);
}

void desenharStatusETentativas() {
  float y1 = hangTop + hangH + 54;
  float y2 = y1 + 22;
  textFont(fontUI);
  fill(70, 75, 95);
  textAlign(CENTER, CENTER);
  text(statusMsg, cardX + cardW / 2f, y1);

  textFont(fontBotao);
  fill(180, 85, 65);
  text("Erros: " + erros + " / " + MAX_ERROS, cardX + cardW / 2f, y2);
}

void desenharTeclado() {
  textFont(fontBotao);
  for (int i = 0; i < 26; i++) {
    int row = i / 13;
    int col = i % 13;
    float x = letGridLeft + col * (letCellW + 6);
    float y = letGridTop + row * (letCellH + 8);

    if (teclaEstado[i] == 1) {
      fill(200, 235, 210);
      stroke(140, 200, 155);
    } else if (teclaEstado[i] == 2) {
      fill(245, 210, 210);
      stroke(220, 160, 160);
    } else {
      fill(245, 247, 252);
      stroke(200, 210, 230);
    }
    strokeWeight(1);
    rect(x, y, letCellW, letCellH, 6);

    if (teclaEstado[i] == 1) {
      fill(30, 90, 50);
    } else if (teclaEstado[i] == 2) {
      fill(130, 45, 45);
    } else {
      fill(45, 50, 70);
    }
    text(String.valueOf((char) ('A' + i)), x + letCellW / 2f, y + letCellH / 2f);
  }
}

void desenharBotaoNovoJogo() {
  textFont(fontUI);
  boolean hover = mouseX >= novoX && mouseX <= novoX + novoW && mouseY >= novoY && mouseY <= novoY + novoH;
  fill(hover ? color(140, 90, 160) : color(120, 70, 140));
  noStroke();
  text("Novo jogo", novoX + novoW / 2f, novoY + novoH / 2f);
}

void desenharForca(float left, float top, float w, float h, int errosForca) {
  pushMatrix();
  translate(left, top);
  int e = constrain(errosForca, 0, MAX_ERROS);

  color poste = color(55, 48, 75);
  color corda = color(90, 75, 95);
  color boneco = color(40, 42, 58);

  float pad = 24f;
  float baseY = h - pad;
  float baseX = w * 0.28f;

  strokeCap(ROUND);
  strokeJoin(ROUND);
  strokeWeight(5);
  stroke(poste);
  line(baseX - 50, baseY, baseX + 50, baseY);
  line(baseX, baseY - 8, baseX, pad + 40);
  line(baseX, pad + 40, baseX + 110, pad + 40);

  strokeWeight(3);
  stroke(corda);
  float cx = baseX + 110;
  float ropeTop = pad + 40;
  float ropeLen = 28;
  line(cx, ropeTop, cx, ropeTop + ropeLen);

  float headR = 22;
  float headCy = ropeTop + ropeLen + headR;

  strokeWeight(4);
  stroke(boneco);
  if (e >= 1) {
    noFill();
    ellipse(cx, headCy, 2 * headR, 2 * headR);
  }
  float bodyTop = headCy + headR - 4;
  float bodyBot = bodyTop + 70;
  if (e >= 2) {
    line(cx, bodyTop, cx, bodyBot);
  }
  if (e >= 3) {
    line(cx, bodyTop + 18, cx - 48, bodyTop + 55);
  }
  if (e >= 4) {
    line(cx, bodyTop + 18, cx + 48, bodyTop + 55);
  }
  if (e >= 5) {
    line(cx, bodyBot, cx - 40, bodyBot + 55);
  }
  if (e >= 6) {
    line(cx, bodyBot, cx + 40, bodyBot + 55);
  }
  popMatrix();
}

void mousePressed() {
  if (mouseNoRetangulo(novoX, novoY, novoW, novoH)) {
    iniciarNovoJogo();
    return;
  }
  if (jogoTerminado) {
    return;
  }
  for (int i = 0; i < 26; i++) {
    if (teclaEstado[i] != 0) {
      continue;
    }
    int row = i / 13;
    int col = i % 13;
    float x = letGridLeft + col * (letCellW + 6);
    float y = letGridTop + row * (letCellH + 8);
    if (mouseNoRetangulo(x, y, letCellW, letCellH)) {
      onLetra((char) ('A' + i));
      break;
    }
  }
}

boolean mouseNoRetangulo(float x, float y, float rw, float rh) {
  return mouseX >= x && mouseX <= x + rw && mouseY >= y && mouseY <= y + rh;
}

void iniciarNovoJogo() {
  palavraSecreta = PALAVRAS[(int) random(PALAVRAS.length)];
  letrasTentadas.clear();
  erros = 0;
  jogoTerminado = false;
  statusMsg = "Boa sorte!";
  for (int i = 0; i < 26; i++) {
    teclaEstado[i] = 0;
  }
}

void onLetra(char letra) {
  if (jogoTerminado) {
    return;
  }
  char u = Character.toUpperCase(letra);
  if (letrasTentadas.contains(u)) {
    return;
  }
  letrasTentadas.add(u);
  int idx = u - 'A';
  if (idx < 0 || idx > 25) {
    return;
  }

  boolean acertou = palavraSecreta.indexOf(u) >= 0;
  if (acertou) {
    teclaEstado[idx] = 1;
    statusMsg = "Letra certa!";
  } else {
    erros++;
    teclaEstado[idx] = 2;
    statusMsg = "Essa letra nao esta na palavra.";
  }
  verificarFimDeJogo();
}

void verificarFimDeJogo() {
  boolean ganhou = true;
  for (int i = 0; i < palavraSecreta.length(); i++) {
    if (!letrasTentadas.contains(palavraSecreta.charAt(i))) {
      ganhou = false;
      break;
    }
  }
  if (ganhou) {
    jogoTerminado = true;
    statusMsg = "Voce venceu! Parabens! A palavra era " + palavraSecreta + ".";
    return;
  }
  if (erros >= MAX_ERROS) {
    jogoTerminado = true;
    revelarLetrasRestantes();
    statusMsg = "Fim de jogo! A palavra era " + palavraSecreta + ".";
  }
}

void revelarLetrasRestantes() {
  for (int i = 0; i < palavraSecreta.length(); i++) {
    letrasTentadas.add(palavraSecreta.charAt(i));
  }
}

void windowResized() {
  calcularLayout();
}
