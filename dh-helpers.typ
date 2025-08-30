#import "dh-colors.typ": *
#import "dh-fonts.typ": *


// int-to-string converts numbers to literals sofar only english and german are supported.
// usage: #int-to-string.english.at(str(1))
//


#let col-chap-state = state("color", col-act.at("1"))

#let int-to-string = (
  english: (
    "1": "one",
    "2": "two",
    "3": "three",
    "4": "four",
    "5": "five",
    "6": "six",
    "7": "seven",
    "8": "eight",
    "9": "nine",
  ),
  german: (
    "1": "eins",
    "2": "zwei",
    "3": "drei",
    "4": "vier",
    "5": "fünf",
    "6": "sechs",
    "7": "sieben",
    "8": "acht",
    "9": "neun",
  ),
)


#let dh-box(
  body,
  diag: 3pt,
  inset: (x: 4pt, y: 10pt),
  stroke: 1pt + black,
  fill: none,
) = {
  // let args = arguments(stroke: 1pt+black, fill: blue)
  layout(size => context [
    #let (height,) = measure(box(
      width: size.width,
      stroke: 0.1pt + blue,
      inset: inset,
      body,
    ))
    #let size-diag = size.width;
    #let height-diag = height - diag;
    #let width = size.width - diag;

    #polygon(
      (width, 0pt),
      (size-diag, diag),
      (size-diag, height-diag),
      (width, height),
      (diag, height),
      (0pt, height-diag),
      (0pt, diag),
      (diag, 0pt),
      stroke: stroke,
      fill: fill,
    )
    #place(top + left)[
      #box(fill: none, stroke: none, inset: inset)[
        #body
      ]
    ]
  ])
}



#let dh-example(color: col-dummy, content) = {
  context {
    let color-ex = color
    if color-ex.name == "dummy" { color-ex = col-chap-state.get() }
    box(
      fill: color-ex.example-fill,
      stroke: (y: color-ex.example-border),
      width: 1fr,
      inset: 4pt,
      content,
    )
  }
  linebreak()
}

// #dh-example([This is an example])


#let dh-optional(color: col-dummy, content) = {
  context {
    let color-du = color
    if color-du.name == "dummy" { color-du = col-chap-state.get() }
    dh-box(stroke: none, fill: color-du.optional)[#content]
  }
}

// #dh-optional([This is an optional rule.])


#let dh-enum(color: col-dummy, content) = {
  context {
    let color-en = color
    if color-en.name == "dummy" { color-en = col-chap-state.get() }
    box(fill: color-en.enum-fill, width: 1fr, inset: 5pt, stroke: (
      y: 0.5pt + color-en.enum-border,
    ))[
      #set list(indent: 0em)
      #set list(marker: text("\u{2192}", font: "Capitana", size: 8.5pt))
      #content]
  }
  linebreak()
}

// #dh-enum([
//   - eins
//   - zwei
// ])

