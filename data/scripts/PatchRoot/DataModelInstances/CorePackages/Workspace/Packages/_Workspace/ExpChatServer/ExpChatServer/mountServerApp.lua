-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:01:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local TextChatService = game:GetService("TextChatService")
local ExpChatServer = script:FindFirstAncestor("ExpChatServer")
local ExpChatServerParent = ExpChatServer.Parent

local List = require(ExpChatServerParent.llama).List
local ExpChatShared = require(ExpChatServerParent.ExpChatShared)
local SharedFlags = require(ExpChatServerParent.SharedFlags)

local createDispatchRemoteFunction = require(ExpChatServer.createDispatchRemoteFunction)
local createStore = require(script.createStore)
local watchForErrors = ExpChatShared.watchForErrors

local countParticipantsInTextChannel = ExpChatShared.countParticipantsInTextChannel

local Actions = ExpChatShared.Actions
local PlayerAdded = Actions.PlayerAdded
local PlayerRemoved = Actions.PlayerRemoved

local Commands = ExpChatShared.Commands
local Config = ExpChatShared.Config

local Analytics = ExpChatShared.Analytics
local var1 = ExpChatShared.Logger:new("ExpChat/" .. script.Name)

local getFFlagExpChatAlwaysRunTCS = SharedFlags.getFFlagExpChatAlwaysRunTCS
local FFlagExpChatAddUserAsyncNilCheck = ExpChatShared.Flags.FFlagExpChatAddUserAsyncNilCheck
local markTextChannelAsDefault = ExpChatShared.markTextChannelAsDefault
local bool1 = game:DefineFastFlag("ExpChatBackfillTeamChannels", false)
local bool2 = game:DefineFastFlag("ExpChatBackfillTeamChannelsParentCheck", false)

local function func1(): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return #List.filter(TextChatService:GetDescendants(), function(arg1)
        return arg1:IsA("TextChannel")
    end)
end

local function func2(): number -- Luacid: Inlined by compiler; 1 call site recovered
    return #List.filter(TextChatService:GetDescendants(), function(arg1)
        return arg1:IsA("TextChatCommand")
    end)
