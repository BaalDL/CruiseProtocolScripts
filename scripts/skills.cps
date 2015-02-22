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

  attackType.toChar = function(name)
    if name == "BasicAttack_Slash" or name == "Slash" then
      return "참"
    elseif name == "BasicAttack_Strike" or name == "Strike" then
      return "타"
    elseif name == "BasicAttack_Pierce" or name == "Pierce" then
      return "관"
    elseif name == "BasicAttack_Bite" or name == "Bite" then
      return "저"
    elseif name == "BasicAttack_Bullet" or name == "Bullet" then
      return "탄"
    elseif name == "BasicAttack_Throwing" or name == "Throwing" then
      return "투"
    elseif name == "BasicAttack_Burst" or name == "Burst" then
      return "충"
    elseif name == "BasicAttack_Fire" or name == "Fire" then
      return "화"
    elseif name == "BasicAttack_Water" or name == "Water" then
      return "수"
    elseif name == "BasicAttack_Ice" or name == "Ice" then
      return "빙"
    elseif name == "BasicAttack_Grass" or name == "Grass" then
      return "목"
    elseif name == "BasicAttack_Wind" or name == "Wind" then
      return "풍"
    elseif name == "BasicAttack_Electric" or name == "Electric" then
      return "뢰"
    elseif name == "BasicAttack_Ground" or name == "Ground" then
      return "지"
    elseif name == "BasicAttack_Luminous" or name == "Luminous" then
      return "광"
    elseif name == "BasicAttack_Dark" or name == "Dark" then
      return "암"
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

    SkillList["UseItem"] = {
      MoveType="UseItem",
      AfterDelay = 100,
      DelayType = "physicalSpeed",
      Name = "아이템 사용"
    }

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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
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
      Accuracy = 100,      
      DelayType = "physicalSpeed",
      Name = "공격(암흑)"
    }
  // BasicAttacks End


  // Skills
    SkillList["SingleAttack_Slash1"] = {Name="베어", MoveType="Attack", Target="AnEnemy", AttackType="Slash", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=15, Accuracy=99, AfterDelay=120, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Slash2"] = {Name="베어낸", MoveType="Attack", Target="AnEnemy", AttackType="Slash", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=99, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Slash3"] = {Name="베어낸다", MoveType="Attack", Target="AnEnemy", AttackType="Slash", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=99, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Slash1"] = {Name="마구 베어", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Slash", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=96, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Slash2"] = {Name="마구 베어낸", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Slash", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=96, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Slash3"] = {Name="마구 베어낸다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Slash", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=180, Accuracy=96, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Slash1"] = {Name="모드 베어", MoveType="Attack", Target="WholeEnemy", AttackType="Slash", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=93, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["AllAttack_Slash2"] = {Name="모드 베어낸", MoveType="Attack", Target="WholeEnemy", AttackType="Slash", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=93, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Slash3"] = {Name="모드 베어낸다", MoveType="Attack", Target="WholeEnemy", AttackType="Slash", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=225, Accuracy=93, AfterDelay=240, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Strike1"] = {Name="두들", MoveType="Attack", Target="AnEnemy", AttackType="Strike", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=15, Accuracy=99, AfterDelay=120, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Strike2"] = {Name="두들긴", MoveType="Attack", Target="AnEnemy", AttackType="Strike", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=99, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Strike3"] = {Name="두들긴다", MoveType="Attack", Target="AnEnemy", AttackType="Strike", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=99, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Strike1"] = {Name="마구 두들", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Strike", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=96, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Strike2"] = {Name="마구 두들긴", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Strike", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=96, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Strike3"] = {Name="마구 두들긴다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Strike", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=180, Accuracy=96, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Strike1"] = {Name="모드 두들", MoveType="Attack", Target="WholeEnemy", AttackType="Strike", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=93, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["AllAttack_Strike2"] = {Name="모드 두들긴", MoveType="Attack", Target="WholeEnemy", AttackType="Strike", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=93, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Strike3"] = {Name="모드 두들긴다", MoveType="Attack", Target="WholeEnemy", AttackType="Strike", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=225, Accuracy=93, AfterDelay=240, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Pierce1"] = {Name="케툴", MoveType="Attack", Target="AnEnemy", AttackType="Pierce", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=15, Accuracy=99, AfterDelay=120, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Pierce2"] = {Name="케툴른", MoveType="Attack", Target="AnEnemy", AttackType="Pierce", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=99, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Pierce3"] = {Name="케툴른다", MoveType="Attack", Target="AnEnemy", AttackType="Pierce", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=99, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Pierce1"] = {Name="마구 케툴", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Pierce", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=96, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Pierce2"] = {Name="마구 케툴른", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Pierce", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=96, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Pierce3"] = {Name="마구 케툴른다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Pierce", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=180, Accuracy=96, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Pierce1"] = {Name="모드 케툴", MoveType="Attack", Target="WholeEnemy", AttackType="Pierce", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=93, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["AllAttack_Pierce2"] = {Name="모드 케툴른", MoveType="Attack", Target="WholeEnemy", AttackType="Pierce", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=93, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Pierce3"] = {Name="모드 케툴른다", MoveType="Attack", Target="WholeEnemy", AttackType="Pierce", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=225, Accuracy=93, AfterDelay=240, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Bite1"] = {Name="캐무", MoveType="Attack", Target="AnEnemy", AttackType="Bite", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=15, Accuracy=99, AfterDelay=120, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Bite2"] = {Name="캐무른", MoveType="Attack", Target="AnEnemy", AttackType="Bite", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=99, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Bite3"] = {Name="캐무른다", MoveType="Attack", Target="AnEnemy", AttackType="Bite", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=99, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Bite1"] = {Name="마구 캐무", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Bite", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=96, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Bite2"] = {Name="마구 캐무른", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Bite", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=96, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Bite3"] = {Name="마구 캐무른다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Bite", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=180, Accuracy=96, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Bite1"] = {Name="모드 캐무", MoveType="Attack", Target="WholeEnemy", AttackType="Bite", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=93, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["AllAttack_Bite2"] = {Name="모드 캐무른", MoveType="Attack", Target="WholeEnemy", AttackType="Bite", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=93, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Bite3"] = {Name="모드 캐무른다", MoveType="Attack", Target="WholeEnemy", AttackType="Bite", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=225, Accuracy=93, AfterDelay=240, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Bullet1"] = {Name="소아", MoveType="Attack", Target="AnEnemy", AttackType="Bullet", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=15, Accuracy=99, AfterDelay=120, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Bullet2"] = {Name="소아댄", MoveType="Attack", Target="AnEnemy", AttackType="Bullet", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=99, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Bullet3"] = {Name="소아댄다", MoveType="Attack", Target="AnEnemy", AttackType="Bullet", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=99, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Bullet1"] = {Name="마구 소아", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Bullet", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=96, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Bullet2"] = {Name="마구 소아댄", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Bullet", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=96, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Bullet3"] = {Name="마구 소아댄다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Bullet", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=180, Accuracy=96, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Bullet1"] = {Name="모드 소아", MoveType="Attack", Target="WholeEnemy", AttackType="Bullet", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=93, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["AllAttack_Bullet2"] = {Name="모드 소아댄", MoveType="Attack", Target="WholeEnemy", AttackType="Bullet", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=93, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Bullet3"] = {Name="모드 소아댄다", MoveType="Attack", Target="WholeEnemy", AttackType="Bullet", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=225, Accuracy=93, AfterDelay=240, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Throwing1"] = {Name="서거", MoveType="Attack", Target="AnEnemy", AttackType="Throwing", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=15, Accuracy=99, AfterDelay=120, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Throwing2"] = {Name="서거긴", MoveType="Attack", Target="AnEnemy", AttackType="Throwing", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=99, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Throwing3"] = {Name="서거긴다", MoveType="Attack", Target="AnEnemy", AttackType="Throwing", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=99, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Throwing1"] = {Name="마구 서거", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Throwing", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=96, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Throwing2"] = {Name="마구 서거긴", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Throwing", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=96, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Throwing3"] = {Name="마구 서거긴다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Throwing", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=180, Accuracy=96, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Throwing1"] = {Name="모드 서거", MoveType="Attack", Target="WholeEnemy", AttackType="Throwing", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=93, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["AllAttack_Throwing2"] = {Name="모드 서거긴", MoveType="Attack", Target="WholeEnemy", AttackType="Throwing", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=93, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Throwing3"] = {Name="모드 서거긴다", MoveType="Attack", Target="WholeEnemy", AttackType="Throwing", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=225, Accuracy=93, AfterDelay=240, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Burst1"] = {Name="터트", MoveType="Attack", Target="AnEnemy", AttackType="Burst", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=15, Accuracy=99, AfterDelay=120, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Burst2"] = {Name="터트린", MoveType="Attack", Target="AnEnemy", AttackType="Burst", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=99, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Burst3"] = {Name="터트린다", MoveType="Attack", Target="AnEnemy", AttackType="Burst", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=99, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Burst1"] = {Name="마구 터트", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Burst", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=96, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Burst2"] = {Name="마구 터트린", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Burst", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=90, Accuracy=96, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["RandomAttack_Burst3"] = {Name="마구 터트린다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Burst", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=180, Accuracy=96, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Burst1"] = {Name="모드 터트", MoveType="Attack", Target="WholeEnemy", AttackType="Burst", AttackParameter=40, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=45, Accuracy=93, AfterDelay=180, DelayType="physicalSpeed"}
    SkillList["AllAttack_Burst2"] = {Name="모드 터트린", MoveType="Attack", Target="WholeEnemy", AttackType="Burst", AttackParameter=80, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=93, AfterDelay=210, DelayType="physicalSpeed"}
    SkillList["AllAttack_Burst3"] = {Name="모드 터트린다", MoveType="Attack", Target="WholeEnemy", AttackType="Burst", AttackParameter=120, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=225, Accuracy=93, AfterDelay=240, DelayType="physicalSpeed"}
    SkillList["SingleAttack_Fire1"] = {Name="타오", MoveType="Attack", Target="AnEnemy", AttackType="Fire", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=10, Accuracy=99, AfterDelay=120, DelayType="specialSpeed"}
    SkillList["SingleAttack_Fire2"] = {Name="타오른", MoveType="Attack", Target="AnEnemy", AttackType="Fire", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=99, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["SingleAttack_Fire3"] = {Name="타오른다", MoveType="Attack", Target="AnEnemy", AttackType="Fire", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=99, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Fire1"] = {Name="마구 타오", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Fire", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=20, Accuracy=96, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["RandomAttack_Fire2"] = {Name="마구 타오른", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Fire", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=96, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Fire3"] = {Name="마구 타오른다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Fire", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=96, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Fire1"] = {Name="모드 타오", MoveType="Attack", Target="WholeEnemy", AttackType="Fire", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=93, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["AllAttack_Fire2"] = {Name="모드 타오른", MoveType="Attack", Target="WholeEnemy", AttackType="Fire", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=80, Accuracy=93, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Fire3"] = {Name="모드 타오른다", MoveType="Attack", Target="WholeEnemy", AttackType="Fire", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=150, Accuracy=93, AfterDelay=240, DelayType="specialSpeed"}
    SkillList["SingleAttack_Water1"] = {Name="비가", MoveType="Attack", Target="AnEnemy", AttackType="Water", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=10, Accuracy=99, AfterDelay=120, DelayType="specialSpeed"}
    SkillList["SingleAttack_Water2"] = {Name="비가온", MoveType="Attack", Target="AnEnemy", AttackType="Water", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=99, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["SingleAttack_Water3"] = {Name="비가온다", MoveType="Attack", Target="AnEnemy", AttackType="Water", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=99, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Water1"] = {Name="마구 비가", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Water", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=20, Accuracy=96, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["RandomAttack_Water2"] = {Name="마구 비가온", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Water", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=96, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Water3"] = {Name="마구 비가온다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Water", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=96, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Water1"] = {Name="모드 비가", MoveType="Attack", Target="WholeEnemy", AttackType="Water", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=93, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["AllAttack_Water2"] = {Name="모드 비가온", MoveType="Attack", Target="WholeEnemy", AttackType="Water", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=80, Accuracy=93, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Water3"] = {Name="모드 비가온다", MoveType="Attack", Target="WholeEnemy", AttackType="Water", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=150, Accuracy=93, AfterDelay=240, DelayType="specialSpeed"}
    SkillList["SingleAttack_Ice1"] = {Name="누니", MoveType="Attack", Target="AnEnemy", AttackType="Ice", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=10, Accuracy=99, AfterDelay=120, DelayType="specialSpeed"}
    SkillList["SingleAttack_Ice2"] = {Name="누니온", MoveType="Attack", Target="AnEnemy", AttackType="Ice", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=99, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["SingleAttack_Ice3"] = {Name="누니온다", MoveType="Attack", Target="AnEnemy", AttackType="Ice", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=99, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Ice1"] = {Name="마구 누니", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Ice", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=20, Accuracy=96, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["RandomAttack_Ice2"] = {Name="마구 누니온", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Ice", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=96, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Ice3"] = {Name="마구 누니온다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Ice", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=96, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Ice1"] = {Name="모드 누니", MoveType="Attack", Target="WholeEnemy", AttackType="Ice", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=93, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["AllAttack_Ice2"] = {Name="모드 누니온", MoveType="Attack", Target="WholeEnemy", AttackType="Ice", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=80, Accuracy=93, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Ice3"] = {Name="모드 누니온다", MoveType="Attack", Target="WholeEnemy", AttackType="Ice", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=150, Accuracy=93, AfterDelay=240, DelayType="specialSpeed"}
    SkillList["SingleAttack_Grass1"] = {Name="자라", MoveType="Attack", Target="AnEnemy", AttackType="Grass", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=10, Accuracy=99, AfterDelay=120, DelayType="specialSpeed"}
    SkillList["SingleAttack_Grass2"] = {Name="자라난", MoveType="Attack", Target="AnEnemy", AttackType="Grass", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=99, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["SingleAttack_Grass3"] = {Name="자라난다", MoveType="Attack", Target="AnEnemy", AttackType="Grass", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=99, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Grass1"] = {Name="마구 자라", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Grass", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=20, Accuracy=96, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["RandomAttack_Grass2"] = {Name="마구 자라난", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Grass", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=96, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Grass3"] = {Name="마구 자라난다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Grass", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=96, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Grass1"] = {Name="모드 자라", MoveType="Attack", Target="WholeEnemy", AttackType="Grass", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=93, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["AllAttack_Grass2"] = {Name="모드 자라난", MoveType="Attack", Target="WholeEnemy", AttackType="Grass", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=80, Accuracy=93, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Grass3"] = {Name="모드 자라난다", MoveType="Attack", Target="WholeEnemy", AttackType="Grass", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=150, Accuracy=93, AfterDelay=240, DelayType="specialSpeed"}
    SkillList["SingleAttack_Wind1"] = {Name="모라", MoveType="Attack", Target="AnEnemy", AttackType="Wind", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=10, Accuracy=99, AfterDelay=120, DelayType="specialSpeed"}
    SkillList["SingleAttack_Wind2"] = {Name="모라친", MoveType="Attack", Target="AnEnemy", AttackType="Wind", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=99, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["SingleAttack_Wind3"] = {Name="모라친다", MoveType="Attack", Target="AnEnemy", AttackType="Wind", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=99, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Wind1"] = {Name="마구 모라", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Wind", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=20, Accuracy=96, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["RandomAttack_Wind2"] = {Name="마구 모라친", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Wind", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=96, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Wind3"] = {Name="마구 모라친다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Wind", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=96, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Wind1"] = {Name="모드 모라", MoveType="Attack", Target="WholeEnemy", AttackType="Wind", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=93, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["AllAttack_Wind2"] = {Name="모드 모라친", MoveType="Attack", Target="WholeEnemy", AttackType="Wind", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=80, Accuracy=93, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Wind3"] = {Name="모드 모라친다", MoveType="Attack", Target="WholeEnemy", AttackType="Wind", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=150, Accuracy=93, AfterDelay=240, DelayType="specialSpeed"}
    SkillList["SingleAttack_Electric1"] = {Name="파지", MoveType="Attack", Target="AnEnemy", AttackType="Electric", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=10, Accuracy=99, AfterDelay=120, DelayType="specialSpeed"}
    SkillList["SingleAttack_Electric2"] = {Name="파지긴", MoveType="Attack", Target="AnEnemy", AttackType="Electric", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=99, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["SingleAttack_Electric3"] = {Name="파지긴다", MoveType="Attack", Target="AnEnemy", AttackType="Electric", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=99, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Electric1"] = {Name="마구 파지", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Electric", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=20, Accuracy=96, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["RandomAttack_Electric2"] = {Name="마구 파지긴", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Electric", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=96, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Electric3"] = {Name="마구 파지긴다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Electric", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=96, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Electric1"] = {Name="모드 파지", MoveType="Attack", Target="WholeEnemy", AttackType="Electric", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=93, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["AllAttack_Electric2"] = {Name="모드 파지긴", MoveType="Attack", Target="WholeEnemy", AttackType="Electric", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=80, Accuracy=93, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Electric3"] = {Name="모드 파지긴다", MoveType="Attack", Target="WholeEnemy", AttackType="Electric", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=150, Accuracy=93, AfterDelay=240, DelayType="specialSpeed"}
    SkillList["SingleAttack_Ground1"] = {Name="흔들", MoveType="Attack", Target="AnEnemy", AttackType="Ground", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=10, Accuracy=99, AfterDelay=120, DelayType="specialSpeed"}
    SkillList["SingleAttack_Ground2"] = {Name="흔들린", MoveType="Attack", Target="AnEnemy", AttackType="Ground", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=99, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["SingleAttack_Ground3"] = {Name="흔들린다", MoveType="Attack", Target="AnEnemy", AttackType="Ground", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=99, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Ground1"] = {Name="마구 흔들", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Ground", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=20, Accuracy=96, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["RandomAttack_Ground2"] = {Name="마구 흔들린", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Ground", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=60, Accuracy=96, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["RandomAttack_Ground3"] = {Name="마구 흔들린다", MoveType="Attack", Target="PWREnemies", minTarget=2, maxTarget=5, AttackType="Ground", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=120, Accuracy=96, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Ground1"] = {Name="모드 흔들", MoveType="Attack", Target="WholeEnemy", AttackType="Ground", AttackParameter=40, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=30, Accuracy=93, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["AllAttack_Ground2"] = {Name="모드 흔들린", MoveType="Attack", Target="WholeEnemy", AttackType="Ground", AttackParameter=80, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=80, Accuracy=93, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllAttack_Ground3"] = {Name="모드 흔들린다", MoveType="Attack", Target="WholeEnemy", AttackType="Ground", AttackParameter=120, AttackerParameter="specialAttack", TargetParameter="specialDefense", DamageCalculationType="Basic", ResourceType="Mana", ResourceAmount=150, Accuracy=93, AfterDelay=240, DelayType="specialSpeed"}
    SkillList["CollateralAttack_Slash"] = {Name="범위 참격", MoveType="Attack", Target="AdjacentEnemies", AttackType="Slash", AttackParameter=90, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", ResourceType="Rage", ResourceAmount=12, Accuracy=98, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["CollateralAttack_Strike"] = {Name="범위 타격", MoveType="Attack", Target="AdjacentEnemies", AttackType="Strike", AttackParameter=90, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", ResourceType="Rage", ResourceAmount=12, Accuracy=98, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["CollateralAttack_Pierce"] = {Name="범위 관통", MoveType="Attack", Target="AdjacentEnemies", AttackType="Pierce", AttackParameter=90, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", ResourceType="Rage", ResourceAmount=12, Accuracy=98, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["CollateralAttack_Bite"] = {Name="범위 저작", MoveType="Attack", Target="AdjacentEnemies", AttackType="Bite", AttackParameter=90, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", ResourceType="Rage", ResourceAmount=12, Accuracy=98, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["CollateralAttack_Bullet"] = {Name="범위 사격", MoveType="Attack", Target="AdjacentEnemies", AttackType="Bullet", AttackParameter=90, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", ResourceType="Rage", ResourceAmount=12, Accuracy=98, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["CollateralAttack_Throwing"] = {Name="범위 투척", MoveType="Attack", Target="AdjacentEnemies", AttackType="Throwing", AttackParameter=90, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", ResourceType="Rage", ResourceAmount=12, Accuracy=98, AfterDelay=150, DelayType="physicalSpeed"}
    SkillList["CollateralAttack_Burst"] = {Name="범위 충격", MoveType="Attack", Target="AdjacentEnemies", AttackType="Burst", AttackParameter=90, AttackerParameter="physicalAttack", TargetParameter="physicalDefense", ResourceType="Rage", ResourceAmount=12, Accuracy=98, AfterDelay=150, DelayType="physicalSpeed"}

    SkillList["SingleHeal_Basic1"] = {Name="나아", MoveType="Heal", Target="AnAlly", ResourceType="Mana", ResourceAmount=20, AfterDelay=120, DelayType="specialSpeed"}
    SkillList["SingleHeal_Basic2"] = {Name="나아간", MoveType="Heal", Target="AnAlly", ResourceType="Mana", ResourceAmount=60, AfterDelay=150, DelayType="specialSpeed"}
    SkillList["SingleHeal_Basic3"] = {Name="나아간다", MoveType="Heal", Target="AnAlly", ResourceType="Mana", ResourceAmount=120, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["AllHeal_Basic1"] = {Name="가치 나아", MoveType="Heal", Target="WholeAlly", ResourceType="Mana", ResourceAmount=60, AfterDelay=180, DelayType="specialSpeed"}
    SkillList["AllHeal_Basic2"] = {Name="가치 나아간", MoveType="Heal", Target="WholeAlly", ResourceType="Mana", ResourceAmount=120, AfterDelay=210, DelayType="specialSpeed"}
    SkillList["AllHeal_Basic3"] = {Name="가치 나아간다", MoveType="Heal", Target="WholeAlly", ResourceType="Mana", ResourceAmount=300, AfterDelay=240, DelayType="specialSpeed"}

  // Skills End
#end