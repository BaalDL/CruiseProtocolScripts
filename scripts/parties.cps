#function partydata

  allpartymembers = {}
  currentpartymembers = {}

  allpartymembers[1] = {
    name = "주인강",
    ally = true,
    --alive = true,
    gender = "male",
    maxHP = 100,
    --currHP = 100,
    maxResource = 100,
    --currResource = 100,
    ResourceType = "Mana",
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
      SkillList["WholeAttack_Fire1"]
    },
    AICommand = function(self, party, enemyparty)
      targets = {}
      targets = pickrandomtarget(party, 1)
      if targets then skillhandler(self, SkillList[self.attackType], targets) end
      return SkillList[self.attackType]
    end

    enemy.playerCommand = function(self, party, enemyparty)
    end    
  }

  --currentpartymembers = PartyHandler.init(allpartymembers[1])

#end