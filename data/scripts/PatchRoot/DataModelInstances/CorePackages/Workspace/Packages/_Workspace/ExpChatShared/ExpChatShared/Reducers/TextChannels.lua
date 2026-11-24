-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local ExpChatSharedParent = ExpChatShared.Parent
local Rodux = require(ExpChatSharedParent.Rodux)
local Dictionary = require(ExpChatSharedParent.llama).Dictionary
local None = require(ExpChatSharedParent.llama).None
local var1 = require(ExpChatShared.Logger):new("ExpChat/Reducers/" .. script.Name)

local GetFFlagTextChatEnableUniverseChatTabs = require(ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs)
local FFlagExpChatFixBackspaceNilTargetChannel = require(ExpChatShared.Flags.FFlagExpChatFixBackspaceNilTargetChannel)

local Actions = ExpChatShared.Actions
local ChatInputBarActivatedTeamMode = require(Actions.ChatInputBarActivatedTeamMode)
local ChatInputBarActivatedWhisperMode = require(Actions.ChatInputBarActivatedWhisperMode)
local ChatInputBarResetTargetChannel = require(Actions.ChatInputBarResetTargetChannel)
local ClientAppLoaded = require(Actions.ClientAppLoaded)
local LocalTeamChanged = require(Actions.LocalTeamChanged)
local LocalTextChannelParticipantRemoved = require(Actions.LocalTextChannelParticipantRemoved)
local TargetTextChannelPropertyChanged = require(Actions.TargetTextChannelPropertyChanged)
local TextChatChannelSelected = require(Actions.TextChatChannelSelected)
local TextChannelCreated = require(Actions.TextChannelCreated)
local TextChannelRemoved = require(Actions.TextChannelRemoved)
local PlayerRemoved = require(Actions.PlayerRemoved)
local UniverseChatChannelSelected = require(Actions.UniverseChatChannelSelected)

