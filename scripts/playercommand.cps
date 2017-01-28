#function playercommand
  function playercommand(command, ...)
    local choices = command.commands
    for i, v in ipairs(command.references) do
      command.references[v] = arg[i]
    end
    local startaskt, startaskl = getc()
    local state = command:initial()
    while (state ~= "terminal") do
      if (state == "initial" and command.resetpositiononinitial) then
        local endaskt = getc()
        erase(startaskt, endaskt)
        moveto(startaskt, startaskl)
      end
      state = command[state](command)
    end
    return choices
  end

  battlecharactercommand = {}
  battlecharactercommand.references = {"char", "party", "enemyparty", "battle"}
  battlecharactercommand.returns = {"move", "targetType", "targets", "itemmove", "fleemove"}
  battlecharactercommand.commands = {}
  battlecharactercommand.resetpositiononinitial = true

  function battlecharactercommand:initial()
    self.commands.move = -1
    self.commands.targetType = ""
    self.commands.targets = {}
    self.commands.itemmove = -2
    self.commands.fleemove = -1
    local movelist = makemovelistinbattle(self.references.char, self.references.party, self.references.enemyparty, self.references.battle)
    self.commands.move = tonumber(ask("무엇을 하시겠습니까?", unpack(movelist)))

    if self.commands.move <= 8 and self.commands.move >= 0 then
      return "decidetarget"
    elseif self.commands.move == 10 then
      return "decideitem"
    elseif self.commands.move == 99 then
      return "flee"
    elseif self.commands.move == -1 then
      return "terminal"
    else
      return "initial"
    end
  end

  function battlecharactercommand:decidetarget()
    local movetype
    if self.commands.move <= 8 and self.commands.move >= 0 then
      movetype = self.references.char.skills[self.commands.move].MoveType
      self.commands.targetType = self.references.char.skills[self.commands.move].Target
    elseif self.commands.move == 10 then
      movetype = ItemList[itemmove].ItemType
      self.commands.targetType = ItemList[itemmove].Target
    end
    local selfnum = self.references.char.targetnumber

    local targetinput = lookuptarget(movetype, self.commands.targetType, selfnum)

    if (targetinput ~= "-1") then
      if (targetinput == "100") then
        self.commands.targets = self.references.enemyparty
      elseif (targetinput == "10") then
        self.commands.targets = self.references.party
      else
        self.commands.targets = {targettable[targetinput]}
      end
      if self.commands.move <= 8 and self.commands.move >= 0 then
        skillhandler(self.references.char, self.references.char.skills[self.commands.move], self.commands.targets, self.references.battle)
      elseif self.commands.move == 10 then
        itemhandler(self.references.char, self.commands.itemmove, self.commands.targets, self.references.battle)
      end
    end

    if targetinput == "-1" then
      return "initial"
    else
      return "terminal"
    end
  end

  function battlecharactercommand:decideitem()
    self.commands.itemmove = inventorymenu("battle")

    if self.commands.itemmove == -1 then
      return "initial"
    else
      return "decidetarget"
    end
  end

  function battlecharactercommand:flee()
    local fleetable = getfleetable(self.references.char, self.references.party, self.references.enemyparty, self.references.battle)
    self.commands.fleemove = tonumber(confirmflee(fleetable))
    if (self.commands.fleemove ~= 1) then
      self.references.battle.fleed = fleehandler(self.references.battle, fleetable)
      if not self.references.battle.fleed then
        message = message .. "도주에 실패했다!"
      end
    end

    if self.commands.fleemove == 1 then
      return "initial"
    else
      return "terminal"
    end
  end

  testcommand = {}
  testcommand.references = {"testref"}
  testcommand.returns = {"answer", "additional"}
  testcommand.commands = {}

  testref = "테스트용 리퍼런스"

  function testcommand:initial()
    testcommand.commands.answer = ""
    testcommand.commands.additional = ""
    printl(self.references.testref)
    self.commands.answer = ask("답을 선택해 주세요", "1", "2")
    if self.commands.answer == "1" then
      return "additional"
    else
      return "confirm"
    end
  end

  function testcommand:additional()
    self.commands.additional = ask("추가적인 답변을 입력해 주세요", "y", "n")
    if "y" == ask("확실합니까?", "y", "n") then
      return "confirm"
    else
      return "additional"
    end
  end

  function testcommand:confirm()
    printl("답변을 확인하겠습니다.")
    printl("답: " .. self.commands.answer)
    printl("추가 답변: " .. self.commands.additional)
    if "y" == ask("이걸로 마치시겠습니까?", "y", "n") then
      return "terminal"
    else
      return "initial"
    end
  end

  --local choices = playercommand(battlecharactercommand, char, party, enemyparty, battle)
  --local choices = playercommand(testcommand, testref)
#end