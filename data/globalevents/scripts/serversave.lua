local shutdownAtServerSave = false
local cleanMapAtServerSave = false

local function serverSave()
        if shutdownAtServerSave then
                Game.setGameState(GAME_STATE_SHUTDOWN)
        end
        if cleanMapAtServerSave then
                cleanMap()
        end
        saveServer()
end

local function secondServerSaveWarning()
        broadcastMessage("Server is saving game in one minute. Please go to a safe place.", MESSAGE_STATUS_WARNING)
        addEvent(serverSave, 60000)
end

local function firstServerSaveWarning()
        broadcastMessage("Server is saving game in 3 minutes. Please go to a safe place.", MESSAGE_STATUS_WARNING)
        addEvent(secondServerSaveWarning, 120000)
end

function onTime(interval)
        broadcastMessage("Server is saving game in 5 minutes. Please go to a safe place.", MESSAGE_STATUS_WARNING)
        Game.setGameState(GAME_STATE_STARTUP)
        addEvent(firstServerSaveWarning, 120000)
        return not shutdownAtServerSave
end