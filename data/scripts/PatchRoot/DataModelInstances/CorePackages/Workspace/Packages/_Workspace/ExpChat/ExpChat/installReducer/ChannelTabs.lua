-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Rodux = require(ExpChatParent.Rodux)
local Dictionary = require(ExpChatParent.llama).Dictionary
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local shouldRenderTextChannelInDefaultWindow = ExpChatShared.shouldRenderTextChannelInDefaultWindow
local getTextChannelDisplayMode = ExpChatShared.getTextChannelDisplayMode
local SharedFlags = require(ExpChatParent.SharedFlags)

local var1 = ExpChatShared.Logger:new("ExpChat/Reducers/" .. script.Name)

local Actions = ExpChat.Actions
local LocalTextChannelParticipantAdded = require(Actions.LocalTextChannelParticipantAdded)
local LocalTextChannelParticipantRemoved = ExpChatShared.Actions.LocalTextChannelParticipantRemoved
local TextChannelRemoved = ExpChatShared.Actions.TextChannelRemoved
local TargetTextChannelPropertyChanged = ExpChatShared.Actions.TargetTextChannelPropertyChanged
local TextChatChannelSelected = ExpChatShared.Actions.TextChatChannelSelected
local IncomingMessageReceived = require(Actions.IncomingMessageReceived)
local UniverseChatSystemMessageAdded = require(Actions.UniverseChatSystemMessageAdded)
local UniverseChatChannelAdded = require(Actions.UniverseChatChannelAdded)
local UniverseChatChannelSelected = ExpChatShared.Actions.UniverseChatChannelSelected
local FriendsChatChannelAdded = require(Actions.FriendsChatChannelAdded)
local FriendsChatChannelRemoved = require(Actions.FriendsChatChannelRemoved)
local FriendsChatChannelSelected = ExpChatShared.Actions.FriendsChatChannelSelected
local FriendsChatTabName = require(ExpChatParent.FriendsChat.FriendsChatTabName)
local MarkChannelUnreadForSystemMessage = require(Actions.MarkChannelUnreadForSystemMessage)
local MarkChannelUnreadForIncomingMessage = require(Actions.MarkChannelUnreadForIncomingMessage)
local SetChannelUnreadStatus = require(Actions.SetChannelUnreadStatus)

local FFlagExpChatUnreadTabIndicatorV2Window = require(ExpChat.Flags.FFlagExpChatUnreadTabIndicatorV2Window)

local getFFlagExpChatFixChannelTabsMidExperienceToggle = require(ExpChat.Flags.getFFlagExpChatFixChannelTabsMidExperienceToggle)
local FFlagExpChatFriendsTabRequireDefaultChannels = SharedFlags.FFlagExpChatFriendsTabRequireDefaultChannels
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs

local GetFFlagExpChatSuppressWelcomeMessageTabUnread = ExpChatShared.Flags.GetFFlagExpChatSuppressWelcomeMessageTabUnread

local ChannelTabsConfigurationEnabled = require(Actions.ChannelTabsConfigurationEnabled)
local shouldSuppressUnreadForTabMetadata = require(ExpChat.shouldSuppressUnreadForTabMetadata)
local isGlobalTabFirst = require(ExpChat.isGlobalTabFirst)
local getDefaultTabName = require(ExpChat.getDefaultTabName)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)
local FFlagExpChatStickyTabs = SharedFlags.FFlagExpChatStickyTabs

local isUserSelectedTabTracked = require(ExpChat.isUserSelectedTabTracked)
local canReplaceUserSelectedTab = require(ExpChat.canReplaceUserSelectedTab)

local tbl1 = {
    allChannelTabs = {},
    selectedTabName = nil,
    channelTabsConfigurationEnabled = false,
    hasUserSelectedTab = false
}

local function insertTabAndReorder(tbl2, tbl3)
    local tbl4 = {
        [tbl3.Name] = tbl3
    }

    for value, value2 in tbl2 do
        local var2 = value2.TabIndex < tbl3.TabIndex and value2.TabIndex or value2.TabIndex + 1
        tbl4 = Dictionary.join(tbl4, { [value] = Dictionary.set(tbl2[value], "TabIndex", var2) })
    end

    return tbl4
