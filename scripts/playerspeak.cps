#function playerspeak
  function playerspeak(inquery, ...)
    local args = {n=select('#',...),...}
    if (next(inquery.references) ~= nil) then
      for i, v in ipairs(inquery.references) do
        inquery.references[v] = args[i]
      end
    end
    local startaskt, startaskl = getc()
    local answertable = {}
    local answerstringtable = {}
    local counter = 1
    local countertable = {}
    for i, v in ipairs(inquery) do
      if (v.onlyshow == nil) then
        if (v.onlypossible == nil) then
          table.insert(answertable, counter)
          answerstringtable[counter] = "[" .. counter .. "] " .. inquery[i].answer
          countertable[counter] = i
        else 
          local onlypossible, text = v.onlypossible()
          if onlypossible then
            table.insert(answertable, counter)
            answerstringtable[counter] = "[" .. counter .. "] " .. text .. inquery[i].answer
            countertable[counter] = i
          else
            answerstringtable[counter] = "/fk[" .. counter .. "]/x " .. text .. "/fk" .. inquery[i].answer .. "/x"
          end
        end
        counter = counter + 1
      else
        local onlyshow = v.onlyshow()
        if onlyshow then
          table.insert(answertable, counter)
          answerstringtable[counter] = "[" .. counter .. "] " .. inquery[i].answer
          countertable[counter] = i
          counter = counter + 1
        end
      end
    end
    printl(inquery.question)
    for i, v in ipairs(answerstringtable) do
      printl(v)
    end
    local answer = tonumber(ask("...", table.unpack(answertable)))
    if inquery[countertable[answer]].consequence then
      inquery[countertable[answer]].consequence()
    end
    return countertable[answer]
  end

  function speechcheck(checktype, compare, value)
    local var, varname
    local pass = "/bG/fw"
    local fail = "/bB/fR"
    local close = "/x"
    if (checktype == "playermoney") then
      var = money
      varname = "소지금"
    end
    if (compare == "geq") then
      return var >= value, (var >= value and pass or fail) .. "[" .. varname .. " " .. value .. " 이상]" .. close
    end
    return true, "[[DEBUG]speechchcek 비교 만들어지지 않음]"
  end

  testinquery = {}
  testinquery.question = "당신은 어떤 사람이었죠?"
  testinquery.references = {"player"}

  testinquery[1] = {}
  testinquery[1].answer = "그것보다, 당신은 누구죠?"
  testinquery[1].onlyshow = function() return player.flags["enoughcuriosity"] end

  testinquery[2] = {}
  testinquery[2].answer = "평범한 학생이었습니다."
  testinquery[2].consequence = function() player.flags["enoughcuriosity"] = true end

  testinquery[3] = {}
  testinquery[3].answer = "돈을 좀 휘두르고 다녔죠."
  testinquery[3].onlypossible = function() return speechcheck("playermoney", "geq", 10000) end



#end