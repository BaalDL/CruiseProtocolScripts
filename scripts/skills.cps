#function skilllist
  SkillList = {}
  attackType = {}
  ResourceType = {}

  attackType.toString = function(name)
    if name == "BasicAttack_Slash" or name == "Slash" then
      return "참격"
    elseif name == "BasicAttack_Strike" or name == "Strike" then
      return "타격"
    elseif name == "BasicAttack_Pierce" or name == "Pierce" then
      return "관통"
    elseif name == "BasicAttack_Bite" or name == "Bite" then
      return "저작"
    elseif name == "BasicAttack_Bullet" or name == "Bullet" then
      return "탄환"
    elseif name == "BasicAttack_Throwing" or name == "Throwing" then
      return "투척"
    elseif name == "BasicAttack_Burst" or name == "Burst" then
      return "충격"
    elseif name == "BasicAttack_Fire" or name == "Fire" then
      return "화염"
    elseif name == "BasicAttack_Water" or name == "Water" then
      return "류수"
    elseif name == "BasicAttack_Ice" or name == "Ice" then
      return "한빙"
    elseif name == "BasicAttack_Grass" or name == "Grass" then
      return "수목"
    elseif name == "BasicAttack_Wind" or name == "Wind" then
      return "질풍"
    elseif name == "BasicAttack_Electric" or name == "Electric" then
      return "뢰전"
    elseif name == "BasicAttack_Ground" or name == "Ground" then
      return "대지"
    elseif name == "BasicAttack_Luminous" or name == "Luminous" then
      return "광채"
    elseif name == "BasicAttack_Dark" or name == "Dark" then
      return "암흑"
	  else
	    return "미구현"
    end	
	  return "없음"
  end

  ResourceType.toString = function(name)
    if name == "Mana" then
      return "마나"
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
    SkillList["BasicAttack_Pierce"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Pierce",
      AttackParameter="50",
      AttackerParameter="physicalAttack",
      TargetParameter="physicalDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(관통)"
    }
    SkillList["BasicAttack_Bite"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Bite",
      AttackParameter="50",
      AttackerParameter="physicalAttack",
      TargetParameter="physicalDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(저작)"
    }
    SkillList["BasicAttack_Bullet"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Bullet",
      AttackParameter="50",
      AttackerParameter="physicalAttack",
      TargetParameter="physicalDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(탄환)"
    }
    SkillList["BasicAttack_Throwing"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Throwing",
      AttackParameter="50",
      AttackerParameter="physicalAttack",
      TargetParameter="physicalDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(투척)"
    }
    SkillList["BasicAttack_Burst"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Burst",
      AttackParameter="50",
      AttackerParameter="physicalAttack",
      TargetParameter="physicalDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(충격)"
    }
    SkillList["BasicAttack_Fire"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Fire",
      AttackParameter="50",
      AttackerParameter="specialAttack",
      TargetParameter="specialDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(화염)"
    }
    SkillList["BasicAttack_Water"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Water",
      AttackParameter="50",
      AttackerParameter="specialAttack",
      TargetParameter="specialDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(류수)"
    }
    SkillList["BasicAttack_Ice"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Ice",
      AttackParameter="50",
      AttackerParameter="specialAttack",
      TargetParameter="specialDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(한빙)"
    }
    SkillList["BasicAttack_Grass"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Grass",
      AttackParameter="50",
      AttackerParameter="specialAttack",
      TargetParameter="specialDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(수목)"
    }
    SkillList["BasicAttack_Wind"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Wind",
      AttackParameter="50",
      AttackerParameter="specialAttack",
      TargetParameter="specialDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(질풍)"
    }
    SkillList["BasicAttack_Electric"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Electric",
      AttackParameter="50",
      AttackerParameter="specialAttack",
      TargetParameter="specialDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(뢰전)"
    }
    SkillList["BasicAttack_Ground"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Ground",
      AttackParameter="50",
      AttackerParameter="specialAttack",
      TargetParameter="specialDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(대지)"
    }
    SkillList["BasicAttack_Luminous"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Luminous",
      AttackParameter="50",
      AttackerParameter="specialAttack",
      TargetParameter="specialDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(광채)"
    }
    SkillList["BasicAttack_Dark"] = {
      MoveType="Attack",
      Target="AnEnemy",
      AttackType="Dark",
      AttackParameter="50",
      AttackerParameter="specialAttack",
      TargetParameter="specialDefense",
      DamageCalculationType="Basic",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "공격(암흑)"
    }
  // BasicAttacks End


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

    SkillList["RandomAttack_Fire1"] = {
      MoveType="Attack",
      Target="PWREnemies",
      minTarget=2,
      maxTarget=5,
      AttackType="Fire",
      AttackParameter="40",
      AttackerParameter="specialAttack",
      TargetParameter="specialDefense",
      DamageCalculationType="Basic",
      ResourceType="Mana",
      ResourceAmount="40",
      AfterDelay = 150,
      DelayType = "specialSpeed",
      Name = "마구 타오"
    }
  // Skills End
#end