end
return function(tbl1)
    var1:trace("mountServerApp started")

    local store = createStore()
    createDispatchRemoteFunction()

    if tbl1 and tbl1.analytics then
        Analytics.with(tbl1.analytics)
    end

    watchForErrors(game:GetService("ScriptContext"), tbl1.script, true)

    local tbl2 = {}

    if TextChatService.CreateDefaultTextChannels then
        var1:trace("Creating default TextChannels")

        local textChannels = Instance.new("Folder")
        textChannels.Name = "TextChannels"
        textChannels.Parent = TextChatService

        local function findChannel(name)
            for _, descendant in pairs(TextChatService:GetDescendants()) do
                if descendant:IsA("TextChannel") and descendant.Name == name then
                    return descendant
                end
            end

            return nil
        end

        local function addChannel(name) -- Luacid: Inlined by compiler; 6 call sites recovered
            local channel = findChannel(name)

            if not channel then
                channel = Instance.new("TextChannel")
                channel.Name = name
                markTextChannelAsDefault(channel)
                channel.Parent = textChannels
            end

            return channel
        end

        local function findTextSourceFromChannelWithUserId(arg1, userId: number)
            for _, child in pairs(arg1:GetChildren()) do
                if child:IsA("TextSource") and child.UserId == userId then
                    return child
                end
            end

            return nil
        end

        local function createTeamChannel(team: Team)
            local teamColorName = team.TeamColor.Name
            local var2 = addChannel("RBXTeam" .. tostring(teamColorName))
            var1:debug("Creating team TextChannel: {}", var2.Name)

            team.PlayerAdded:Connect(function(player: Player)
                local teamColorName2 = team.TeamColor.Name
                local var3 = addChannel("RBXTeam" .. tostring(teamColorName2)):AddUserAsync(player.UserId)

                if not FFlagExpChatAddUserAsyncNilCheck or var3 ~= nil then
                    var3.CanSend = true
                end
            end)

            team.PlayerRemoved:Connect(function(player: Player)
                local teamColorName2 = team.TeamColor.Name
                local var3 = addChannel("RBXTeam" .. tostring(teamColorName2))
                local textSourceFromChannelWithUserId = findTextSourceFromChannelWithUserId(var3, player.UserId)
                if textSourceFromChannelWithUserId then
                    textSourceFromChannelWithUserId:Destroy()
                end
            end)

            local bool3 = bool1
            if bool3 and bool2 then
                bool3 = team.Parent == Teams
            end

            if bool3 then
                for _, player in pairs(team:GetPlayers()) do
                    local teamColorName2 = team.TeamColor.Name
                    local var3 = addChannel("RBXTeam" .. tostring(teamColorName2)):AddUserAsync(player.UserId)
                    if not FFlagExpChatAddUserAsyncNilCheck or var3 ~= nil then
                        var3.CanSend = true
                    end
                end
            end

            team:GetPropertyChangedSignal("TeamColor"):Connect(function()
                local teamColorName2 = team.TeamColor.Name
                local var3 = addChannel("RBXTeam" .. tostring(teamColorName2))
                var3.Name = "RBXTeam" .. tostring(team.TeamColor.Name)
            end)
        end

        for _, team in pairs(Teams:GetTeams()) do
            if team:IsA("Team") then
                createTeamChannel(team)
            end
        end

        Teams.ChildAdded:Connect(function(child: Instance)
            if child:IsA("Team") then
                createTeamChannel(child)
            end
        end)

        Teams.ChildRemoved:Connect(function(child: Instance)
            if not child:IsA("Team") then
                return
            end

            local channel = findChannel("RBXTeam" .. tostring(child.TeamColor.Name))
            if channel then
                var1:debug("Destroying team TextChannel: {}", channel.Name)
                channel:Destroy()
            end
        end)

        for k, _ in pairs(Config.DefaultChannelNames) do
            var1:trace("Creating default channel: {}", k)
            table.insert(tbl2, (addChannel(k)))
        end

        local function addPlayerTextSourceToDefaultChannels(player: Player)
            for _, value in ipairs(tbl2) do
                var1:trace("Adding user {} to TextChannel: {}", tostring(player.UserId), value.Name)
                local var2 = value:AddUserAsync(player.UserId)

                if FFlagExpChatAddUserAsyncNilCheck then
                    if var2 ~= nil and value.Name == "RBXGeneral" then
                        var2.CanSend = true
                    elseif var2 ~= nil and value.Name == "RBXSystem" then
                        var2.CanSend = false
                    end
                elseif value.Name == "RBXGeneral" then
                    var2.CanSend = true
                elseif value.Name == "RBXSystem" then
                    var2.CanSend = false
                end
            end
        end

        for _, player in pairs(Players:GetPlayers()) do
            if player:IsA("Player") then
                addPlayerTextSourceToDefaultChannels(player)
            end
        end

        Players.PlayerAdded:Connect(addPlayerTextSourceToDefaultChannels)

        Analytics.FireRccAnalyticsWithEventName("DefaultChannelsCreated")
    end

    if TextChatService.CreateDefaultCommands then
        var1:trace("Creating default TextChatCommands")
        local textChatCommands = Instance.new("Folder")
        textChatCommands.Name = "TextChatCommands"
        textChatCommands.Parent = TextChatService

        for _, enabledCommand in ipairs(Commands.enabledCommands) do
            local textChatCommand = Instance.new("TextChatCommand")
            textChatCommand.Name = enabledCommand.name
            textChatCommand.PrimaryAlias = enabledCommand.alias[1]
            textChatCommand.SecondaryAlias = enabledCommand.alias[2] or ""
            textChatCommand.Parent = textChatCommands
        end

        Analytics.FireRccAnalyticsWithEventName("DefaultCommandsCreated")
    end

    local loadedChannels = func1()
    local loadedCommands = func2()
    Analytics.FireRccAnalyticsWithEventName(
        "ExperienceChatLoaded",
        { loadedChannels = loadedChannels, loadedCommands = loadedCommands }
    )

    if getFFlagExpChatAlwaysRunTCS() then
        Analytics.FireRccAnalyticsDeferred("AutomigratedToTCS", { universeId = game.GameId })
    end

    var1:debug("Start watching for new channels and commands")

    TextChatService.DescendantAdded:Connect(function(descendant: Instance)
        if descendant:IsA("TextChannel") then
            Analytics.FireRccAnalyticsWithEventName("ChannelCreated", { channelName = descendant.Name, totalChannels = func1() })
            return
        end
        if descendant:IsA("TextChatCommand") then
            Analytics.FireRccAnalyticsWithEventName("CommandCreated", { commandName = descendant.Name })
            return
        end
        if not descendant:IsA("TextSource") then
            return
        end

        local descendantParent = descendant.Parent
        if descendantParent and descendantParent:IsA("TextChannel") then
            Analytics.FireRccAnalyticsWithEventName(
                "ChannelJoined",
                {
                    channelName = descendantParent.Name,
                    totalParticipants = countParticipantsInTextChannel(descendantParent)
                }
            )
        end
    end)

    TextChatService.DescendantRemoving:Connect(function(descendant: Instance)
        if descendant:IsA("TextChannel") then
            Analytics.FireRccAnalyticsWithEventName("ChannelRemoved", {
                channelName = descendant.Name,
                totalChannels = #List.filter(TextChatService:GetDescendants(), function(arg1)
                    return arg1:IsA("TextChannel")
                end) - 1
            })

            return
        end
        if descendant:IsA("TextChatCommand") then
            Analytics.FireRccAnalyticsWithEventName("CommandRemoved", { commandName = descendant.Name })
            return
        end
        if not descendant:IsA("TextSource") then
            return
        end

        local descendantParent = descendant.Parent
        if descendantParent and descendantParent:IsA("TextChannel") then
            Analytics.FireRccAnalyticsWithEventName(
                "ChannelLeft",
                {
                    channelName = descendantParent.Name,
                    totalParticipants = countParticipantsInTextChannel(descendantParent)
                }
            )
        end
    end)

    for _, player in pairs(Players:GetPlayers()) do
        store:dispatch(PlayerAdded(player.UserId, player.Name, player.DisplayName))
    end
    Players.PlayerAdded:Connect(function(player: Player)
        store:dispatch(PlayerAdded(player.UserId, player.Name, player.DisplayName))
    end)

    Players.PlayerRemoving:Connect(function(player: Player)
        store:dispatch(PlayerRemoved(player.UserId))
    end)
end
