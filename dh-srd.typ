// functions that uses srd material
#import "dh-helpers.typ": *


#let dh-srd-feature(feature) = {
  for feat in feature {
    "*" + feat.name + ":* " + feat.text + "\n\n #v(4pt)"
  }
}

#let dh-srd-adversaries(adversaries-json, name, n: none) = {
  let adversaries-filtered = adversaries-json
    .filter(x => x.name.contains(name))
    .first()

  let features-text = dh-srd-feature(adversaries-filtered.at(
    "feats",
    default: none,
  ))

  dh-adversaries(
    name: adversaries-filtered.name,
    tier: adversaries-filtered.tier,
    type: adversaries-filtered.type,
    description: adversaries-filtered.description,
    difficulty: adversaries-filtered.difficulty,
    motives: adversaries-filtered.motives_and_tactics,
    thresholds: adversaries-filtered.thresholds,
    hp: adversaries-filtered.hp,
    stress: adversaries-filtered.stress,
    atk: adversaries-filtered.atk,
    attack: adversaries-filtered.attack,
    range-atk: adversaries-filtered.range,
    damage: adversaries-filtered.damage,
    experience: adversaries-filtered.at("experience", default: none),
    features: eval(features-text, mode: "markup"),
    n: n,
  )
}


// function for adding environments
//


#let dh-srd-environments(environments-json, name) = {
  let environments-filtered = environments-json
    .filter(x => x.name.contains(name))
    .first()
  let features-text = dh-srd-feature(environments-filtered.at(
    "feats",
    default: none,
  ))

  dh-environment(
    name: environments-filtered.name,
    tier: environments-filtered.tier,
    type: environments-filtered.type,
    description: environments-filtered.description,
    impulses: environments-filtered.impulses,
    adversaries: environments-filtered.potential_adversaries,
    difficulty: environments-filtered.difficulty,
    features: eval(features-text, mode: "markup"),
  )
}
