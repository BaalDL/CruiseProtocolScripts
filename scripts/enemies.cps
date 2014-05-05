#function enemylist
  EnemyTempletes = {}
  EnemyInfo = {}

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
  EnemyInfo["thug"] = false

  EnemyTempletes["knifethug"] = {
    name = "칼잡이",
    genderTable = { 'male', 'male', 'male', 'female' },
    strengthTable = { -1, 0, 0, 0, 0, 0, 1, 1, 2},
    strengthPercent = 0.05,
    HPBase = 94,
    ResourceBase = 100,
    ResourceType = "None",
    Race = "Human",
    AttackType = "BasicAttack_Slash",
    physicalAttack = 30,
    physicalDefense = 15,
    physicalSpeed = 27,
    specialAttack = 13,
    specialDefense = 12,
    specialSpeed = 14,
    skills = {
    },
    AICommand = function(self, party, enemyparty)
      targets = {}
      targets = pickrandomtarget(party, 1)
      if targets then skillhandler(self, SkillList[self.attackType], targets) end
      return SkillList[self.attackType]
    end    
  }
  EnemyInfo["knifethug"] = false

#end