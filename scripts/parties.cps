#function partyheader
  function partyhandler(partyarchtype)
    party = partyarchtype
    targettable["10"] = party
    for k, v in pairs(party) do
      party[k].targetnumber = 10 + k
      targettable[tostring(10+k)] = party[k]
    end
    return party
  end
#end

#function partydata

  function PartyDefaultAICommand(self, party, enemyparty)
    targets = {}
    targets = pickrandomtarget(party, 1)
    if targets then skillhandler(self, SkillList[self.attackType], targets) end
    return SkillList[self.attackType]
  end

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
      SkillList["AllAttack_Fire1"],
      SkillList["SingleHeal_Basic1"]
    },
    skillCharges = {},
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
    AICommand = PartyDefaultAICommand,
    
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
      SkillList["AllAttack_Throwing1"],
      SkillList["SingleHeal_Basic1"]
    },
    skillCharges = {},
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
    AICommand = PartyDefaultAICommand,
  
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
      SkillList["AllAttack_Strike1"],
      SkillList["SingleHeal_Basic1"]
    },
    skillCharges = {},
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
    AICommand = PartyDefaultAICommand,
    
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