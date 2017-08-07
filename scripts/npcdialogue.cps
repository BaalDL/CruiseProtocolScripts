#function npcdialogue
  execute("playerspeak")
  function startdialogue(npckey, dialoguekey)
    local dialogue = LocationNpcDialogueList[npckey][dialoguekey]
    local pointer = "initial"
    local isgreeting = true
    while (pointer ~= "terminal") do
      if (dialogue[pointer].category == "inquery") then
        pointer = dialogue[pointer].nextkey[playerspeak(dialogue[pointer].inquery, isgreeting, table.unpack(dialogue[pointer].inqueryreferences))]
      elseif (dialogue[pointer].category == "monologue") then
        sayw(LocationNpcsList[npckey].Name, table.unpack(dialogue[pointer].scripts))
        pointer = dialogue[pointer].nextkey
      elseif (dialogue[pointer].category == "empty") then
        pointer = dialogue[pointer].nextkey
      elseif (dialogue[pointer].category == "subdialogue") then
        startdialogue(npckey, dialogue[pointer].subkey)
        pointer = "initial"
      end
      isgreeting = false
    end
  end

#end