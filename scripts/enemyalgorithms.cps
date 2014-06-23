#function enemyalgorithms

  function randomlyattacktargetwithskills(self, party, enemyparty)
      local targets = {}
      targets = pickrandomtarget(party, 1)
      if (math.random(1,2) == 1) and (#self.skills > 0) then
        if targets then skillhandler(self, SkillList[self.attackType], targets) end
        return SkillList[self.attackType]
      else
        local usedskill = self.skills[math.random(#self.skills)]
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