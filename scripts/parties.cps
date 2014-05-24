#function partydata

  allpartymembers = {}
  currentpartymembers = {}

  allpartymembers[1] = {
    name = "주인강",
    ally = true,
    
    gender = "male",
    maxHP = 180,

    maxResource = 100,

    ResourceType = "Mana",
    Race = "Human",
    attackType = "BasicAttack_Strike",
    physicalAttack = 27,
    physicalDefense = 22,
    physicalSpeed = 23,
    specialAttack = 24,
    specialDefense = 19,
    specialSpeed = 19,
    skills = {
      [0] = SkillList["BasicAttack_Strike"],
      SkillList["SingleAttack_Fire1"],
      SkillList["SingleAttack_Water1"],
      SkillList["RandomAttack_Fire1"],
      SkillList["AllAttack_Fire1"]
    },
    AICommand = function(self, party, enemyparty)
      targets = {}
      targets = pickrandomtarget(party, 1)
      if targets then skillhandler(self, SkillList[self.attackType], targets) end
      return SkillList[self.attackType]
    end,
    
    playerCommand = function(self, party, enemyparty)
    end,

    alive = true,
    currHP = 180,
    currResource = 100
  }

  allpartymembers[2] = {
    name = "조오연",
    ally = true,
    
    gender = "male",
    maxHP = 150,

    maxResource = 100,

    ResourceType = "Ki",
    Race = "Human",
    attackType = "BasicAttack_Slash",
    physicalAttack = 24,
    physicalDefense = 26,
    physicalSpeed = 21,
    specialAttack = 18,
    specialDefense = 20,
    specialSpeed = 18,
    skills = {
      [0] = SkillList["BasicAttack_Slash"],
      SkillList["SingleAttack_Electric1"],
      SkillList["SingleAttack_Ground1"],
      SkillList["RandomAttack_Bullet1"],
      SkillList["AllAttack_Throwing1"]
    },
    AICommand = function(self, party, enemyparty)
      targets = {}
      targets = pickrandomtarget(party, 1)
      if targets then skillhandler(self, SkillList[self.attackType], targets) end
      return SkillList[self.attackType]
    end,
  
    playerCommand = function(self, party, enemyparty)
    end,
    
    alive = true,
    currHP = 150,
    currResource = 100
  }

  allpartymembers[3] = {
    name = "여장남",
    ally = true,
    
    gender = "female",
    maxHP = 200,

    maxResource = 100,

    ResourceType = "Rage",
    Race = "Human",
    attackType = "BasicAttack_Slash",
    physicalAttack = 28,
    physicalDefense = 23,
    physicalSpeed = 26,
    specialAttack = 15,
    specialDefense = 18,
    specialSpeed = 18,
    skills = {
      [0] = SkillList["BasicAttack_Strike"],
      SkillList["SingleAttack_Pierce1"],
      SkillList["SingleAttack_Burst1"],
      SkillList["RandomAttack_Slash1"],
      SkillList["AllAttack_Strike1"]
    },
    AICommand = function(self, party, enemyparty)
      targets = {}
      targets = pickrandomtarget(party, 1)
      if targets then skillhandler(self, SkillList[self.attackType], targets) end
      return SkillList[self.attackType]
    end,
    
    playerCommand = function(self, party, enemyparty)
    end,

    alive = true,
    currHP = 200,
    currResource = 100
  }

  currentpartymembers[1] = allpartymembers[1]
  currentpartymembers[2] = allpartymembers[2]
  currentpartymembers[3] = allpartymembers[3]

#end