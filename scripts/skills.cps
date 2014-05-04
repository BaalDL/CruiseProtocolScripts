#function skilllist
  SkillList = {}
  attackType = {}
  ResourceType = {}

  attackType.toString = function(name)
    if name == "BasicAttack_Slash" or name == "Slash" then
      return "참격"
    elseif name == "BasicAttack_Strike" or name == "Strike" then
	    return "타격"
	  else
	    return "미구현"
    end	
	  return "없음"
  end

  ResourceType.toString = function(name)
    if name == "Mana" then
      return "MP"
    elseif name == "Ki" then
      return "기력"
    elseif name == "Rage" then
      return "분노"
    elseif name == "Charge" then
      return "충전량"
    else
      return "없음"
    end
  end
  // BasicAttacks
  SkillList["BasicAttack_Slash"] = {
    MoveType="Attack",
    Target="AnEnemy",
    AttackType="Slash",
    AttackParameter="50",
    AttackerParameter="physicalAttack",
    TargetParameter="physicalDefense",
    DamageCalculationType="Basic",
    AfterDelay = 100,
    DelayType = "physicalSpeed",
	  Name = "공격(참격)"
  }
  SkillList["BasicAttack_Strike"] = {
    MoveType="Attack",
    Target="AnEnemy",
    AttackType="Strike",
    AttackParameter="50",
    AttackerParameter="physicalAttack",
    TargetParameter="physicalDefense",
    DamageCalculationType="Basic",
    AfterDelay = 100,
    DelayType = "physicalSpeed",
    Name = "공격(타격)"
  }

  // Skills
  SkillList["SingleAttack_Fire1"] = {
    MoveType="Attack",
	  Target="AnEnemy",
	  AttackType="Fire",
	  AttackParameter="40",
	  AttackerParameter="specialAttack",
	  TargetParameter="specialDefense",
	  DamageCalculationType="Basic",
    ResourceType="Mana",
    ResourceAmount="10",
    AfterDelay = 120,
    DelayType = "specialSpeed",
	  Name = "타오"
  }
  
  SkillList["SingleAttack_Water1"] = {
    MoveType="Attack",
	  Target="AnEnemy",
	  AttackType="Water",
	  AttackParameter="40",
	  AttackerParameter="specialAttack",
	  TargetParameter="specialDefense",
	  DamageCalculationType="Basic",
    ResourceType="Mana",
    ResourceAmount="10",
    AfterDelay = 120,
    DelayType = "specialSpeed",
	  Name = "비가"
  }  
#end