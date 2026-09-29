#set text(lang: "ru")

// ---------- Settings ----------
#let university = [Санкт-Петербургский государственный электротехнический \
                   университет «ЛЭТИ» им. В.И. Ульянова (Ленина)]
#let lab-number = "1"        // e.g. "3"; none -> blank line to fill in
#let topic      = "Классические шифры"
#let student    = "Иванов Артём"
#let group      = "3381"
#let supervisor = "Племянников А.К., доцент каф. ИБ"
#let city-year  = "Санкт-Петербург " + str(datetime.today().year())
#let author     = student     // shown in the footer
#let title      = topic       // shown in the footer


#let main-color = rgb("#2b4c7e")   // Beamer "default blue"-ish
#let light-color = main-color.lighten(85%)

// ---------- Page & text ----------
#set page(
  paper: "presentation-16-9",
  margin: (x: 1.5cm, top: 0cm, bottom: 1.3cm),
  // Footer: author | title | slide counter (full-width Beamer-style bar)
  footer-descent: 0.5cm,
  footer: context {
    let current = counter(page).get().first()
    let total   = counter(page).final().first()
    set text(size: 12pt, fill: white)
    pad(x: -1.5cm, grid(
      columns: (1fr, 1fr, 1fr),
      block(fill: main-color, width: 100%, height: 0.8cm, inset: (x: 8pt),
        align(center + horizon, author)),
      block(fill: main-color.lighten(20%), width: 100%, height: 0.8cm, inset: (x: 8pt),
        align(center + horizon, title)),
      block(fill: main-color.darken(25%), width: 100%, height: 0.8cm, inset: (x: 12pt),
        align(right + horizon, text(weight: "bold", size: 14pt)[#current / #total])),
    ))
  },
)

#set text(font: "New Computer Modern", size: 18pt)   // LaTeX look
#show math.equation: set text(font: "New Computer Modern Math")
#set par(justify: false, leading: 0.7em)
#set list(marker: text(fill: main-color, sym.triangle.filled.r))
#set enum(numbering: n => text(fill: main-color, weight: "bold", str(n) + "."))

// Each "== Title" starts a new slide with a colored title bar (like \frametitle)
#show heading.where(level: 2): it => {
  pagebreak(weak: true)
  pad(x: -1.5cm, block(
    width: 100%, fill: main-color, inset: (x: 1.5cm, y: 0.5cm),
    text(fill: white, size: 22pt, weight: "bold", it.body),
  ))
  v(0.6cm)
}

// Beamer-style "block" environment
#let bblock(title: none, body) = block(
  width: 100%, radius: 4pt, clip: true, stroke: 0.5pt + main-color,
  stack(
    block(fill: main-color, width: 100%, inset: 8pt,
      text(fill: white, weight: "bold", title)),
    block(fill: light-color, width: 100%, inset: 10pt, body),
  ),
)

#let bblock-title(body) = align(center, block(
  width: 85%, fill: light-color, radius: 5pt, inset: 14pt,
  stroke: 0.8pt + main-color,
  text(size: 28pt, weight: "bold", fill: main-color, body),
))

// ---------- Title slide (LETI layout, Beamer style) ----------
// A blank line for signatures / numbers: text over it if given, else empty
#let blank(width, body: none) = box(
  width: width, stroke: (bottom: 0.8pt + black), outset: (bottom: 2pt),
  align(center, if body == none { h(0pt) } else { body }),
)

#[
  #set par(leading: 0.5em)
  #v(0.8cm)
  #align(center, text(size: 17pt, university))

  #v(1fr)
  #align(center)[Лабораторная № #blank(1.8cm, body: lab-number)]
  #v(0.2em)
  #bblock-title(topic)
  #v(1fr)

  #pad(left: 3.5cm)[
    Студент: #blank(5.5cm) #text(fill: main-color, weight: "bold", student),
    группа #text(fill: main-color, weight: "bold", group)
    #v(0.6em)
    Руководитель: #blank(4.5cm) #supervisor
  ]
  #v(0.6em)
  #align(center, text(size: 14pt, city-year))
  #v(0.2cm)
]

// ============================================================
//  Slides: every "== Title" starts a new slide
// ============================================================

== Цели и задачи
+ Повышение компетентности в области классических шифров перестановки и замены, рассмотрение маршрутного шифра "Изгородь".
+ Задачи:
  + Изучить шифр "Scytale".
  + Изучить "Агентурный шифр".
  + Изучить шифр "Vigenеre".
  + Изучить шифр "Hill".
  + Изучить шифр "ADFGVX".
  + Изучить шифр "Изгородь"

