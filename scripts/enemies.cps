#function enemylist
  EnemyTempletes = {}
  EnemyInfo = {}
  EnemyDefenseInfo = {}

  execute("enemyalgorithms")
  --enter EnemyTempletes[tab] to load snippet

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
      SkillList["SingleAttack_Strike1"]
    },
    maxSkillCharges = {},
    defensiveType = {
      Slash = "s",
      Strike = "s",
      Pierce = "s",
      Bite = "s",
      Bullet = "s",
      Throwing = "s",
      Burst = "s",
      Fire = "a",
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
      Ice = 100,
      Grass = 50,
      Wind = 100,
      Electric = 100,
      Ground = 100,
      Luminous = 0,
      Dark = 100
    },
    AICommand = randomlyattacktargetwithskills,
    ephemeralImmunes = {"burn"}
  }

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
      SkillList["SingleAttack_Strike1"],
      SkillList["SingleAttack_Slash1"]
    },
    maxSkillCharges = {},
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
      Ice = "n",
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
    AICommand = randomlyattacktargetwithskills,
    ephemeralImmunes = {"sleep","stoned"}
  }


  for k, _ in pairs(EnemyTempletes) do
    EnemyInfo[k] = false
    EnemyDefenseInfo[k] = {
      Slash = false,
      Strike = false,
      Pierce = false,
      Bite = false,
      Bullet = false,
      Throwing = false,
      Burst = false,
      Fire = false,
      Water = false,
      Ice = false,
      Grass = false,
      Wind = false,
      Electric = false,
      Ground = false,
      Luminous = false,
      Dark = false
    }
  end
#end