-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chat = game:GetService("Chat")

local Players = game:GetService("Players")
local StarterPlayerScripts = game:GetService("StarterPlayer"):WaitForChild("StarterPlayerScripts")

local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local ServerUtil = require(RobloxGui.Modules.Server.ServerUtil)

local SendChatAnalytics = require(RobloxGui.Modules.Server.SendChatAnalytics)

local bool1 = game:DefineFastFlag("ChatWindowInstallerCheckClassName", false)

local success, result = pcall(function()
    return UserSettings():IsUserFeatureEnabled("UserIsChatTranslationEnabled2")
end)
local var1 = success and result

local function LoadLocalScript(arg1, localScriptName: string, parent)
    local var2 = arg1:WaitForChild(localScriptName)
    if bool1 and var2.ClassName ~= "ModuleScript" then
        return var2:Clone()
    end

    local localScript = Instance.new("LocalScript")
    localScript.Name = localScriptName
    if ServerUtil.getFFlagServerCoreScriptSourceCode() then
        localScript.Source = ServerUtil.getSourceForServerScript(var2)
    else
        localScript.Source = var2.Source
    end
    localScript.Parent = parent
    return localScript
end

local function LoadModule(arg1, moduleScriptName, parent)
    local var2 = arg1:WaitForChild(moduleScriptName)
    if bool1 and var2.ClassName ~= "ModuleScript" then
        return var2:Clone()
    end

    local moduleScript = Instance.new("ModuleScript")
    moduleScript.Name = moduleScriptName
    if ServerUtil.getFFlagServerCoreScriptSourceCode() then
        moduleScript.Source = ServerUtil.getSourceForServerScript(var2)
    else
        moduleScript.Source = var2.Source
    end
    moduleScript.Parent = parent
    return moduleScript
end