== Шифр "Scytale"
#grid(
  columns: (1fr, 1fr),   // two equal columns
  gutter: 1cm,           // space between the images
  figure(
    image("images/scytale_cryptool.png", height: 6cm),
    caption: [Scytale в CrypTool2],
  ),
  figure(
    image("images/scytale.drawio.png", height: 11cm),
    caption: [Блок-схема Scytale],
  ),
)

== Шифр "Агентурный шифр"
#grid(
  columns: (1fr, 1fr),   // two equal columns
  gutter: 1cm,           // space between the images
  figure(
    image("images/agent_cryptool.png", height: 7cm),
    caption: [Агентурный шифр в CrypTool2],
  ),
  figure(
    image("images/agent.drawio.png", height: 11cm),
    caption: [Блок-схема Агентурного шифра],
  ),
)

== Шифр "Vigenere"
#grid(
  columns: (1fr, 1fr),   // two equal columns
  gutter: 1cm,           // space between the images
  figure(
    image("images/vigenere_cryptool.png", height: 5.5cm),
    caption: [Vigenere в CrypTool2],
  ),
  figure(
    image("images/vigenere.drawio.png", height: 11cm),
    caption: [Блок-схема Vigenere],
  ),
)

== Шифр "Hill"
#grid(
  columns: (1fr, 1fr),   // two equal columns
  gutter: 1cm,           // space between the images
  figure(
    image("images/hill_cryptool.png", height: 5cm),
    caption: [Hill в CrypTool2],
  ),
  figure(
    image("images/hill.drawio.png", height: 11.5cm),
    caption: [Блок-схема Hill],
  ),
)

== Шифр "ADFGVX"
#grid(
  columns: (1fr, 1fr),   // two equal columns
  gutter: 1cm,           // space between the images
  figure(
    image("images/adfgvx_cryptool.png", height: 6cm),
    caption: [ADFGVX в CrypTool2],
  ),
  figure(
    image("images/adfgvx.drawio.png", height: 11.5cm),
    caption: [Блок-схема ADFGVX],
  ),
)

== Шифр "Изгородь"
#show link: underline
#grid(
  columns: (1fr, 1fr),   // two equal columns
  gutter: 1cm,           // space between the images
  [
    Программу реализации удалось оптимизировать, для исключения лишних вычислений. При зашифровании происходит итерация только по $K_1$, остальные значения шифровки заполняются автоматически.

    Исходный код программы доступен по #link("https://github.com/artyoomi/spbetu-cryptography-2026/blob/master/rail_fence/src/main.rs")[ссылке].
  ],
  figure(
    image("images/rail_fence.drawio.png", height: 11cm),
    caption: [Блок-схема шифра "Изгородь"],
  ),
)

== Заключение
+ Scytale: перестановка букв по таблице из n строк; частоты сохраняются, ключ подбирается перебором.
+ Агентурный шифр: одноалфавитная замена по лозунгу со сдвигом; прост, но вскрывается частотным анализом.
+ Vigenere: многоалфавитный сдвиг по ключевому слову; скрывает частоты, но уязвим из-за периодичности ключа.
+ Hill: умножение блоков текста на матрицу по mod 26; смешивает буквы, но линеен и вскрывается по известному тексту.
+ ADFGVX: замена по квадрату 6×6 и перестановка по ключу; самый стойкий из рассмотренных, но всё равно взламывается.
+ Изгородь: написан реализующий код и построена блок-схема.

// == Math
// The Gaussian integral:
// $ integral_(-oo)^(oo) e^(-x^2) dif x = sqrt(pi) $

// #bblock(title: [Theorem (Pythagoras)])[
//   For a right triangle with legs $a, b$ and hypotenuse $c$: $a^2 + b^2 = c^2$.
// ]

// == Two columns
// #grid(
//   columns: (1fr, 1fr),
//   gutter: 1cm,
//   [
//     *Left column*
//     - Point one
//     - Point two
//   ],
//   [
//     *Right column*
//     #table(
//       columns: 3,
//       fill: (_, y) => if y == 0 { light-color },
//       [*A*], [*B*], [*C*],
//       [1], [2], [3],
//       [4], [5], [6],
//     )
//   ],
// )

// == Conclusion
// #align(center + horizon)[
//   #text(size: 28pt, fill: main-color, weight: "bold")[Thank you!]

//   Questions?
// ]
