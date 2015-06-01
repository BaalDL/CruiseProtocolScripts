#function ephemerallist

  ephemerallist = {}

  ephemerallist["burn"] = {}
  ephemerallist["burn"][1] = {
    name = "화상",
    display = "/bR/fY火/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "의 몸을 화염이 덮친다!"
    end,
    diminishMessage = function(char)
      return char.name .. "의 화상이 사라졌다!"
    end,
    atcountturn = function(char, battle)
      message = message .. "\n화상의 피해가 " .. char.name .. "(을)를 덮친다!"
      inflictdamage(nil, SkillList["SystemBurnDamage"], char, battle, nil)
    end
  }
  ephemerallist["burn"][-1] = {
    display = "/bR/fY火無/x",
    dlength = 4
  }

  ephemerallist["frozen"] = {}
  ephemerallist["frozen"][1] = {
    name = "동상",
    display = "/bB/fW凍/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "의 몸 곳곳이 얼어붙는다!"
    end,
    diminishMessage = function(char)
      return char.name .. "의 동상이 사라졌다!"
    end
  }
  ephemerallist["frozen"][-1] = {
    display = "/bB/fW凍無/x",
    dlength = 4
  }

  ephemerallist["sleep"] = {}
  ephemerallist["sleep"][1] = {
    name = "졸음",
    display = "/bG/fBzZ/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "의 의식이 멀어진다…."
    end,
    diminishMessage = function(char)
      return char.name .. "(은)는 졸음에서 깨어났다!"
    end,
    atcheckcontrollable = function(char, battle)
      message = message .. "\n" .. char.name .. "(은)는 졸고 있다…."
      return false
    end
  }
  ephemerallist["sleep"][-1] = {
    display = "/bG/fBzZ無/x",
    dlength = 4
  }  

  ephemerallist["paralyzed"] = {}
  ephemerallist["paralyzed"][1] = {
    name = "마비",
    display = "/bY/fw痲/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "의 몸 곳곳이 뻣뻣해진다!"
    end,
    diminishMessage = function(char)
      return char.name .. "의 마비가 풀렸다!"
    end,
    atcheckcontrollable = function(char, battle)
      if math.random(10) <= 3 then
        message = message .. "\n" .. char.name .. "(이)가 예상치 못하게 몸이 저려온다!"
        return false
      else
        message = message .. "\n" .. char.name .. "(은)는 간신히 몸을 가누었다!"
        return true
      end
    end
  }
  ephemerallist["paralyzed"][-1] = {
    display = "/bY/fw痲無/x",
    dlength = 4
  }  

  ephemerallist["stoned"] = {}
  ephemerallist["stoned"][1] = {
    name = "석화",
    display = "/bM/fY石/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "의 몸 일부분이 굳는다!"
    end,
    diminishMessage = function(char)
      return char.name .. "(이)가 석화에서 자유로워졌다!"
    end
  }
  ephemerallist["stoned"][-1] = {
    display = "/bM/fY石無/x",
    dlength = 4
  }  

  ephemerallist["blind"] = {}
  ephemerallist["blind"][1] = {
    name = "실명",
    display = "/bw/fk盲/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "의 눈 앞이 깜깜해진다!"
    end,
    diminishMessage = function(char)
      return char.name .. "의 실명이 나았다!"
    end
  }
  ephemerallist["blind"][-1] = {
    display = "/bw/fk盲無/x",
    dlength = 4
  }  

  ephemerallist["cursed"] = {}
  ephemerallist["cursed"][1] = {
    name = "저주",
    display = "/bk/fw呪/x",
    dlength = 2,
    acquireMessage = function(char)
      return char.name .. "(은)는 저주받았다!"
    end,
    diminishMessage = function(char)
      return char.name .. "의 저주가 풀렸다!"
    end,
    atcountturn = function(char, battle)
      message = message .. "\n저주가 " .. char.name .. "(을)를 덮친다!"
      inflictdamage(nil, SkillList["SystemCurseDamage"], char, battle, nil)
    end
  }
  ephemerallist["cursed"][-1] = {
    display = "/bk/fw呪無/x",
    dlength = 4
  }  

  ephemerallist["manadepletion"] = {}
  ephemerallist["manadepletion"][1] = {
    name = "마나 고갈",
    display = "/bk/fR魔/x",
    dlength = 2,
    diminishMessage = function(char)
      return char.name .. "의 주변에 다시 마나가 감돈다!"
    end
  }

  function ephemeraldisplaywithrank(string, rank)
    local colorstring
    local arrow
    if 1 <= rank and rank <= 3 then
      colorstring = "/bR/fw"
      arrow = "△"
    elseif 4 <= rank then
      colorstring = "/br/fw"
      arrow = "△"
    elseif -3 <= rank and rank <= -1 then
      colorstring = "/bB/fw"
      arrow = "▽"
    elseif rank <= -4 then
      colorstring = "/bb/fw"
      arrow = "▽"
    end
    return colorstring .. string .. arrow .. "/x" .. math.abs(rank)
  end

  ephemerallist["pAup"] = {}
  ephemerallist["pAup"][1] = {name = "공격력 증가", display = ephemeraldisplaywithrank("攻", 1),dlength = 5,atgetparam = {param = "physicalAttack",amount = 1.5}}
  ephemerallist["pAup"][2] = {name = "공격력 증가", display = ephemeraldisplaywithrank("攻", 2),dlength = 5,atgetparam = {param = "physicalAttack",amount = 2}}
  ephemerallist["pAup"][3] = {name = "공격력 증가", display = ephemeraldisplaywithrank("攻", 3),dlength = 5,atgetparam = {param = "physicalAttack",amount = 2.5}}
  ephemerallist["pAup"][4] = {name = "공격력 증가", display = ephemeraldisplaywithrank("攻", 4),dlength = 5,atgetparam = {param = "physicalAttack",amount = 3}}
  ephemerallist["pAup"][5] = {name = "공격력 증가", display = ephemeraldisplaywithrank("攻", 5),dlength = 5,atgetparam = {param = "physicalAttack",amount = 3.5}}
  ephemerallist["pAup"][6] = {name = "공격력 증가", display = ephemeraldisplaywithrank("攻", 6),dlength = 5,atgetparam = {param = "physicalAttack",amount = 4}}

  ephemerallist["pAdn"] = {}
  ephemerallist["pAdn"][1] = {name = "공격력 감소", display = ephemeraldisplaywithrank("攻", -1),dlength = 5,atgetparam = {param = "physicalAttack",amount = 0.66}}
  ephemerallist["pAdn"][2] = {name = "공격력 감소", display = ephemeraldisplaywithrank("攻", -2),dlength = 5,atgetparam = {param = "physicalAttack",amount = 0.5}}
  ephemerallist["pAdn"][3] = {name = "공격력 감소", display = ephemeraldisplaywithrank("攻", -3),dlength = 5,atgetparam = {param = "physicalAttack",amount = 0.4}}
  ephemerallist["pAdn"][4] = {name = "공격력 감소", display = ephemeraldisplaywithrank("攻", -4),dlength = 5,atgetparam = {param = "physicalAttack",amount = 0.33}}
  ephemerallist["pAdn"][5] = {name = "공격력 감소", display = ephemeraldisplaywithrank("攻", -5),dlength = 5,atgetparam = {param = "physicalAttack",amount = 0.29}}
  ephemerallist["pAdn"][6] = {name = "공격력 감소", display = ephemeraldisplaywithrank("攻", -6),dlength = 5,atgetparam = {param = "physicalAttack",amount = 0.25}}

  ephemerallist["pDup"] = {}
  ephemerallist["pDup"][1] = {name = "방어력 증가", display = ephemeraldisplaywithrank("防", 1),dlength = 5,atgetparam = {param = "physicalDefense",amount = 1.5}}
  ephemerallist["pDup"][2] = {name = "방어력 증가", display = ephemeraldisplaywithrank("防", 2),dlength = 5,atgetparam = {param = "physicalDefense",amount = 2}}
  ephemerallist["pDup"][3] = {name = "방어력 증가", display = ephemeraldisplaywithrank("防", 3),dlength = 5,atgetparam = {param = "physicalDefense",amount = 2.5}}
  ephemerallist["pDup"][4] = {name = "방어력 증가", display = ephemeraldisplaywithrank("防", 4),dlength = 5,atgetparam = {param = "physicalDefense",amount = 3}}
  ephemerallist["pDup"][5] = {name = "방어력 증가", display = ephemeraldisplaywithrank("防", 5),dlength = 5,atgetparam = {param = "physicalDefense",amount = 3.5}}
  ephemerallist["pDup"][6] = {name = "방어력 증가", display = ephemeraldisplaywithrank("防", 6),dlength = 5,atgetparam = {param = "physicalDefense",amount = 4}}

  ephemerallist["pDdn"] = {}
  ephemerallist["pDdn"][1] = {name = "방어력 감소", display = ephemeraldisplaywithrank("防", -1),dlength = 5,atgetparam = {param = "physicalDefense",amount = 0.66}}
  ephemerallist["pDdn"][2] = {name = "방어력 감소", display = ephemeraldisplaywithrank("防", -2),dlength = 5,atgetparam = {param = "physicalDefense",amount = 0.5}}
  ephemerallist["pDdn"][3] = {name = "방어력 감소", display = ephemeraldisplaywithrank("防", -3),dlength = 5,atgetparam = {param = "physicalDefense",amount = 0.4}}
  ephemerallist["pDdn"][4] = {name = "방어력 감소", display = ephemeraldisplaywithrank("防", -4),dlength = 5,atgetparam = {param = "physicalDefense",amount = 0.33}}
  ephemerallist["pDdn"][5] = {name = "방어력 감소", display = ephemeraldisplaywithrank("防", -5),dlength = 5,atgetparam = {param = "physicalDefense",amount = 0.29}}
  ephemerallist["pDdn"][6] = {name = "방어력 감소", display = ephemeraldisplaywithrank("防", -6),dlength = 5,atgetparam = {param = "physicalDefense",amount = 0.25}}

  ephemerallist["pSup"] = {}
  ephemerallist["pSup"][1] = {name = "물리속도 증가", display = ephemeraldisplaywithrank("敏", 1),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 1.5}}
  ephemerallist["pSup"][2] = {name = "물리속도 증가", display = ephemeraldisplaywithrank("敏", 2),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 2}}
  ephemerallist["pSup"][3] = {name = "물리속도 증가", display = ephemeraldisplaywithrank("敏", 3),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 2.5}}
  ephemerallist["pSup"][4] = {name = "물리속도 증가", display = ephemeraldisplaywithrank("敏", 4),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 3}}
  ephemerallist["pSup"][5] = {name = "물리속도 증가", display = ephemeraldisplaywithrank("敏", 5),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 3.5}}
  ephemerallist["pSup"][6] = {name = "물리속도 증가", display = ephemeraldisplaywithrank("敏", 6),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 4}}

  ephemerallist["pSdn"] = {}
  ephemerallist["pSdn"][1] = {name = "물리속도 감소", display = ephemeraldisplaywithrank("敏", -1),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 0.66}}
  ephemerallist["pSdn"][2] = {name = "물리속도 감소", display = ephemeraldisplaywithrank("敏", -2),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 0.5}}
  ephemerallist["pSdn"][3] = {name = "물리속도 감소", display = ephemeraldisplaywithrank("敏", -3),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 0.4}}
  ephemerallist["pSdn"][4] = {name = "물리속도 감소", display = ephemeraldisplaywithrank("敏", -4),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 0.33}}
  ephemerallist["pSdn"][5] = {name = "물리속도 감소", display = ephemeraldisplaywithrank("敏", -5),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 0.29}}
  ephemerallist["pSdn"][6] = {name = "물리속도 감소", display = ephemeraldisplaywithrank("敏", -6),dlength = 5,atgetparam = {param = "physicalSpeed",amount = 0.25}}

  ephemerallist["sAup"] = {}
  ephemerallist["sAup"][1] = {name = "특수공격력 증가", display = ephemeraldisplaywithrank("特", 1),dlength = 5,atgetparam = {param = "specialAttack",amount = 1.5}}
  ephemerallist["sAup"][2] = {name = "특수공격력 증가", display = ephemeraldisplaywithrank("特", 2),dlength = 5,atgetparam = {param = "specialAttack",amount = 2}}
  ephemerallist["sAup"][3] = {name = "특수공격력 증가", display = ephemeraldisplaywithrank("特", 3),dlength = 5,atgetparam = {param = "specialAttack",amount = 2.5}}
  ephemerallist["sAup"][4] = {name = "특수공격력 증가", display = ephemeraldisplaywithrank("特", 4),dlength = 5,atgetparam = {param = "specialAttack",amount = 3}}
  ephemerallist["sAup"][5] = {name = "특수공격력 증가", display = ephemeraldisplaywithrank("特", 5),dlength = 5,atgetparam = {param = "specialAttack",amount = 3.5}}
  ephemerallist["sAup"][6] = {name = "특수공격력 증가", display = ephemeraldisplaywithrank("特", 6),dlength = 5,atgetparam = {param = "specialAttack",amount = 4}}

  ephemerallist["sAdn"] = {}
  ephemerallist["sAdn"][1] = {name = "특수공격력 감소", display = ephemeraldisplaywithrank("特", -1),dlength = 5,atgetparam = {param = "specialAttack",amount = 0.66}}
  ephemerallist["sAdn"][2] = {name = "특수공격력 감소", display = ephemeraldisplaywithrank("特", -2),dlength = 5,atgetparam = {param = "specialAttack",amount = 0.5}}
  ephemerallist["sAdn"][3] = {name = "특수공격력 감소", display = ephemeraldisplaywithrank("特", -3),dlength = 5,atgetparam = {param = "specialAttack",amount = 0.4}}
  ephemerallist["sAdn"][4] = {name = "특수공격력 감소", display = ephemeraldisplaywithrank("特", -4),dlength = 5,atgetparam = {param = "specialAttack",amount = 0.33}}
  ephemerallist["sAdn"][5] = {name = "특수공격력 감소", display = ephemeraldisplaywithrank("特", -5),dlength = 5,atgetparam = {param = "specialAttack",amount = 0.29}}
  ephemerallist["sAdn"][6] = {name = "특수공격력 감소", display = ephemeraldisplaywithrank("特", -6),dlength = 5,atgetparam = {param = "specialAttack",amount = 0.25}}

  ephemerallist["sDup"] = {}
  ephemerallist["sDup"][1] = {name = "특수방어력 증가", display = ephemeraldisplaywithrank("護", 1),dlength = 5,atgetparam = {param = "specialDefense",amount = 1.5}}
  ephemerallist["sDup"][2] = {name = "특수방어력 증가", display = ephemeraldisplaywithrank("護", 2),dlength = 5,atgetparam = {param = "specialDefense",amount = 2}}
  ephemerallist["sDup"][3] = {name = "특수방어력 증가", display = ephemeraldisplaywithrank("護", 3),dlength = 5,atgetparam = {param = "specialDefense",amount = 2.5}}
  ephemerallist["sDup"][4] = {name = "특수방어력 증가", display = ephemeraldisplaywithrank("護", 4),dlength = 5,atgetparam = {param = "specialDefense",amount = 3}}
  ephemerallist["sDup"][5] = {name = "특수방어력 증가", display = ephemeraldisplaywithrank("護", 5),dlength = 5,atgetparam = {param = "specialDefense",amount = 3.5}}
  ephemerallist["sDup"][6] = {name = "특수방어력 증가", display = ephemeraldisplaywithrank("護", 6),dlength = 5,atgetparam = {param = "specialDefense",amount = 4}}

  ephemerallist["sDdn"] = {}
  ephemerallist["sDdn"][1] = {name = "특수방어력 감소", display = ephemeraldisplaywithrank("護", -1),dlength = 5,atgetparam = {param = "specialDefense",amount = 0.66}}
  ephemerallist["sDdn"][2] = {name = "특수방어력 감소", display = ephemeraldisplaywithrank("護", -2),dlength = 5,atgetparam = {param = "specialDefense",amount = 0.5}}
  ephemerallist["sDdn"][3] = {name = "특수방어력 감소", display = ephemeraldisplaywithrank("護", -3),dlength = 5,atgetparam = {param = "specialDefense",amount = 0.4}}
  ephemerallist["sDdn"][4] = {name = "특수방어력 감소", display = ephemeraldisplaywithrank("護", -4),dlength = 5,atgetparam = {param = "specialDefense",amount = 0.33}}
  ephemerallist["sDdn"][5] = {name = "특수방어력 감소", display = ephemeraldisplaywithrank("護", -5),dlength = 5,atgetparam = {param = "specialDefense",amount = 0.29}}
  ephemerallist["sDdn"][6] = {name = "특수방어력 감소", display = ephemeraldisplaywithrank("護", -6),dlength = 5,atgetparam = {param = "specialDefense",amount = 0.25}}

  ephemerallist["sSup"] = {}
  ephemerallist["sSup"][1] = {name = "특수속도 증가", display = ephemeraldisplaywithrank("迅", 1),dlength = 5,atgetparam = {param = "specialSpeed",amount = 1.5}}
  ephemerallist["sSup"][2] = {name = "특수속도 증가", display = ephemeraldisplaywithrank("迅", 2),dlength = 5,atgetparam = {param = "specialSpeed",amount = 2}}
  ephemerallist["sSup"][3] = {name = "특수속도 증가", display = ephemeraldisplaywithrank("迅", 3),dlength = 5,atgetparam = {param = "specialSpeed",amount = 2.5}}
  ephemerallist["sSup"][4] = {name = "특수속도 증가", display = ephemeraldisplaywithrank("迅", 4),dlength = 5,atgetparam = {param = "specialSpeed",amount = 3}}
  ephemerallist["sSup"][5] = {name = "특수속도 증가", display = ephemeraldisplaywithrank("迅", 5),dlength = 5,atgetparam = {param = "specialSpeed",amount = 3.5}}
  ephemerallist["sSup"][6] = {name = "특수속도 증가", display = ephemeraldisplaywithrank("迅", 6),dlength = 5,atgetparam = {param = "specialSpeed",amount = 4}}

  ephemerallist["sSdn"] = {}
  ephemerallist["sSdn"][1] = {name = "특수속도 감소", display = ephemeraldisplaywithrank("迅", -1),dlength = 5,atgetparam = {param = "specialSpeed",amount = 0.66}}
  ephemerallist["sSdn"][2] = {name = "특수속도 감소", display = ephemeraldisplaywithrank("迅", -2),dlength = 5,atgetparam = {param = "specialSpeed",amount = 0.5}}
  ephemerallist["sSdn"][3] = {name = "특수속도 감소", display = ephemeraldisplaywithrank("迅", -3),dlength = 5,atgetparam = {param = "specialSpeed",amount = 0.4}}
  ephemerallist["sSdn"][4] = {name = "특수속도 감소", display = ephemeraldisplaywithrank("迅", -4),dlength = 5,atgetparam = {param = "specialSpeed",amount = 0.33}}
  ephemerallist["sSdn"][5] = {name = "특수속도 감소", display = ephemeraldisplaywithrank("迅", -5),dlength = 5,atgetparam = {param = "specialSpeed",amount = 0.29}}
  ephemerallist["sSdn"][6] = {name = "특수속도 감소", display = ephemeraldisplaywithrank("迅", -6),dlength = 5,atgetparam = {param = "specialSpeed",amount = 0.25}}

  ephemerallist["Acup"] = {}
  ephemerallist["Acup"][1] = {name = "명중률 증가", display = ephemeraldisplaywithrank("命", 1),dlength = 5,atcheckhit = {param = "Accuracy",amount = 1.33}}
  ephemerallist["Acup"][2] = {name = "명중률 증가", display = ephemeraldisplaywithrank("命", 2),dlength = 5,atcheckhit = {param = "Accuracy",amount = 1.66}}
  ephemerallist["Acup"][3] = {name = "명중률 증가", display = ephemeraldisplaywithrank("命", 3),dlength = 5,atcheckhit = {param = "Accuracy",amount = 2}}
  ephemerallist["Acup"][4] = {name = "명중률 증가", display = ephemeraldisplaywithrank("命", 4),dlength = 5,atcheckhit = {param = "Accuracy",amount = 2.33}}
  ephemerallist["Acup"][5] = {name = "명중률 증가", display = ephemeraldisplaywithrank("命", 5),dlength = 5,atcheckhit = {param = "Accuracy",amount = 2.66}}
  ephemerallist["Acup"][6] = {name = "명중률 증가", display = ephemeraldisplaywithrank("命", 6),dlength = 5,atcheckhit = {param = "Accuracy",amount = 3}}

  ephemerallist["Acdn"] = {}
  ephemerallist["Acdn"][1] = {name = "명중률 감소", display = ephemeraldisplaywithrank("命", -1),dlength = 5,atcheckhit = {param = "Accuracy",amount = 0.75}}
  ephemerallist["Acdn"][2] = {name = "명중률 감소", display = ephemeraldisplaywithrank("命", -2),dlength = 5,atcheckhit = {param = "Accuracy",amount = 0.6}}
  ephemerallist["Acdn"][3] = {name = "명중률 감소", display = ephemeraldisplaywithrank("命", -3),dlength = 5,atcheckhit = {param = "Accuracy",amount = 0.5}}
  ephemerallist["Acdn"][4] = {name = "명중률 감소", display = ephemeraldisplaywithrank("命", -4),dlength = 5,atcheckhit = {param = "Accuracy",amount = 0.43}}
  ephemerallist["Acdn"][5] = {name = "명중률 감소", display = ephemeraldisplaywithrank("命", -5),dlength = 5,atcheckhit = {param = "Accuracy",amount = 0.38}}
  ephemerallist["Acdn"][6] = {name = "명중률 감소", display = ephemeraldisplaywithrank("命", -6),dlength = 5,atcheckhit = {param = "Accuracy",amount = 0.33}}

  ephemerallist["Evup"] = {}
  ephemerallist["Evup"][1] = {name = "회피율 증가", display = ephemeraldisplaywithrank("避", 1),dlength = 5,atcheckhit = {param = "Evasion",amount = 1.33}}
  ephemerallist["Evup"][2] = {name = "회피율 증가", display = ephemeraldisplaywithrank("避", 2),dlength = 5,atcheckhit = {param = "Evasion",amount = 1.66}}
  ephemerallist["Evup"][3] = {name = "회피율 증가", display = ephemeraldisplaywithrank("避", 3),dlength = 5,atcheckhit = {param = "Evasion",amount = 2}}
  ephemerallist["Evup"][4] = {name = "회피율 증가", display = ephemeraldisplaywithrank("避", 4),dlength = 5,atcheckhit = {param = "Evasion",amount = 2.33}}
  ephemerallist["Evup"][5] = {name = "회피율 증가", display = ephemeraldisplaywithrank("避", 5),dlength = 5,atcheckhit = {param = "Evasion",amount = 2.66}}
  ephemerallist["Evup"][6] = {name = "회피율 증가", display = ephemeraldisplaywithrank("避", 6),dlength = 5,atcheckhit = {param = "Evasion",amount = 3}}

  ephemerallist["Evdn"] = {}
  ephemerallist["Evdn"][1] = {name = "회피율 감소", display = ephemeraldisplaywithrank("避", -1),dlength = 5,atcheckhit = {param = "Evasion",amount = 0.75}}
  ephemerallist["Evdn"][2] = {name = "회피율 감소", display = ephemeraldisplaywithrank("避", -2),dlength = 5,atcheckhit = {param = "Evasion",amount = 0.6}}
  ephemerallist["Evdn"][3] = {name = "회피율 감소", display = ephemeraldisplaywithrank("避", -3),dlength = 5,atcheckhit = {param = "Evasion",amount = 0.5}}
  ephemerallist["Evdn"][4] = {name = "회피율 감소", display = ephemeraldisplaywithrank("避", -4),dlength = 5,atcheckhit = {param = "Evasion",amount = 0.43}}
  ephemerallist["Evdn"][5] = {name = "회피율 감소", display = ephemeraldisplaywithrank("避", -5),dlength = 5,atcheckhit = {param = "Evasion",amount = 0.38}}
  ephemerallist["Evdn"][6] = {name = "회피율 감소", display = ephemeraldisplaywithrank("避", -6),dlength = 5,atcheckhit = {param = "Evasion",amount = 0.33}}
