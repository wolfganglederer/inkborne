#import "dh-colors.typ": *
#import "dh-fonts.typ": *


// int_to_string converts numbers to literals sofar only english and german are supported.
// usage: #int_to_string.english.at(str(1))
//

#let int_to_string = (
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


#let dh_box(
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
    #let size_diag = size.width;
    #let height_diag = height - diag;
    #let width = size.width - diag;

    #polygon(
      (width, 0pt),
      (size_diag, diag),
      (size_diag, height_diag),
      (width, height),
      (diag, height),
      (0pt, height_diag),
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



#let dh_example(color: col_purple, content) = {
  box(
    fill: color.example_fill,
    stroke: (y: color.example_border),
    width: 1fr,
    inset: 4pt,
    content,
  )
  linebreak()
}

// #dh_example([This is an example])


#let dh_optional(color: col_purple, content) = {
  dh_box(stroke: none, fill: color.optional)[#content]
}

// #dh_optional([This is an optional rule.])


#let dh_enum(color: col_purple, content) = {
  box(fill: color.enum_fill, width: 1fr, inset: 5pt, stroke: (
    y: 0.5pt + color.enum_border,
  ))[
    #set list(indent: 0em)
    #set list(marker: text("\u{2192}", font: "Capitana", size: 8.5pt))
    #content]
  linebreak()
}

// #dh_enum([
//   - eins
//   - zwei
// ])

#let dh_adversaries(
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
  range: "Melee",
  damage: "d8+1 (phy)",
  experience: "Make nice blocks",
  features: [
    *_Warped Fortitude - Passive:_* The Experiment is resistant to physical damage.


    *_Lurching Lunge - Action:_* Mark a Stress to spotlight the Experiment as an additional GM move instead of spending Fear.],
  fonts: font_adversaries,
  colors: col_adversaries,
) = {
  dh_box(stroke: colors.border + 0.5pt, fill: colors.fill)[
    #text(..fonts.name)[#name]\
    #text(..fonts.tier)[Tier #tier #type]\
    #text(..fonts.text)[_#description _]\
    #text(..fonts.text)[*Motives & Tactics*: #motives]\
    #box(
      fill: colors.box_fill,
      stroke: (y: colors.box_line + 0.5pt),
      width: 1fr,
      inset: 4pt,
    )[
      #set text(..fonts.text)
      *Difficulty:* #difficulty | *Thresholds* #thresholds | *HP:* #hp | *Stress:* #stress \
      *ATK:* #atk | *#attack: * #range | #damage\
      #v(-5pt)
      #line(length: 100%, stroke: (
        paint: colors.dot_line,
        dash: "densely-dotted",
      ))
      #v(-6pt)
      *Experience:* #experience
    ]\
    #set par(hanging-indent: 1em, spacing: 5pt, leading: 3pt)
    #v(-6pt)
    #text(..fonts.features)[FEATURES]

    #text(..fonts.text)[ #features]
  ]
}

// #dh_adversaries()


#let dh_environment(
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
  fonts: font_environment,
  colors: col_environment,
) = {
  dh_box(stroke: colors.border + 0.5pt, fill: colors.fill)[
    #text(..fonts.name)[#name]\
    #text(..fonts.tier)[Tier #tier #type]\
    #text(..fonts.text)[_#description _]\
    #text(..fonts.text)[*Impulses*: #impulses]\
    #box(
      fill: colors.box_fill,
      stroke: (y: colors.box_line + 0.5pt),
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

// #dh_environment(adversaries: [Acid Burrower])

#let dh_table(color: col_blue, ..args) = {
  show table.cell.where(y: 0): set text(..font_table.head)
  table(
    fill: (_, y) => if y == 0 { color.table_head } else if calc.even(y) {
      color.table_dark
    },
    stroke: (_, y) => if y == 0 { (bottom: color.table_border + 0.5pt) },
    ..args
  )
}


#let dh_table_small(color: col_blue, ..args) = {
  // show table.cell.where(y:0): set text(..font_table.head)
  table(
    fill: (_, y) => if calc.even(y) { color.table_dark },
    stroke: (_, y) => if y == 0 { (top: color.table_border + 1pt) },
    ..args
  )
}
