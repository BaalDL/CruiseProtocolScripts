#function partyheader
  function partyhandler(partyarchtype)
    party = partyarchtype
    targettable["10"] = party
    for k, v in pairs(party) do
      party[k].targetnumber = 10 + k
      targettable[tostring(10+k)] = party[k]
    end
  end
#end

#function partydata

  function PartyDefaultAICommand(self, party, enemyparty)
    targets = {}
    targets = pickrandomtarget(party, 1)
    if targets then skillhandler(self, SkillList[self.attackType], targets) end
    return SkillList[self.attackType]
  end

  defaultpartymembers = {}
  currentpartymembers = {}

  defaultpartymembers["TheProgatonist"] = {
    name = "/fW주인강/x",
    ally = true,
    
    gender = "male",
    maxHP = 180,

    maxResource = 100,

    ResourceType = "Mana",
    maxSkillCharges = {},
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
      SkillList["TwiceAttack_Slash"],
      SkillList["RandomAttack_Fire1"],
      SkillList["AllAttack_Fire1"],
      SkillList["SingleHeal_Basic1"],
      SkillList["CollateralAttack_Slash"],
      SkillList["Harass_GhostFire"],
      SkillList["Harass_Weaken"]
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
    AICommand = PartyDefaultAICommand,

    alive = true,
    currHP = 180,
    currResource = 100,
    currSkillCharges = {},
    currEphemerals = {pAch={1,-1}},
    newEphemerals = {},
    nullEphemerals = {}
  }

  defaultpartymembers["SideKick"] = {
    name = "조오연",
    ally = true,
    
    gender = "male",
    maxHP = 150,

    maxResource = 100,

    ResourceType = "Ki",
    maxSkillCharges = {},
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
      SkillList["TwiceAttack_Bite"],
      SkillList["AllAttack_Throwing1"],
      SkillList["SingleHeal_Basic1"],
      SkillList["CollateralAttack_Bite"],
      SkillList["Harass_Freeze"],
      SkillList["Harass_DropAttack"]
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
    AICommand = PartyDefaultAICommand,
    
    alive = true,
    currHP = 150,
    currResource = 100,
    currSkillCharges = {},
    currEphemerals = {pAch={6,-1}},
    newEphemerals = {},
    nullEphemerals = {}
  }

  defaultpartymembers["Versatile"] = {
    name = "여장남",
    ally = true,
    
    gender = "female",
    maxHP = 200,

    maxResource = 100,

    ResourceType = "Rage",
    maxSkillCharges = {},
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
      SkillList["TwiceAttack_Throwing"],
      SkillList["RandomAttack_Slash1"],
      SkillList["AllAttack_Ice1"],
      SkillList["SingleHeal_Basic1"],
      SkillList["CollateralAttack_Bullet"],
      SkillList["Harass_SleepPowder"],
      SkillList["Harass_DropPhysical"]
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
    AICommand = PartyDefaultAICommand,

    alive = true,
    currHP = 200,
    currResource = 100,
    currSkillCharges = {},
    currEphemerals = {},
    newEphemerals = {},
    nullEphemerals = {}
  }

  defaultpartymembers["TutorialMember1"] = {
    name = "/fb차기현/x",
    ally = true,
    
    gender = "male",
    maxHP = 200,

    maxResource = 100,

    ResourceType = "Ki",
    maxSkillCharges = {},
    Race = "Human",
    attackType = "BasicAttack_Bullet",
    physicalAttack = 28,
    physicalDefense = 23,
    physicalSpeed = 26,
    specialAttack = 15,
    specialDefense = 18,
    specialSpeed = 18,
    skills = {
      [0] = SkillList["BasicAttack_Bullet"],
      SkillList["SingleAttack_Pierce1"],
      SkillList["TwiceAttack_Throwing"],
      SkillList["RandomAttack_Slash1"],
      SkillList["AllAttack_Ice1"],
      SkillList["SingleHeal_Basic1"],
      SkillList["CollateralAttack_Bullet"],
      SkillList["Harass_SleepPowder"],
      SkillList["Harass_DropPhysical"]
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
      Grass = 100,
      Wind = 100,
      Electric = 100,
      Ground = 100,
      Luminous = 0,
      Dark = 100
    },
    AICommand = PartyDefaultAICommand,

    alive = true,
    currHP = 200,
    currResource = 100,
    currSkillCharges = {},
    currEphemerals = {},
    newEphemerals = {},
    nullEphemerals = {}
  }

  currentpartymembers[1] = defaultpartymembers["TheProgatonist"]

  function addtocurrentparty(memberkey)
    if (#currentpartymembers == MAXPARTY) then
      printl("파티에 사람이 너무 많아서 " .. defaultpartymembers[memberkey].name .. "(이)가 합류할 수 없었습니다.")
      return -1
    end
    for k, v in pairs(currentpartymembers) do
      if (k == memberkey) then
        printl(v.name .. "(은)는 이미 파티의 일원입니다.")
        return -1
      end
    end
    table.insert(currentpartymembers, defaultpartymembers[memberkey])
    partyhandler(currentpartymembers)
    printlw(defaultpartymembers[memberkey].name .. "(이)가 파티에 합류했습니다!")
    DEBUGPRINT(currentpartymembers)
  end

#end