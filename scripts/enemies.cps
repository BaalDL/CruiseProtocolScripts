#function enemylist
EnemyTempletes = {}

EnemyTempletes["thug"] = {}

EnemyTempletes["thug"] = {
  name = "불량배",
  genderTable = { 'male', 'male', 'male', 'female' },
  strengthTable = { -1, 0, 0, 0, 0, 0, 1, 1, 2},
  strengthPercent = 0.05,
  HPBase = 100,
  ResourceBase = 100,
  ResourceType = "None",
  Race = "Human",
  AttackType = "BasicAttack_Strike",
  physicalAttack = 27,
  physicalDefense = 22,
  physicalSpeed = 23,
  specialAttack = 12,
  specialDefense = 14,
  specialSpeed = 11,
  skills = {
    SkillList["SingleAttack_Fire1"],
    SkillList["SingleAttack_Water1"]
  },
  AICommand = function(self, party, enemyparty)
    targets = {}
	  targets = pickrandomtarget(party, 1)
    if targets then skillhandler(self, SkillList[self.attackType], targets) end
    return SkillList[self.attackType]
  end    
}

#end