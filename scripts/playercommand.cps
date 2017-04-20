#function playercommand
  function playercommand(command, ...)
    local args = {n=select('#',...),...}
    local choices = command.commands
    for i, v in ipairs(command.references) do
      command.references[v] = args[i]
    end
    local startaskt, startaskl = getc()
    local state = command:initial()
    while (state ~= "terminal") do
      if (state == "initial" and command.resetpositiononinitial) then
        local endaskt = getc()
        erase(startaskt, endaskt)
        moveto(startaskt, startaskl)
      end
      if state then
      state = command[state](command)
      else
        printl("DEBUG : 모든 playercommand는 return으로 적절한 다음 state를 반환해야 합니다. 마지막으로 return된 state: " .. (state and state or "nil"))
        break
      end
    end
    return choices
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