#import "dh-colors.typ": *
#import "dh-fonts.typ": *
#import "dh-helpers.typ": *

#let dh-book(
  title: none,
  author: none,
  image-bottom: none,
  image-above: none,
  publisher: [CC BY-NC-SA],
  body,
) = {
  show outline.entry.where(
    level: 1,
  ): set block(above: 1.1em)

  set outline.entry(fill: none)

  show outline.entry.where(level: 1): it => {
    // let chap-num = int-to-string.at(str(prefix()))
    let chap-act = int-to-string.english.at(str(int(it.prefix().text) - 1))
    link(
      it.element.location(),
      // Keep just the body, dropping
      // the fill and the page.
      it.indented(
        [#box(
          width: 8pt,
          height: 8pt,
          fill: col-act.at(it.prefix().text).chapter,
        )],
        text(..font-outline-chap, if it.prefix() == [1] [INTRODUCTION] else {
          upper[Chapter #chap-act:\ ]
          upper(text(weight: "medium", [ #it.body() \ ]))
        }),
      ),
    )
  }

  show outline.entry.where(level: 2): it => {
    link(
      it.element.location(),
      it.indented(none, text(..font-outline-sec, it.inner())),
    )
  }

  show outline.entry.where(level: 3): it => {
    link(
      it.element.location(),
      it.indented(none, text(..font-outline-sec, it.inner())),
    )
  }


  show heading.where(
    level: 1,
  ): it => {
    let col-chap = col-act.at(str(counter(heading).get().first()))
    col-chap-state.update(col-act.at(str(counter(heading).get().first())))
    set par(leading: 10pt)
    place(top + left, float: true, scope: "parent")[
      #text(
        size: 28pt,
        font: font-chapter.at("thin"),
        weight: "thin",
        fill: col-chap.chapter,
      )[#if counter(heading).get().first() == 1 [Introduction] else if (
          counter(heading).get().first() == 0
        ) [Contents] else [
          Chapter #int-to-string.at("english").at(str(counter(heading).get().first() - 1)) \
          #text(
            size: 21pt,
            font: font-chapter.at("thick"),
            weight: "regular",
            fill: col-chap.chapter,
            it.body,
          )
        ]
      ]
    ]
  }

  show heading.where(
    level: 2,
  ): it => text(
    size: 17pt,
    font: font-chapter.at("thick"),
    weight: "regular",
    fill: black,
    [#it.body\ ],
  )


  show heading.where(
    level: 3,
  ): it => {
    text(
      size: 12pt,
      font: font-chapter.at("thick"),
      weight: "regular",
      fill: col-chap-state.get().chapter,
      [#it.body\ ],
    )
  }
  show heading.where(
    level: 4,
  ): it => {
    text(
      size: 11pt,
      font: font-chapter.at("level-4"),
      weight: "bold",
      fill: col-chap-state.get().at("chapter"),
      [#box(width: 8pt, height: 8pt, fill: col-gold) #upper(it.body)\ ],
    )
  }


  if (title != none) {
    v(1fr)
    align(image-above, center)
    v(1cm)
    text(align(title, center), ..font-title.title, fill: rgb("#1f204bff"))
    linebreak()
    text(align(author, center), ..font-title.author)
    v(2fr)
    align(image-bottom, center)
    v(0.5cm)
    align(text(publisher, ..font-main), center)

    pagebreak()
  }

  set page(columns: 3, margin: (inside: 23mm, outside: 19mm))

  outline(depth: 3)

  set page(columns: 2, margin: (inside: 23mm, outside: 19mm))
  set columns(gutter: 4mm)
  set text(..font-main)
  set par(leading: 4pt)
  set list(indent: 1em)
  set heading(numbering: "1")

  body
}
