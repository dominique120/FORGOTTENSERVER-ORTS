local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
 
function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)			
end
function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)			
end
function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)		
end
function onThink()
	npcHandler:onThink()					
end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	
	if(msgcontains(msg, "report")) then
		if(getPlayerStorageValue(cid, 30) == 8 or getPlayerStorageValue(cid, 30) == 12) then
			npcHandler:say("Hicks! I... I... <he is obviously drunk and his report more than confusing>. ", cid)
			setPlayerStorageValue(cid, 30, getPlayerStorageValue(cid, 30) + 1)
			talkState[talkUser] = 0
		end
	elseif(msgcontains(msg, "pass")) then
		npcHandler:say("You can {pass} either to the {Arena Quarter} or {Alchemist Quarter}. Which one will it be?", cid)
		talkState[talkUser] = 1
	elseif(msgcontains(msg, "arena")) then
		if(talkState[talkUser] == 1) then
			doTeleportThing(cid, {x=32688, y=31193, z=7})
			doSendMagicEffect({x=32688, y=31193, z=7}, CONST_ME_TELEPORT)
			talkState[talkUser] = 0
		end
	elseif(msgcontains(msg, "alchemist")) then
		if(talkState[talkUser] == 1) then
			doTeleportThing(cid, {x=32688, y=31188, z=7})
			doSendMagicEffect({x=32688, y=31188, z=7}, CONST_ME_TELEPORT)
			talkState[talkUser] = 0
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())