local function getTeamTextChannelFromTeam(allTextChannels, arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local var2 = "RBXTeam" .. arg1.TeamColor.Name
    for k, allTextChannel in pairs(allTextChannels) do
        if k == var2 then
            return allTextChannel
        end
    end

    return nil
end

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[ClientAppLoaded.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, { currentTeam = if arg1.team == nil then None else arg1.team })
end

tbl1[TextChannelCreated.name] = function(tbl2, arg1)
    var1:trace("TextChannelCreated: {}", arg1.textChannel.Name)
    local join = Dictionary.join
    local tbl3 = {
        allTextChannels = Dictionary.join(tbl2.allTextChannels, { [arg1.textChannel.Name] = arg1.textChannel })
    }
    return join(tbl2, tbl3)
end

tbl1[TextChannelRemoved.name] = function(tbl2, arg1)
    local allTextChannels = Dictionary.removeKey(tbl2.allTextChannels, arg1.textChannel.Name)
    local targetTextChannel = if arg1.textChannel == tbl2.targetTextChannel then allTextChannels.RBXGeneral or None else tbl2.targetTextChannel
    return Dictionary.join(tbl2, { allTextChannels = allTextChannels, targetTextChannel = targetTextChannel })
end

tbl1[LocalTextChannelParticipantRemoved.name] = function(tbl2, arg1)
    return Dictionary.join(tbl2, {
        targetTextChannel = if arg1.textChannel ~= tbl2.targetTextChannel then tbl2.targetTextChannel elseif arg1.textChannel == tbl2.allTextChannels.RBXGeneral then None else tbl2.allTextChannels.RBXGeneral or None
    })
end

tbl1[TargetTextChannelPropertyChanged.name] = function(tbl2, arg1)
    var1:trace("TargetTextChannelPropertyChanged dispatched")

    if arg1.textChannel == nil then
        return tbl2
    end

    if GetFFlagTextChatEnableUniverseChatTabs() then
        return Dictionary.join(tbl2, { targetTextChannel = arg1.textChannel, selectedChannelName = arg1.textChannel.Name })
    end

    return Dictionary.join(tbl2, { targetTextChannel = if arg1.textChannel == nil then None else arg1.textChannel })
end

tbl1[TextChatChannelSelected.name] = function(tbl2, arg1)
    var1:trace("TextChatChannelSelected dispatched: {}", arg1.channelName)

    local targetTextChannel = tbl2.allTextChannels[arg1.channelName]
    if targetTextChannel == nil then
        return tbl2
    end

    return Dictionary.join(tbl2, { targetTextChannel = targetTextChannel, selectedChannelName = arg1.channelName })
end

tbl1[LocalTeamChanged.name] = function(tbl2, arg1)
    if not arg1.team then
        var1:trace("LocalTeamChanged dispatched with no team")
        if tbl2.targetTextChannel and string.find(tbl2.targetTextChannel.Name, "^RBXTeam") then
            return Dictionary.join(
                tbl2,
                {
                    currentTeam = None,
                    targetTextChannel = tbl2.allTextChannels.RBXGeneral or tbl2.targetTextChannel
                }
            )
        end

        return Dictionary.join(tbl2, { currentTeam = None })
    end

    var1:trace("LocalTeamChanged dispatched with team: {}", arg1.team.Name)

    if not (tbl2.targetTextChannel and string.find(tbl2.targetTextChannel.Name, "^RBXTeam")) then
        return Dictionary.join(tbl2, { currentTeam = arg1.team })
    end

    local teamTextChannelFromTeam = getTeamTextChannelFromTeam(tbl2.allTextChannels, arg1.team)

    local join = Dictionary.join
    local tbl3 = {
        currentTeam = arg1.team,
        targetTextChannel = 0
    }

    if teamTextChannelFromTeam == nil then
        teamTextChannelFromTeam = tbl2.allTextChannels.RBXGeneral
    end

    tbl3.targetTextChannel = teamTextChannelFromTeam
    return join(tbl2, tbl3)
end

tbl1[ChatInputBarActivatedTeamMode.name] = function(tbl2, _)
    if tbl2.currentTeam == nil then
        var1:trace("ChatInputBarActivatedTeamMode but not on a team")
        return tbl2
    end

    assert(tbl2.currentTeam, "This should be unreachable")

    local teamTextChannelFromTeam = getTeamTextChannelFromTeam(tbl2.allTextChannels, tbl2.currentTeam)
    var1:trace(
        "ChatInputBarActivatedTeamMode - set targetTextChannel to {}",
        teamTextChannelFromTeam and teamTextChannelFromTeam.Name or "nil"
    )

    if teamTextChannelFromTeam == nil then
        return tbl2
    end

    local join = Dictionary.join
    local tbl3 = { targetTextChannel = 0 }
    if teamTextChannelFromTeam == nil then
        teamTextChannelFromTeam = None
    end

    tbl3.targetTextChannel = teamTextChannelFromTeam
    return join(tbl2, tbl3)
end

tbl1[ChatInputBarResetTargetChannel.name] = function(tbl2, arg1)
    if FFlagExpChatFixBackspaceNilTargetChannel and arg1.isGlobalTabActive then
        return Dictionary.join(tbl2, { targetTextChannel = None })
    end

    return Dictionary.join(tbl2, { targetTextChannel = tbl2.allTextChannels.RBXGeneral or tbl2.targetTextChannel })
end

tbl1[ChatInputBarActivatedWhisperMode.name] = function(tbl2, arg1)
    var1:trace(
        "ChatInputBarActivatedTeamMode - set targetTextChannel to {}",
        arg1.textChannel and arg1.textChannel.Name or "nil"
    )

    if arg1.textChannel == nil then
        return tbl2
    end

    local join = Dictionary.join
    local tbl3 = {
        allTextChannels = Dictionary.join(tbl2.allTextChannels, { [arg1.textChannel.Name] = arg1.textChannel }),
        targetTextChannel = arg1.textChannel
    }
    return join(tbl2, tbl3)
end

tbl1[PlayerRemoved.name] = function(tbl2, arg1)
    local function isRemovedPlayerInWhisperChannel(arg2) -- Luacid: Inlined by compiler; 2 call sites recovered
        return string.find(arg2, "RBXWhisper:") and string.find(arg2, arg1.userId)
    end

    local targetTextChannel = tbl2.targetTextChannel

    if targetTextChannel and isRemovedPlayerInWhisperChannel(targetTextChannel.Name) then
        targetTextChannel = tbl2.allTextChannels.RBXGeneral
    end

    local allTextChannels = Dictionary.filter(tbl2.allTextChannels, function(_, arg2): boolean
        return not isRemovedPlayerInWhisperChannel(arg2)
    end)

    return Dictionary.join(tbl2, { targetTextChannel = targetTextChannel, allTextChannels = allTextChannels })
end

tbl1[UniverseChatChannelSelected.name] = function(tbl2, arg1)
    var1:trace("UniverseChatChannelSelected dispatched: {}", arg1.channelName)

    return Dictionary.join(tbl2, { targetTextChannel = None, selectedChannelName = arg1.channelName })
end

return createReducer({ allTextChannels = {}, targetTextChannel = nil, selectedChannelName = nil, currentTeam = nil }, tbl1)