#end

#function applyephemerallist
  applyephemerallist = {}

  applyephemerallist["manadepletion"] = {ephemeral = "manadepletion"}
  
  applyephemerallist["standardburn"] = {ephemeral = "burn",rank = 1,minDuration = 2,maxDuration = 5}
  applyephemerallist["additionalburn"] = {ephemeral = "burn",rank = 1,probability = 10,minDuration = 1,maxDuration = 3}
  applyephemerallist["standardfrozen"] = {ephemeral = "frozen",rank = 1,minDuration = 2,maxDuration = 5}
  applyephemerallist["additionalfrozen"] = {ephemeral = "frozen",rank = 1,probability = 10,minDuration = 1,maxDuration = 3}
  applyephemerallist["standardsleep"] = {ephemeral = "sleep",rank = 1,minDuration = 2,maxDuration = 5}
  applyephemerallist["additionalsleep"] = {ephemeral = "sleep",rank = 1,probability = 10,minDuration = 1,maxDuration = 3}
  applyephemerallist["standardparalyzed"] = {ephemeral = "paralyzed",rank = 1,minDuration = 2,maxDuration = 5}
  applyephemerallist["additionalparalyzed"] = {ephemeral = "paralyzed",rank = 1,probability = 10,minDuration = 1,maxDuration = 3}
  applyephemerallist["standardstoned"] = {ephemeral = "stoned",rank = 1,minDuration = 2,maxDuration = 5}
  applyephemerallist["additionalstoned"] = {ephemeral = "stoned",rank = 1,probability = 10,minDuration = 1,maxDuration = 3}
  applyephemerallist["standardblind"] = {ephemeral = "blind",rank = 1,minDuration = 2,maxDuration = 5}
  applyephemerallist["additionalblind"] = {ephemeral = "blind",rank = 1,probability = 10,minDuration = 1,maxDuration = 3}
  applyephemerallist["standardcursed"] = {ephemeral = "cursed",rank = 1,minDuration = 2,maxDuration = 5}
  applyephemerallist["additionalcursed"] = {ephemeral = "cursed",rank = 1,probability = 10,minDuration = 1,maxDuration = 3}
#end