end

local function hasFriendsTab(tbl2): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    return tbl2[FriendsChatTabName] ~= nil
end

local function priorityTabCount(tbl2): number -- Luacid: Inlined by compiler; 1 call site recovered
    return (if tbl2.RBXGeneral ~= nil then 1 else 0) + (if GetFFlagTextChatEnableUniverseChatTabs() and tbl2.RBXGlobal ~= nil then 1 else 0) + (if hasFriendsTab(tbl2) then 1 else 0)
end

local function nextDeveloperTabIndex(allChannelTabs): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return priorityTabCount(allChannelTabs) + 1
end

local function getPlatformTabIndex(str1: string, allChannelTabs): number -- Luacid: Inlined by compiler; 7 call sites recovered
    if FFlagExpChatGlobalTabDefault and isGlobalTabFirst() then
        if str1 == "RBXGlobal" then
            return 1
        end

        if allChannelTabs.RBXGlobal then
            return 2
        end

        return 1
    end

    if str1 == "RBXGeneral" then
        return 1
    end

    if allChannelTabs.RBXGeneral then
        return 2
    end

    return 1
end

local function getFriendsTabIndex(allChannelTabs): number -- Luacid: Inlined by compiler; 1 call site recovered
    local bool1 = allChannelTabs.RBXGeneral ~= nil
    local var2 = GetFFlagTextChatEnableUniverseChatTabs() and allChannelTabs.RBXGlobal ~= nil
    return (if bool1 then 1 else 0) + 1 + (if var2 then 1 else 0)
end

local function removeTabAndReorder(allChannelTabs, allChannelTab)
    if allChannelTab == nil then
        return allChannelTabs
    end

    local result = {}

    for k, allChannelTab2 in allChannelTabs do
        if k ~= allChannelTab.Name then
            local var2 = allChannelTab2.TabIndex < allChannelTab.TabIndex and allChannelTab2.TabIndex or allChannelTab2.TabIndex - 1
            result = Dictionary.join(result, { [k] = Dictionary.set(allChannelTabs[k], "TabIndex", var2) })
        end
    end

    return result
end

local function removeChannelTab(tbl2, str1: string)
    local allChannelTab = tbl2.allChannelTabs[str1]
    if allChannelTab == nil then
        return tbl2
    end

    local var2 = removeTabAndReorder(tbl2.allChannelTabs, allChannelTab)
    local selectedTabName = if allChannelTab.Name ~= tbl2.selectedTabName then tbl2.selectedTabName elseif FFlagExpChatGlobalTabDefault then getDefaultTabName(var2) elseif var2.RBXGeneral then "RBXGeneral" else nil
    local tbl3 = {
        allChannelTabs = 0,
        selectedTabName = 0,
        channelTabsConfigurationEnabled = 0,
        hasUserSelectedTab = 0
    }

    if selectedTabName and var2[selectedTabName] then
        var2 = Dictionary.join(var2, { [selectedTabName] = Dictionary.join(var2[selectedTabName], { HasUnreadMessages = false }) })
    end

    tbl3.allChannelTabs = var2

    tbl3.selectedTabName = selectedTabName
    tbl3.channelTabsConfigurationEnabled = tbl2.channelTabsConfigurationEnabled
    tbl3.hasUserSelectedTab = if isUserSelectedTabTracked() then tbl2.hasUserSelectedTab else nil
    return tbl3
end

local function onChannelRemoved(tbl2, textChannel) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (removeChannelTab(tbl2, textChannel.Name))
end

