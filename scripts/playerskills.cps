#function playerskills
  PlayerSkillList = {}
  PlayerSkillHelper = {}

  function PlayerSkillHelper.GetSkillsByTag(tag)
    local skillkeys = {}

    for k, v in pairs(PlayerSkillList) do
      if v.Tag[tag] then
        table.insert(skillkeys, k)
      end
    end
    return skillkeys
  end

  function PlayerSkillHelper.GetUnlockedSkillsByTag(tag)
    local allskills = PlayerSkillHelper.GetSkillsByTag(tag)
    local skillkeys = {}
    for _, v in ipairs(allskills) do
      if player.skills[v] then
        table.insert(skillkeys, v)
      end
    end
    return skillkeys
  end

  PlayerSkillList["journeytype_usual"] = {
    Name = "일반 이동",
    Description = "특정 지점에서 다른 지점까지 이동이 가능합니다.",
    Category = "Journey",
    Tag = {Journey = true, JourneyType = true, Default = true},
    JourneyType = {DesignatedNo = 1, Key = "usual", Desc = "일반 이동", Guide = "다른 /fr적대적/x, /fg비적대적/x 존재와 조우할 가능성이 높습니다."}
  }

  PlayerSkillList["journeytype_loot"] = {
    Name = "수집 이동",
    Description = "이동할 때 아이템을 획득할 가능성을 높여주는 수집 이동이 가능해집니다.",
    Category = "Journey",
    Tag = {Journey = true, JourneyType = true, Loot = true},
    JourneyType = {DesignatedNo = 2, Key = "loot", Desc = "수집 이동", Guide = "/fy아이템/x을 찾으며 이동합니다. /fb진행도/x가 느리게 증가합니다."}
  }
  PlayerSkillList["journeytype_alert"] = {
    Name = "경계 이동",
    Description = "적에게 발각될 가능성을 줄이는 경계 이동이 가능해집니다.",
    Category = "Journey",
    Tag = {Journey = true, JourneyType = true, Encounter = true, EnemyEncounter = true},
    JourneyType = {DesignatedNo = 3, Key = "alert", Desc = "경계 이동", Guide = "/fr적대적/x인 존재에게 발각되지 않게 이동합니다. /fb진행도/x가 느리게 증가합니다."}
  }
  PlayerSkillList["journeytype_explore"] = {
    Name = "탐험 이동",
    Description = "새로운 장소와 이벤트를 마주칠 가능성을 높여주는 탐험 이동이 가능해집니다.",
    Category = "Journey",
    Tag = {Journey = true, JourneyType = true, Explore = true},
    JourneyType = {DesignatedNo = 4, Key = "explore", Desc = "탐험 이동", Guide = "/fc새로운 장소/x가 있는지 신경쓰며 이동합니다. /fm이벤트/x가 발생할 가능성도 늘어납니다."}
  }
  PlayerSkillList["journeytype_hurry"] = {
    Name = "서둘러 이동",
    Description = "목적지에 도달하는 것에 전념하는 서둘러 이동이 가능해집니다.",
    Category = "Journey",
    Tag = {Journey = true, JourneyType = true},
    JourneyType = {DesignatedNo = 5, Key = "hurry", Desc = "서둘러 이동", Guide = "/fb진행도/x가 빠르게 증가하지만, /fr적대적/x인 존재에게 발각될 가능성도 증가합니다."}
  }
#end