-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chat = game:GetService("Chat")
local ServerScriptService = game:GetService("ServerScriptService")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local ServerUtil = require(RobloxGui.Modules.Server.ServerUtil)
local SendChatAnalytics = require(RobloxGui.Modules.Server.SendChatAnalytics)

local function LoadScript(scriptName: string, chat: Chat): Script
    local var1 = script.Parent:WaitForChild(scriptName)
    local script = Instance.new("Script")
    script.Name = scriptName
    if ServerUtil.getFFlagServerCoreScriptSourceCode() then
        script.Source = ServerUtil.getSourceForServerScript(var1)
    else
        script.Source = var1.Source
    end
    script.Parent = chat
    return script
end

local function LoadModule(arg1, moduleScriptName, parent): ModuleScript -- Luacid: Inlined by compiler; 6 call sites recovered
    local var1 = arg1:WaitForChild(moduleScriptName)
    local moduleScript = Instance.new("ModuleScript")
    moduleScript.Name = moduleScriptName
    if ServerUtil.getFFlagServerCoreScriptSourceCode() then
        moduleScript.Source = ServerUtil.getSourceForServerScript(var1)
    else
        moduleScript.Source = var1.Source
    end
    moduleScript.Parent = parent
    return moduleScript
end

local function GetBoolValue(arg1, str1: string, bool1: boolean) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = arg1:FindFirstChild(str1)
    return if var1 and var1:IsA("BoolValue") then var1.Value else bool1
end

local function makeDefaultLocalizationTable(chat: Chat)
    local chatLocalization = Instance.new("LocalizationTable")
    chatLocalization.Name = "ChatLocalization"
    chatLocalization.Archivable = false
    chatLocalization.SourceLocaleId = "en-us"
    chatLocalization:SetEntries(require(script.Parent:WaitForChild("DefaultChatLocalization")))
    chatLocalization:SetIsExemptFromUGCAnalytics(true)
    chatLocalization.Parent = chat
end

local function Install()
    local tbl1 = ({})
    local chatLocalization = Chat:FindFirstChild("ChatLocalization")

    if chatLocalization then
        if chatLocalization:IsA("LocalizationTable") then
            chatLocalization:SetIsExemptFromUGCAnalytics(true)
        end
    else
        makeDefaultLocalizationTable(Chat)
    end

    local bool1 = true
    local chatServiceRunner = Chat:FindFirstChild("ChatServiceRunner")
    if not chatServiceRunner then
        chatServiceRunner = LoadScript("ChatServiceRunner", Chat)

        local _moduleScript = LoadModule(script.Parent, "ChatService", chatServiceRunner)
        local _moduleScript2 = LoadModule(script.Parent, "ChatChannel", chatServiceRunner)
        local _moduleScript3 = LoadModule(script.Parent, "Speaker", chatServiceRunner)
        local _moduleScript4 = LoadModule(script.Parent, "Util", chatServiceRunner)
        bool1 = false
    else
        tbl1.ChatServiceRunner = "True"
    end

    local chatModules = Chat:FindFirstChild("ChatModules")
    if not chatModules then
        chatModules = Instance.new("Folder")
        chatModules.Name = "ChatModules"
        chatModules.Archivable = false

        local insertDefaultModules = Instance.new("BoolValue")
        insertDefaultModules.Name = "InsertDefaultModules"
        insertDefaultModules.Value = true
        insertDefaultModules.Parent = chatModules

        chatModules.Parent = Chat
    end
    assert(chatModules, "")

    if GetBoolValue(chatModules, "InsertDefaultModules", false) then
        if not chatModules:FindFirstChild("Utility") then
            local utility = Instance.new("Folder")
            utility.Name = "Utility"
            utility.Parent = chatModules
        end

        local children = script.Parent.DefaultChatModules:GetChildren()
        for i = 1, #children do
            if children.className ~= "Folder" and not chatModules:FindFirstChild(children[i].Name) then
                local _moduleScript = LoadModule(script.Parent.DefaultChatModules, children[i].Name, chatModules)
            elseif children.className ~= "Folder" then
                tbl1[children[i].Name] = "True"
            end
        end

        for _, child in pairs(script.Parent.DefaultChatModules.Utility:GetChildren()) do
            if not chatModules.Utility:FindFirstChild(child.Name) then
                local _moduleScript = LoadModule(script.Parent.DefaultChatModules.Utility, child.Name, chatModules.Utility)
            else
                tbl1[child.Name] = "True"
            end
        end
    end

    if not ServerScriptService:FindFirstChild("ChatServiceRunner") then
        local chatServiceRunnerClone = chatServiceRunner:Clone()
        chatServiceRunnerClone.Archivable = false
        chatServiceRunnerClone.Parent = ServerScriptService
    end

    chatServiceRunner.Archivable = bool1
    SendChatAnalytics("LoadServerDefaultChatForkedModules", tbl1)
end

return Install
