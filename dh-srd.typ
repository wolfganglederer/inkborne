// functions that uses srd material
#import "dh-helpers.typ": *


#let dh-srd-feature(feature) = {
  [#for feat in feature [
      *#feat.name :* #feat.text

    ]
  ]
}

#let dh-srd-adversaris(adversaries-json, n) = {

  let features-text = dh-srd-feature(adversaries-json.at(
    "feats",
    default: none,
  ))

  dh-adversaries(
    name: adversaries-json.name,
    tier: adversaries-json.tier,
    type: adversaries-json.type,
    description: adversaries-json.description,
    difficulty: adversaries-json.difficulty,
    motives: adversaries-json.motives_and_tactics,
    thresholds: adversaries-json.thresholds,
    hp: adversaries-json.hp,
    stress: adversaries-json.stress,
    atk: adversaries-json.atk,
    attack: adversaries-json.attack,
    range-atk: adversaries-json.range,
    damage: adversaries-json.damage,
    experience: adversaries-json.at("experience", default: none),
    features: features-text,
    n: n
  )
}


// write features function...