local function handleIncomingMessageReceived(tbl2, arg1)
    var1:trace("IncomingMessageReceived dispatched")

    local channelNameOverride = nil
    if GetFFlagTextChatEnableUniverseChatTabs() and arg1.channelNameOverride then
        channelNameOverride = arg1.channelNameOverride
    elseif arg1.textChatMessage.TextChannel then
        local textChannelName = arg1.textChatMessage.TextChannel.Name
        channelNameOverride = if arg1.textChatMessage.TextChannel.Name == "RBXSystem" then "RBXGeneral" else textChannelName
    end

    local allChannelTab = tbl2.allChannelTabs[channelNameOverride]
    if allChannelTab == nil then
        return tbl2
    end

    if arg1.isSenderLocalPlayer or allChannelTab.Name == tbl2.selectedTabName then
        return tbl2
    end

    if GetFFlagExpChatSuppressWelcomeMessageTabUnread() and shouldSuppressUnreadForTabMetadata(arg1.textChatMessage.Metadata) then
        return tbl2
    end

    local join = Dictionary.join
    local tbl3 = {
        allChannelTabs = Dictionary.join(
            tbl2.allChannelTabs,
            {
                [allChannelTab.Name] = Dictionary.join(allChannelTab, { HasUnreadMessages = true })
            }
        )
    }
    return join(tbl2, tbl3)
end

local function handleUniverseChatSystemMessageAdded(tbl2, arg1)
    if not GetFFlagTextChatEnableUniverseChatTabs() then
        return tbl2
    end

    local channelNameOverride = arg1.channelNameOverride
    local allChannelTab = tbl2.allChannelTabs[channelNameOverride]
    if allChannelTab == nil then
        return tbl2
    end

    if allChannelTab.Name == tbl2.selectedTabName then
        return tbl2
    end

    if GetFFlagExpChatSuppressWelcomeMessageTabUnread() and shouldSuppressUnreadForTabMetadata(arg1.metadata or "") then
        return tbl2
    end

    local join = Dictionary.join
    local tbl3 = {
        allChannelTabs = Dictionary.join(
            tbl2.allChannelTabs,
            {
                [allChannelTab.Name] = Dictionary.join(allChannelTab, { HasUnreadMessages = true })
            }
        )
    }
    return join(tbl2, tbl3)
end

local function pruneNonSpecialTabs(allChannelTabs)
    local result = ({})

    local bool1 = allChannelTabs.RBXGeneral ~= nil
    if bool1 then
        if FFlagExpChatGlobalTabDefault then
            result.RBXGeneral = Dictionary.set(allChannelTabs.RBXGeneral, "TabIndex", (getPlatformTabIndex("RBXGeneral", allChannelTabs)))
        else
            result.RBXGeneral = Dictionary.set(allChannelTabs.RBXGeneral, "TabIndex", 1)
        end
    end

    if allChannelTabs.RBXGlobal ~= nil then
        if FFlagExpChatGlobalTabDefault then
            result.RBXGlobal = Dictionary.set(allChannelTabs.RBXGlobal, "TabIndex", (getPlatformTabIndex("RBXGlobal", allChannelTabs)))
        else
            result.RBXGlobal = Dictionary.set(allChannelTabs.RBXGlobal, "TabIndex", if bool1 then 2 else 1)
        end
    end

    if hasFriendsTab(allChannelTabs) then
        result[FriendsChatTabName] = allChannelTabs[FriendsChatTabName]
    end

    return result
end

