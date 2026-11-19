-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerScriptService = game:GetService("ServerScriptService")
local StarterPlayer = game:GetService("StarterPlayer")
local ServerUtil = require(script.Parent.Parent.ServerUtil)

local function HasOldSoundScripts(): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if ServerScriptService:FindFirstChild("SoundDispatcher") then
        return true
    end

    local starterCharacterScripts = StarterPlayer:FindFirstChildOfClass("StarterCharacterScripts")
    return not not (starterCharacterScripts and starterCharacterScripts:FindFirstChild("Sound"))
end

local function LoadScript(scriptName: string, serverScriptService: ServerScriptService): Script
    local var1 = script.Parent:WaitForChild(scriptName)
    local script = Instance.new("Script")
    script.Name = scriptName
    if ServerUtil.getFFlagServerCoreScriptSourceCode() then
        script.Source = ServerUtil.getSourceForServerScript(var1)
    else
        script.Source = var1.Source
    end
    script.Parent = serverScriptService
    return script
end

local function TryInstall()
    if not HasOldSoundScripts() then
        return
    end

    local soundDispatcher = ServerScriptService:FindFirstChild("SoundDispatcher")
    local bool1

    if soundDispatcher then
        bool1 = true
    else
        soundDispatcher = LoadScript("SoundDispatcher", ServerScriptService)
        bool1 = false
    end

    if not ServerScriptService:FindFirstChild("SoundDispatcher") then
        local soundDispatcherClone = soundDispatcher:Clone()
        soundDispatcherClone.Archivable = false
        soundDispatcherClone.Parent = ServerScriptService
    end

    soundDispatcher.Archivable = bool1
end

return TryInstall
