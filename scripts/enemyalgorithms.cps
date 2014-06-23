#function enemyalgorithms
  function pickpropertarget(skill, self, party, enemyparty)
    local targets = {}
    if skill.MoveType == "Attack" then
      if skill.Target == "AnEnemy" then
        targets = pickrandomtarget(party, 1)
      elseif skill.Target == "WholeEnemy" then
        for k, v in pairs(party) do
          if party[k].alive then table.insert(targets, party[k]) end
        end
      elseif skill.Target == "RandomEnemies" then
        local numTarget = math.random(skill.minTarget, skill.maxTarget)
        for k, v in pairs(pickrandomtarget(opponents, numTarget)) do
          table.insert(targets, v)
        end
      elseif skill.Target == "PWREnemies" then
        local numTarget = math.random(skill.minTarget, skill.maxTarget)
        local first, second = unpack(pickrandomtarget(opponents, 2))
        second = second or first
        table.insert(targets, first)
        table.insert(targets, second)
        for i = 3, numTarget do
          if i <= numTarget then table.insert(targets, unpack(pickrandomtarget(opponents, 1))) end
        end
      elseif skill.Target == "Self" then
        table.insert(targets, self)
      elseif skill.Target == "AnAlly" then
        table.insert(targets, enemyparty[math.random(#enemyparty)])
      elseif skill.Target == "WholeEnemy" then
        for k, v in pairs(enemyparty) do
          if enemyparty[k].alive then table.insert(targets, enemyparty[k]) end
        end
      end
    end
    return targets
  end
  function randomlyattacktargetwithskills(self, party, enemyparty)
      local targets = {}
      
      if (math.random(1,2) == 1) or (#self.skills == 0) then
        targets = pickrandomtarget(party, 1)
        if targets then skillhandler(self, SkillList[self.attackType], targets) end
        return SkillList[self.attackType]
      else
        local usedskill = self.skills[math.random(#self.skills)]
        targets = pickpropertarget(usedskill, self, party, enemyparty)
        if targets then skillhandler(self, usedskill, targets) end
        return usedskill
      end
    end  

  function randomlyattacktargetwithbasicattack(self, party, enemyparty)
    local targets = {}
    targets = pickrandomtarget(party, 1)
    if targets then skillhandler(self, SkillList[self.attackType], targets) end
    return SkillList[self.attackType]
  end

#end