#let dh-adversaries(
  name: "Scary Monster",
  tier: 1,
  type: "Solo",
  description: "A very scary monster",
  difficulty: 10,
  motives: "Scare small adventurers",
  thresholds: "5/9",
  hp: 4,
  stress: 3,
  atk: +1,
  attack: "Longsword",
  range-atk: "Melee",
  damage: "d8+1 (phy)",
  experience: "Make nice blocks",
  features: [
    *-Warped Fortitude - Passive:-* The Experiment is resistant to physical damage.


    *-Lurching Lunge - Action:-* Mark a Stress to spotlight the Experiment as an additional GM move instead of spending Fear.],
  n: none,
  fonts: font-adversaries,
  colors: col-adversaries,
) = {
  dh-box(stroke: colors.border + 0.5pt, fill: colors.fill)[
    #text(..fonts.name)[#name]\
    #text(..fonts.tier)[Tier #tier #type]\
    #text(..fonts.text)[_#description _]\
    #text(..fonts.text)[*Motives & Tactics*: #motives]\
    #box(
      fill: colors.box-fill,
      stroke: (y: colors.box-line + 0.5pt),
      width: 1fr,
      inset: 4pt,
    )[
      #set text(..fonts.text)
      *Difficulty:* #difficulty | *Thresholds* #thresholds | *HP:* #hp | *Stress:* #stress \
      *ATK:* #atk | *#attack: * #range-atk | #damage\
      #if experience != none [
        #v(-5pt)
        #line(length: 100%, stroke: (
          paint: colors.dot-line,
          dash: "densely-dotted",
        ))
        #v(-6pt)
        *Experience:* #experience]
    ]\
    #set par(hanging-indent: 1em, spacing: 5pt, leading: 3pt)
    #v(-6pt)
    #text(..fonts.features)[FEATURES]

    #text(..fonts.text)[ #features]
    #if n != none {
      for i in range(n) [

        // hier steht dann der code für schöne  Adversaries
        #line()
        #name

      ]
    }
  ]
}

// #dh-adversaries()


#let dh-environment(
  name: "Scary Environment",
  tier: 1,
  type: "Social",
  description: "A very scary encounter",
  impulses: "Make small heroes shit their pants.",
  adversaries: none,
  difficulty: 10,
  features: [
    *The Climb - Passive:* Climbing up the cliff side uses a Progress Countdown (12). It ticks down according to the following criteria when the PCs make an action roll to climb:
    - *Critical Success:* Tick down 3
    - *Success with Hope:* Tick down 2
    - *Success with Fear:* Tick down 1
    - *Failure with Hope:* No advancement
    - *Failure with Fear:* Tick up 1 When the countdown triggers, the party has made it to the top of the cliff .

    *Fall - Action:* *Spend a Fear* to have a PC’s handhold fail, plummeting them toward the ground. If they aren’t saved on the next action, they hit the ground and tick up the countdown by 2. The PC takes 1d12 physical damage if the countdown is between 8 and 12, *2d12* between 4 and 7, and *3d12* at 3 or lower.],
  fonts: font-environment,
  colors: col-environment,
) = {
  dh-box(stroke: colors.border + 0.5pt, fill: colors.fill)[
    #text(..fonts.name)[#name]\
    #text(..fonts.tier)[Tier #tier #type]\
    #text(..fonts.text)[_#description _]\
    #text(..fonts.text)[*Impulses*: #impulses]\
    #box(
      fill: colors.box-fill,
      stroke: (y: colors.box-line + 0.5pt),
      width: 1fr,
      inset: 4pt,
    )[
      #set text(..fonts.text)
      *Difficulty:* #difficulty \
      #if (adversaries != none) [*Potential Adversaries* #adversaries]
    ]\
    #set par(hanging-indent: 1em, spacing: 5pt, leading: 3pt)
    #v(-6pt)
    #text(..fonts.features)[FEATURES]

    #text(..fonts.text)[ #features]
  ]
}

// #dh-environment(adversaries: [Acid Burrower])

#let dh-table(color: col-dummy, ..args) = {
  context {
    let color-tab = color
    if color-tab.name == "dummy" { color-tab = col-chap-state.get() }
    show table.cell.where(y: 0): set text(..font-table.head)
    table(
      fill: (_, y) => if y == 0 { color-tab.table-head } else if calc.even(y) {
        color-tab.table-dark
      },
      stroke: (_, y) => if y == 0 { (bottom: color-tab.table-border + 0.5pt) },
      ..args
    )
  }
}

#let dh-table-small(color: col-blue, ..args) = {
  context {
    let color-tab = color
    if color-tab.name == "dummy" { color-tab = col-chap-state.get() }
    table(
      fill: (_, y) => if calc.even(y) { color-tab.table-dark },
      stroke: (_, y) => if y == 0 { (top: color-tab.table-border + 1pt) },
      ..args
    )
  }
}
