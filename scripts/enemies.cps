#function enemylist
  EnemyTempletes = {}
  EnemyInfo = {}
  EnemyDefenseInfo = {}

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
      SkillList["SingleAttack_Water1"],
      SkillList["RandomAttack_Fire1"],
      SkillList["AllAttack_Fire1"]
    },
    defensiveType = {
      Slash = "s",
      Strike = "s",
      Pierce = "s",
      Bite = "s",
      Bullet = "s",
      Throwing = "s",
      Burst = "s",
      Fire = "s",
      Water = "s",
      Ice = "s",
      Grass = "s",
      Wind = "s",
      Electric = "s",
      Ground = "s",
      Luminous = "n",
      Dark = "s"
    },
    defensiveFactor = {
      Slash = 100,
      Strike = 100,
      Pierce = 100,
      Bite = 100,
      Bullet = 100,
      Throwing = 100,
      Burst = 100,
      Fire = 150,
      Water = 100,
      Ice = 100,
      Grass = 50,
      Wind = 100,
      Electric = 100,
      Ground = 100,
      Luminous = 0,
      Dark = 100
    },
    AICommand = function(self, party, enemyparty)
      targets = {}
      targets = pickrandomtarget(party, 1)
      if targets then skillhandler(self, SkillList[self.attackType], targets) end
      return SkillList[self.attackType]
    end
  }
  EnemyInfo["thug"] = false
  EnemyDefenseInfo["thug"] = {}
  EnemyDefenseInfo["thug"]["Slash"] = false
  EnemyDefenseInfo["thug"]["Strike"] = false
  EnemyDefenseInfo["thug"]["Pierce"] = false
  EnemyDefenseInfo["thug"]["Bite"] = false
  EnemyDefenseInfo["thug"]["Bullet"] = false
  EnemyDefenseInfo["thug"]["Throwing"] = false
  EnemyDefenseInfo["thug"]["Burst"] = false
  EnemyDefenseInfo["thug"]["Fire"] = false
  EnemyDefenseInfo["thug"]["Water"] = false
  EnemyDefenseInfo["thug"]["Ice"] = false
  EnemyDefenseInfo["thug"]["Grass"] = false
  EnemyDefenseInfo["thug"]["Wind"] = false
  EnemyDefenseInfo["thug"]["Electric"] = false
  EnemyDefenseInfo["thug"]["Ground"] = false
  EnemyDefenseInfo["thug"]["Luminous"] = false
  EnemyDefenseInfo["thug"]["Dark"] = false

  EnemyTempletes["knifethug"] = {
    name = "칼잡이",
    genderTable = { 'male', 'male', 'male', 'female' },
    strengthTable = { -1, 0, 0, 0, 0, 0, 1, 1, 2},
    strengthPercent = 0.05,
    HPBase = 50,
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
    defensiveType = {
      Slash = "r",
      Strike = "s",
      Pierce = "s",
      Bite = "s",
      Bullet = "s",
      Throwing = "s",
      Burst = "s",
      Fire = "s",
      Water = "s",
      Ice = "s",
      Grass = "s",
      Wind = "s",
      Electric = "s",
      Ground = "s",
      Luminous = "n",
      Dark = "s"
    },
    defensiveFactor = {
      Slash = 100,
      Strike = 100,
      Pierce = 100,
      Bite = 100,
      Bullet = 100,
      Throwing = 100,
      Burst = 100,
      Fire = 100,
      Water = 100,
      Ice = 200,
      Grass = 100,
      Wind = 50,
      Electric = 100,
      Ground = 100,
      Luminous = 0,
      Dark = 100
    },
    AICommand = function(self, party, enemyparty)
      targets = {}
      targets = pickrandomtarget(party, 1)
      if targets then skillhandler(self, SkillList[self.attackType], targets) end
      return SkillList[self.attackType]
    end    
  }
  EnemyInfo["knifethug"] = false
  EnemyDefenseInfo["knifethug"] = {}
  EnemyDefenseInfo["knifethug"]["Slash"] = false
  EnemyDefenseInfo["knifethug"]["Strike"] = false
  EnemyDefenseInfo["knifethug"]["Pierce"] = false
  EnemyDefenseInfo["knifethug"]["Bite"] = false
  EnemyDefenseInfo["knifethug"]["Bullet"] = false
  EnemyDefenseInfo["knifethug"]["Throwing"] = false
  EnemyDefenseInfo["knifethug"]["Burst"] = false
  EnemyDefenseInfo["knifethug"]["Fire"] = false
  EnemyDefenseInfo["knifethug"]["Water"] = false
  EnemyDefenseInfo["knifethug"]["Ice"] = false
  EnemyDefenseInfo["knifethug"]["Grass"] = false
  EnemyDefenseInfo["knifethug"]["Wind"] = false
  EnemyDefenseInfo["knifethug"]["Electric"] = false
  EnemyDefenseInfo["knifethug"]["Ground"] = false
  EnemyDefenseInfo["knifethug"]["Luminous"] = false
  EnemyDefenseInfo["knifethug"]["Dark"] = false

#end