local function GetBoolValue(arg1, str1: string, bool2: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var2 = arg1:FindFirstChild(str1)
    return if var2 and var2:IsA("BoolValue") then var2.Value else bool2
end

local function Install()
    local tbl1 = ({})

    local bool2 = true
    local chatScript = Chat:FindFirstChild("ChatScript")
    if not chatScript then
        bool2 = false
        chatScript = LoadLocalScript(script.Parent, "ChatScript", Chat)
        local var2 = LoadModule(script.Parent, "ChatMain", chatScript)

        LoadModule(script.Parent, "ChannelsBar", var2)
        LoadModule(script.Parent, "ChatBar", var2)
        LoadModule(script.Parent, "ChatChannel", var2)
        LoadModule(script.Parent, "MessageLogDisplay", var2)
        LoadModule(script.Parent, "ChatWindow", var2)
        LoadModule(script.Parent, "MessageLabelCreator", var2)
        LoadModule(script.Parent, "CommandProcessor", var2)
        LoadModule(script.Parent, "ChannelsTab", var2)
        LoadModule(script.Parent.Parent.Parent.Common, "ObjectPool", var2)
        LoadModule(script.Parent, "MessageSender", var2)
        LoadModule(script.Parent, "CurveUtil", var2)

        if var1 then
            local chatTranslationEnabled = Instance.new("BoolValue")
            chatTranslationEnabled.Name = "ChatTranslationEnabled"
            chatTranslationEnabled.Value = false
            chatTranslationEnabled.Parent = var2
        end
    else
        tbl1.ChatScript = "True"
    end

    local bool3 = true
    local bubbleChat = Chat:FindFirstChild("BubbleChat")
    if not bubbleChat then
        bubbleChat = LoadLocalScript(script.Parent.BubbleChat, "BubbleChat", Chat)
        bool3 = false
    else
        tbl1.BubbleChat = "True"
    end

    local clientChatModules = Chat:FindFirstChild("ClientChatModules")
    if not clientChatModules then
        clientChatModules = Instance.new("Folder")
        clientChatModules.Name = "ClientChatModules"
        clientChatModules.Archivable = false

        clientChatModules.Parent = Chat
    else
        tbl1.ClientChatModules = "True"
    end

    if not clientChatModules:FindFirstChild("ChatSettings") then
        LoadModule(script.Parent.DefaultClientChatModules, "ChatSettings", clientChatModules)
    else
        tbl1.ChatSettings = "True"
    end

    if not clientChatModules:FindFirstChild("ChatConstants") then
        LoadModule(script.Parent.DefaultClientChatModules, "ChatConstants", clientChatModules)
    else
        tbl1.ChatConstants = "True"
    end

    if not clientChatModules:FindFirstChild("ChatLocalization") then
        LoadModule(script.Parent.DefaultClientChatModules, "ChatLocalization", clientChatModules)
    else
        tbl1.ChatLocalization = "True"
    end

    local messageCreatorModules = clientChatModules:FindFirstChild("MessageCreatorModules")
    if not messageCreatorModules then
        messageCreatorModules = Instance.new("Folder")
        messageCreatorModules.Name = "MessageCreatorModules"
        messageCreatorModules.Archivable = false

        local insertDefaultModules = Instance.new("BoolValue")
        insertDefaultModules.Name = "InsertDefaultModules"
        insertDefaultModules.Value = true
        insertDefaultModules.Parent = messageCreatorModules

        messageCreatorModules.Parent = clientChatModules
    end

    if GetBoolValue(messageCreatorModules, "InsertDefaultModules", false) then
        local children = script.Parent.DefaultClientChatModules.MessageCreatorModules:GetChildren()
        for i = 1, #children do
            if not messageCreatorModules:FindFirstChild(children[i].Name) then
                LoadModule(script.Parent.DefaultClientChatModules.MessageCreatorModules, children[i].Name, messageCreatorModules)
            else
                tbl1[children[i].Name] = "True"
            end
        end
    end

    local commandModules = clientChatModules:FindFirstChild("CommandModules")
    if not commandModules then
        commandModules = Instance.new("Folder")
        commandModules.Name = "CommandModules"
        commandModules.Archivable = false

        local insertDefaultModules = Instance.new("BoolValue")
        insertDefaultModules.Name = "InsertDefaultModules"
        insertDefaultModules.Value = true
        insertDefaultModules.Parent = commandModules

        commandModules.Parent = clientChatModules
    end

    if GetBoolValue(commandModules, "InsertDefaultModules", false) then
        local children = script.Parent.DefaultClientChatModules.CommandModules:GetChildren()
        for i = 1, #children do
            if not commandModules:FindFirstChild(children[i].Name) then
                LoadModule(script.Parent.DefaultClientChatModules.CommandModules, children[i].Name, commandModules)
            else
                tbl1[children[i].Name] = "True"
            end
        end
    end

    if not StarterPlayerScripts:FindFirstChild("ChatScript") then
        local chatScriptClone = chatScript:Clone()
        chatScriptClone.Parent = StarterPlayerScripts
        chatScriptClone.Archivable = false

        local players = Players:GetPlayers()
        for _, player in pairs(players) do
            if not player:FindFirstChildOfClass("PlayerGui") then
                continue
            end
            local var2 = LoadLocalScript(script.Parent, "ChatInstallVerifier", player.PlayerGui)
            local scriptToVerify = Instance.new("StringValue")
            scriptToVerify.Name = "ScriptToVerify"
            scriptToVerify.Value = "ChatScript"
            scriptToVerify.Parent = var2
        end
    end

    chatScript.Archivable = bool2

    if not StarterPlayerScripts:FindFirstChild("BubbleChat") then
        local bubbleChatClone = bubbleChat:Clone()
        bubbleChatClone.Parent = StarterPlayerScripts
        bubbleChatClone.Archivable = false

        local players = Players:GetPlayers()
        for _, player in pairs(players) do
            if not player:FindFirstChildOfClass("PlayerGui") then
                continue
            end

            local var2 = LoadLocalScript(script.Parent, "ChatInstallVerifier", player.PlayerGui)
            local scriptToVerify = Instance.new("StringValue")
            scriptToVerify.Name = "ScriptToVerify"
            scriptToVerify.Value = "BubbleChat"
            scriptToVerify.Parent = var2
        end
    end

    bubbleChat.Archivable = bool3
    SendChatAnalytics("LoadClientDefaultChatForkedModules", tbl1)
end

return Install