local function isDefaultTabOnlyMode(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (GetFFlagTextChatEnableUniverseChatTabs() or FFlagExpChatFriendsTabRequireDefaultChannels)
        and not tbl2.channelTabsConfigurationEnabled
end

local function selectTextChannelTabByName(tbl2, selectedTabName: string?, shouldReorderTabs: boolean)
    if selectedTabName and tbl2.allChannelTabs[selectedTabName] then
        local allChannelTab = tbl2.allChannelTabs[selectedTabName]

        local tabIndex = allChannelTab.TabIndex
        if shouldReorderTabs then
            if allChannelTab.Name == "RBXGeneral" then
                tabIndex = if FFlagExpChatGlobalTabDefault then getPlatformTabIndex("RBXGeneral", tbl2.allChannelTabs) else 1
            elseif GetFFlagTextChatEnableUniverseChatTabs() and allChannelTab.Name == "RBXGlobal" then
                if FFlagExpChatGlobalTabDefault then
                    tabIndex = getPlatformTabIndex("RBXGlobal", tbl2.allChannelTabs)
                else
                    tabIndex = if tbl2.allChannelTabs.RBXGeneral then 2 else 1
                end
            else
                tabIndex = nextDeveloperTabIndex(tbl2.allChannelTabs)
            end
        end

        local var2 = Dictionary.join(allChannelTab, { HasUnreadMessages = false, TabIndex = tabIndex })

        return Dictionary.join(tbl2, {
            allChannelTabs = insertTabAndReorder(removeTabAndReorder(tbl2.allChannelTabs, allChannelTab), var2),
            selectedTabName = allChannelTab.Name
        })
    elseif isDefaultTabOnlyMode(tbl2) then
        return tbl2
    else
        return Dictionary.join(tbl2, { selectedTabName = selectedTabName })
    end
end

local createReducer = Rodux.createReducer
local tbl2 = {}
tbl2[ChannelTabsConfigurationEnabled.name] = function(tbl3, arg1)
    if not GetFFlagTextChatEnableUniverseChatTabs() then
        return tbl3
    end

    if not getFFlagExpChatFixChannelTabsMidExperienceToggle() or arg1.enabled then
        return Dictionary.join(tbl3, { channelTabsConfigurationEnabled = arg1.enabled })
    end

    local tbl4 = pruneNonSpecialTabs(tbl3.allChannelTabs)
    local selectedTabName = tbl3.selectedTabName
    if selectedTabName == nil or tbl4[selectedTabName] == nil then
        if FFlagExpChatGlobalTabDefault then
            selectedTabName = getDefaultTabName(tbl4) or (if tbl4.RBXGlobal then "RBXGlobal" else nil)
        else
            selectedTabName = if tbl4.RBXGeneral then "RBXGeneral" elseif tbl4.RBXGlobal then "RBXGlobal" else nil
        end
    end

    if selectedTabName and tbl4[selectedTabName] then
        tbl4 = Dictionary.join(tbl4, { [selectedTabName] = Dictionary.join(tbl4[selectedTabName], { HasUnreadMessages = false }) })
    end

    return {
        allChannelTabs = tbl4,
        selectedTabName = selectedTabName,
        channelTabsConfigurationEnabled = false,
        hasUserSelectedTab = if isUserSelectedTabTracked() then tbl3.hasUserSelectedTab else nil
    }
end

tbl2[LocalTextChannelParticipantAdded.name] = function(tbl3, arg1)
    local textChannelName = arg1.textChannel.Name

    var1:trace("LocalTextChannelParticipantAdded dispatched: {}", textChannelName)

    if tbl3.allChannelTabs[textChannelName] ~= nil
        or textChannelName == "RBXSystem"
        or not shouldRenderTextChannelInDefaultWindow(arg1.textChannel, getTextChannelDisplayMode())
        or isDefaultTabOnlyMode(tbl3) and textChannelName ~= "RBXGeneral"
    then
        return tbl3
    else
        local tbl4 = {
            Name = textChannelName,
            HasUnreadMessages = false,
            TabIndex = if textChannelName == "RBXGeneral" then if FFlagExpChatGlobalTabDefault then getPlatformTabIndex("RBXGeneral", tbl3.allChannelTabs) else 1 elseif GetFFlagTextChatEnableUniverseChatTabs() and textChannelName == "RBXGlobal" then if FFlagExpChatGlobalTabDefault then getPlatformTabIndex("RBXGlobal", tbl3.allChannelTabs) elseif tbl3.allChannelTabs.RBXGeneral then 2 else 1 else nextDeveloperTabIndex(tbl3.allChannelTabs)
        }
        tbl4.Type = "TextChat"

        local allChannelTabs = insertTabAndReorder(tbl3.allChannelTabs, tbl4)
        if GetFFlagTextChatEnableUniverseChatTabs() then
            local selectedTabName = tbl3.selectedTabName

            local var3 = canReplaceUserSelectedTab(tbl3.hasUserSelectedTab)
            if var3
                and selectedTabName == "RBXGlobal"
                and textChannelName == "RBXGeneral"
                and not (FFlagExpChatGlobalTabDefault and isGlobalTabFirst())
            then
                textChannelName = "RBXGeneral"
            elseif not var3 or selectedTabName ~= FriendsChatTabName or textChannelName ~= "RBXGeneral" and textChannelName ~= "RBXGlobal" then
                textChannelName = selectedTabName
            end

            return Dictionary.join(tbl3, { allChannelTabs = allChannelTabs, selectedTabName = textChannelName })
        elseif textChannelName == "RBXGeneral"
            and tbl3.selectedTabName == FriendsChatTabName
            and canReplaceUserSelectedTab(tbl3.hasUserSelectedTab)
        then
            return Dictionary.join(tbl3, { allChannelTabs = allChannelTabs, selectedTabName = "RBXGeneral" })
        else
            return Dictionary.join(tbl3, { allChannelTabs = allChannelTabs })
        end
    end
end

tbl2[LocalTextChannelParticipantRemoved.name] = function(tbl3, arg1)
    var1:trace("LocalTextChannelParticipantRemoved dispatched: {}", arg1.textChannel.Name)
    return (onChannelRemoved(tbl3, arg1.textChannel))
end

tbl2[TextChannelRemoved.name] = function(tbl3, arg1)
    var1:trace("TextChannelRemoved dispatched: {}", arg1.textChannel.Name)
    return (onChannelRemoved(tbl3, arg1.textChannel))
end

tbl2[TargetTextChannelPropertyChanged.name] = function(tbl3, arg1)
    var1:trace("TargetTextChannelPropertyChanged dispatched")
    local textChannelName = if arg1.textChannel then arg1.textChannel.Name else nil

    if not FFlagExpChatStickyTabs then
        return selectTextChannelTabByName(tbl3, textChannelName, arg1.shouldReorderTabs)
    end

    if arg1.isUserInitiated then
        tbl3 = Dictionary.join(tbl3, { hasUserSelectedTab = true })
    end
    return selectTextChannelTabByName(tbl3, textChannelName, arg1.shouldReorderTabs)
end

tbl2[TextChatChannelSelected.name] = function(tbl3, arg1)
    var1:trace("TextChatChannelSelected dispatched: {}", arg1.channelName)

    if isUserSelectedTabTracked() then
        return selectTextChannelTabByName(
            Dictionary.join(tbl3, { hasUserSelectedTab = true }),
            arg1.channelName,
            arg1.shouldReorderTabs
        )
    end
    return selectTextChannelTabByName(tbl3, arg1.channelName, arg1.shouldReorderTabs)
end

tbl2[IncomingMessageReceived.name] = handleIncomingMessageReceived

local name = MarkChannelUnreadForIncomingMessage.name

if not FFlagExpChatUnreadTabIndicatorV2Window then
    handleIncomingMessageReceived = nil
end

tbl2[name] = handleIncomingMessageReceived

tbl2[UniverseChatSystemMessageAdded.name] = handleUniverseChatSystemMessageAdded

local name2 = MarkChannelUnreadForSystemMessage.name

if not FFlagExpChatUnreadTabIndicatorV2Window then
    handleUniverseChatSystemMessageAdded = nil
end

tbl2[name2] = handleUniverseChatSystemMessageAdded

tbl2[UniverseChatChannelAdded.name] = function(tbl3, arg1)
    var1:trace("UniverseChatChannelAdded dispatched: {}", arg1.channelName)

    if tbl3.allChannelTabs[arg1.channelName] ~= nil then
        return tbl3
    end

    local tabIndex = arg1.tabIndex
    if GetFFlagTextChatEnableUniverseChatTabs() and arg1.channelName == "RBXGlobal" then
        if FFlagExpChatGlobalTabDefault then
            tabIndex = getPlatformTabIndex("RBXGlobal", tbl3.allChannelTabs)
        else
            tabIndex = if tbl3.allChannelTabs.RBXGeneral then 2 else 1
        end
    end
    local tbl4 = {
        Name = arg1.channelName,
        HasUnreadMessages = false,
        TabIndex = tabIndex
    }
    tbl4.Type = "UniverseChat"

    local allChannelTabs = insertTabAndReorder(tbl3.allChannelTabs, tbl4)
    local var3

    if GetFFlagTextChatEnableUniverseChatTabs() then
        var3 = tbl3.selectedTabName
        if var3 == nil then
            if FFlagExpChatGlobalTabDefault then
                var3 = getDefaultTabName(allChannelTabs) or arg1.channelName
            else
                var3 = if allChannelTabs.RBXGeneral then "RBXGeneral" else arg1.channelName
            end
        elseif FFlagExpChatGlobalTabDefault and isGlobalTabFirst() and arg1.channelName == "RBXGlobal" and not tbl3.hasUserSelectedTab
            or var3 == FriendsChatTabName and canReplaceUserSelectedTab(tbl3.hasUserSelectedTab)
        then
            var3 = arg1.channelName
        end
    else
        var3 = tbl3.selectedTabName or arg1.channelName
    end

    return Dictionary.join(tbl3, { allChannelTabs = allChannelTabs, selectedTabName = var3 })
end

tbl2[FriendsChatChannelAdded.name] = function(tbl3, arg1)
    var1:trace("FriendsChatChannelAdded dispatched: {}", arg1.channelName)

    if tbl3.allChannelTabs[arg1.channelName] ~= nil then
        return tbl3
    end

    local tbl4 = {
        Name = arg1.channelName,
        HasUnreadMessages = false,
        TabIndex = getFriendsTabIndex(tbl3.allChannelTabs),
        Type = "FriendsChat"
    }

    local allChannelTabs = insertTabAndReorder(tbl3.allChannelTabs, tbl4)
    local selectedTabName = tbl3.selectedTabName
    if selectedTabName == nil then
        if FFlagExpChatGlobalTabDefault then
            selectedTabName = getDefaultTabName(allChannelTabs) or arg1.channelName
        else
            selectedTabName = if allChannelTabs.RBXGeneral then "RBXGeneral" else arg1.channelName
        end
    end
    return Dictionary.join(tbl3, { allChannelTabs = allChannelTabs, selectedTabName = selectedTabName })
end

tbl2[FriendsChatChannelRemoved.name] = function(tbl3, arg1)
    var1:trace("FriendsChatChannelRemoved dispatched: {}", arg1.channelName)
    return (removeChannelTab(tbl3, arg1.channelName))
end

tbl2[FriendsChatChannelSelected.name] = function(tbl3, arg1)
    var1:trace("FriendsChatChannelSelected dispatched: {}", arg1.channelName)

    if FFlagExpChatStickyTabs then
        return Dictionary.join(tbl3, { selectedTabName = arg1.channelName, hasUserSelectedTab = true })
    end
    return Dictionary.join(tbl3, { selectedTabName = arg1.channelName })
end

tbl2[SetChannelUnreadStatus.name] = function(tbl3, arg1)
    local allChannelTab = tbl3.allChannelTabs[arg1.channelName]
    if allChannelTab == nil then
        return tbl3
    end

    local join = Dictionary.join
    local tbl4 = {
        allChannelTabs = Dictionary.join(
            tbl3.allChannelTabs,
            {
                [arg1.channelName] = Dictionary.join(allChannelTab, { HasUnreadMessages = arg1.hasUnreadMessages })
            }
        )
    }
    return join(tbl3, tbl4)
end

tbl2[UniverseChatChannelSelected.name] = function(tbl3, arg1)
    var1:trace("UniverseChatChannelSelected dispatched: {}", arg1.channelName)

    local allChannelTab = tbl3.allChannelTabs[arg1.channelName]
    if allChannelTab == nil then
        if isUserSelectedTabTracked() then
            return Dictionary.join(
                tbl3,
                {
                    selectedTabName = arg1.channelName,
                    hasUserSelectedTab = if arg1.isUserInitiated then true else nil
                }
            )
        end

        return Dictionary.join(tbl3, { selectedTabName = arg1.channelName })
    end

    local join = Dictionary.join
    local tbl4 = {
        allChannelTabs = Dictionary.join(
            tbl3.allChannelTabs,
            {
                [arg1.channelName] = Dictionary.join(allChannelTab, { HasUnreadMessages = false })
            }
        ),
        selectedTabName = arg1.channelName,
        hasUserSelectedTab = if isUserSelectedTabTracked() and arg1.isUserInitiated then true else nil
    }
    return join(tbl3, tbl4)
end

return createReducer(tbl1, tbl2)
