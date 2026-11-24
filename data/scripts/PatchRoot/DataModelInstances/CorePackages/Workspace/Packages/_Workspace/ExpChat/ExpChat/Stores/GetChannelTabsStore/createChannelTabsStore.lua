-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent
local Signals = require(ExpChatParent.Signals)
local tutils = require(ExpChatParent.tutils)
local ExpChatShared = require(ExpChatParent.ExpChatShared)
local shouldRenderTextChannelInDefaultWindow = ExpChatShared.shouldRenderTextChannelInDefaultWindow
local getTextChannelDisplayMode = ExpChatShared.getTextChannelDisplayMode
local FriendsChatTabName = require(ExpChatParent.FriendsChat.FriendsChatTabName)

local shouldSuppressUnreadForTabMetadata = require(ExpChat.shouldSuppressUnreadForTabMetadata)

local SharedFlags = require(ExpChatParent.SharedFlags)

local getFFlagExpChatFixChannelTabsMidExperienceToggle = require(ExpChat.Flags.getFFlagExpChatFixChannelTabsMidExperienceToggle)
local GetFFlagTextChatEnableUniverseChatTabs = ExpChatShared.Flags.GetFFlagTextChatEnableUniverseChatTabs

local GetFFlagExpChatSuppressWelcomeMessageTabUnread = ExpChatShared.Flags.GetFFlagExpChatSuppressWelcomeMessageTabUnread
local FFlagExpChatFriendsTabRequireDefaultChannels = SharedFlags.FFlagExpChatFriendsTabRequireDefaultChannels

local isGlobalTabFirst = require(ExpChat.isGlobalTabFirst)
local getDefaultTabName = require(ExpChat.getDefaultTabName)
local FFlagExpChatGlobalTabDefault = require(ExpChat.Flags.FFlagExpChatGlobalTabDefault)
local FFlagExpChatStickyTabs = SharedFlags.FFlagExpChatStickyTabs

local isUserSelectedTabTracked = require(ExpChat.isUserSelectedTabTracked)
local canReplaceUserSelectedTab = require(ExpChat.canReplaceUserSelectedTab)

local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local getFixedTabPriority = nil

local function reorderTabs(tbl1)
    local var1 = table.clone(tbl1)

    local tbl2 = {}
    for _, value in pairs(var1) do
        table.insert(tbl2, value)
    end

    table.sort(tbl2, function(arg1, arg2): boolean
        local fixedTabPriority = getFixedTabPriority(arg1.name)
        local fixedTabPriority2 = getFixedTabPriority(arg2.name)

        if fixedTabPriority and fixedTabPriority2 then
            return fixedTabPriority < fixedTabPriority2
        end

        if fixedTabPriority then
            return true
        end

        if fixedTabPriority2 then
            return false
        end

        return arg1.tabIndex < arg2.tabIndex
    end)

    for tabIndex, value in ipairs(tbl2) do
        local name = value.name
        var1[name] = {
            type = value.type,
            name = value.name,
            tabIndex = tabIndex,
            HasUnreadMessages = value.HasUnreadMessages
        }
    end

    return var1
end

local function insertTabAndReorder(tbl1, tbl2) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = table.clone(tbl1)
    var1[tbl2.name] = tbl2

    return (reorderTabs(var1))
end

local function removeTabAndReorder(allChannelTabs, allChannelTab) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = table.clone(allChannelTabs)
    var1[allChannelTab.name] = nil

    return (reorderTabs(var1))
end

getFixedTabPriority = function(str1: string?)
    if FFlagExpChatGlobalTabDefault and isGlobalTabFirst() then
        if str1 == "RBXGlobal" then
            return 1
        elseif str1 == "RBXGeneral" then
            return 2
        end

        if str1 == FriendsChatTabName then
            return 3
        end

        return nil
    end

    if str1 == "RBXGeneral" then
        return 1
    end

    if str1 == "RBXGlobal" and GetFFlagTextChatEnableUniverseChatTabs() then
        return 2
    end

    if str1 == FriendsChatTabName then
        return 3
    end

    return nil
end

local function pruneNonSpecialTabs(allChannelTabs)
    local tbl1 = ({})

    for k, allChannelTab in allChannelTabs do
        if getFixedTabPriority(k) ~= nil then
            tbl1[k] = allChannelTab
        end
    end

    return (reorderTabs(tbl1))
end

local function isDefaultTabOnlyMode(tbl1) -- Luacid: Inlined by compiler; 4 call sites recovered
    return (GetFFlagTextChatEnableUniverseChatTabs() or FFlagExpChatFriendsTabRequireDefaultChannels)
        and not tbl1.channelTabsConfigurationEnabled
end

local function markTabUnread(tbl1, selectedTabName: string)
    local allChannelTab = tbl1.allChannelTabs[selectedTabName]
    if allChannelTab == nil or allChannelTab.HasUnreadMessages or selectedTabName == tbl1.selectedTabName then
        return tbl1
    end

    local var1 = table.clone(tbl1)
    var1.allChannelTabs = table.clone(tbl1.allChannelTabs)
    local var2 = table.clone(allChannelTab)
    var2.HasUnreadMessages = true
    var1.allChannelTabs[selectedTabName] = var2
    return var1
end

local function isTargetChannelNoOp(tbl1, selectedTabName: string?, bool1: boolean, bool2: boolean?)
    if isUserSelectedTabTracked() and bool2 and not tbl1.hasUserSelectedTab then
        return false
    end

    local allChannelTab = if selectedTabName then tbl1.allChannelTabs[selectedTabName] else nil

    if not allChannelTab then
        return selectedTabName == nil
            or (if isDefaultTabOnlyMode(tbl1) and getFixedTabPriority(selectedTabName) == nil then true else tbl1.selectedTabName == selectedTabName)
    end

    local bool3 = not bool1
    return bool3
        and tbl1.selectedTabName == selectedTabName
        and (allChannelTab.type == "FriendsChat" or not allChannelTab.HasUnreadMessages)
end

local function createChannelTabsStore()
    local getChannelTabsState, var2 = createSignal(
        {
            allChannelTabs = {},
            selectedTabName = nil,
            channelTabsConfigurationEnabled = false,
            hasUserSelectedTab = false
        }
    )
    local var3 = nil

    return {
        getChannelTabsState = getChannelTabsState,
        getSelectedTabName = createComputed(function(arg1)
            return getChannelTabsState(arg1).selectedTabName
        end),
        getUnreadChannels = createComputed(function(arg1)
            local var4 = getChannelTabsState(arg1)
            local result = ({})

            for k, allChannelTab in pairs(var4.allChannelTabs) do
                if allChannelTab.HasUnreadMessages then
                    result[k] = true
                end
            end

            return result
        end, tutils.deepEqual),
        handleIncomingOrOutgoingMessage = function(arg1, bool1: boolean, str1: string?)
            if not GetFFlagTextChatEnableUniverseChatTabs() and not arg1.TextChannel
                or bool1
                or GetFFlagExpChatSuppressWelcomeMessageTabUnread() and shouldSuppressUnreadForTabMetadata(arg1.Metadata)
            then
                return
            end

            local var4 = nil
            if GetFFlagTextChatEnableUniverseChatTabs() then
                if str1 then
                    var4 = str1
                else
                    if not arg1.TextChannel then
                        return
                    end

                    var4 = arg1.TextChannel.Name
                end
            end

            var2(function(arg2)
                if not GetFFlagTextChatEnableUniverseChatTabs() then
                    local textChannel = arg1.TextChannel
                    if textChannel == nil then
                        return arg2
                    end
                    var4 = textChannel.Name
                end

                if var4 == "RBXSystem" then
                    var4 = "RBXGeneral"
                end

                return (markTabUnread(arg2, var4))
            end)
        end,
        setSelectedTab = function(selectedTabName: string)
            var2(function(arg1)
                local allChannelTab = arg1.allChannelTabs[selectedTabName]
                if arg1.selectedTabName == selectedTabName and (allChannelTab == nil or not allChannelTab.HasUnreadMessages) then
                    return arg1
                end

                local var4 = table.clone(arg1)
                var4.selectedTabName = selectedTabName

                if var4.allChannelTabs[selectedTabName] then
                    var4.allChannelTabs = table.clone(var4.allChannelTabs)
                    local var5 = table.clone(var4.allChannelTabs[selectedTabName])
                    var5.HasUnreadMessages = false
                    var4.allChannelTabs[selectedTabName] = var5
                end

                return var4
            end)
        end,
        setTargetChannel = function(selectedTabName: string?, bool1: boolean, bool2: boolean?)
            var2(function(arg1)
                if isTargetChannelNoOp(arg1, selectedTabName, bool1, bool2) then
                    return arg1
                end

                local var4 = table.clone(arg1)

                if isUserSelectedTabTracked() and bool2 then
                    var4.hasUserSelectedTab = true
                end

                if not (selectedTabName and var4.allChannelTabs[selectedTabName]) then
                    if selectedTabName == nil or isDefaultTabOnlyMode(var4) and getFixedTabPriority(selectedTabName) == nil then
                        return var4
                    end
                    var4.selectedTabName = selectedTabName

                    return var4
                end

                local allChannelTab = var4.allChannelTabs[selectedTabName]

                local tbl1 = {
                    type = allChannelTab.type,
                    name = allChannelTab.name,
                    tabIndex = if bool1 then 0 else allChannelTab.tabIndex,
                    HasUnreadMessages = allChannelTab.type == "FriendsChat" and allChannelTab.HasUnreadMessages
                }

                var4.allChannelTabs = insertTabAndReorder(var4.allChannelTabs, tbl1)
                var4.selectedTabName = allChannelTab.name
                return var4
            end)
        end,
        addChannelTab = function(arg1, tabIndex: number?)
            local name = arg1.name

            var2(function(arg2)
                if arg2.allChannelTabs[name] ~= nil then
                    return arg2
                end

                if arg1.type == "TextChat" and name ~= "RBXGeneral" and isDefaultTabOnlyMode(arg2) then
                    return arg2
                end

                local var4 = table.clone(arg2)

                local allChannelTabs = var4.allChannelTabs
                if tabIndex ~= nil then
                    allChannelTabs = {}
                    for k, allChannelTab in var4.allChannelTabs do
                        if allChannelTab.tabIndex >= tabIndex then
                            local var5 = table.clone(allChannelTab)
                            var5.tabIndex = allChannelTab.tabIndex + 1
                            allChannelTabs[k] = var5
                        else
                            allChannelTabs[k] = allChannelTab
                        end
                    end
                end

                var4.allChannelTabs = insertTabAndReorder(
                    allChannelTabs,
                    {
                        type = arg1.type,
                        name = name,
                        tabIndex = tabIndex or 0,
                        HasUnreadMessages = false
                    }
                )

                local fixedTabPriority = getFixedTabPriority(name)
                local fixedTabPriority2 = getFixedTabPriority(var4.selectedTabName)

                if var4.selectedTabName == nil then
                    if arg1.type ~= "TextChat" then
                        if FFlagExpChatGlobalTabDefault then
                            var4.selectedTabName = getDefaultTabName(var4.allChannelTabs) or name
                            return var4
                        end
                        var4.selectedTabName = if var4.allChannelTabs.RBXGeneral then "RBXGeneral" else name
                        return var4
                    end
                elseif fixedTabPriority ~= nil
                    and fixedTabPriority < (fixedTabPriority2 or math.huge)
                    and fixedTabPriority2 ~= nil
                    and canReplaceUserSelectedTab(var4.hasUserSelectedTab)
                    and (not FFlagExpChatGlobalTabDefault or not isGlobalTabFirst() or name ~= "RBXGlobal" or not var4.hasUserSelectedTab)
                then
                    var4.selectedTabName = name
                end

                return var4
            end)

            if FFlagExpChatStickyTabs and var3 and getChannelTabsState(false).allChannelTabs[name] then
                var3(name)
            end
        end,
        handleLocalTextChannelParticipantAdded = function(arg1)
            if arg1.Name == "RBXSystem" or not shouldRenderTextChannelInDefaultWindow(arg1, getTextChannelDisplayMode()) then
                return
            end

            local tbl1 = {
                type = "TextChat",
                name = arg1.Name
            }
            local name = tbl1.name

            local tabIndex = nil

            var2(function(arg2)
                if arg2.allChannelTabs[name] ~= nil then
                    return arg2
                end

                if tbl1.type == "TextChat" and name ~= "RBXGeneral" and isDefaultTabOnlyMode(arg2) then
                    return arg2
                end

                local var5 = table.clone(arg2)

                local allChannelTabs = var5.allChannelTabs
                if tabIndex ~= nil then
                    allChannelTabs = {}
                    for k, allChannelTab in var5.allChannelTabs do
                        if allChannelTab.tabIndex >= tabIndex then
                            local var6 = table.clone(allChannelTab)
                            var6.tabIndex = allChannelTab.tabIndex + 1
                            allChannelTabs[k] = var6
                        else
                            allChannelTabs[k] = allChannelTab
                        end
                    end
                end

                var5.allChannelTabs = insertTabAndReorder(
                    allChannelTabs,
                    {
                        type = tbl1.type,
                        name = name,
                        tabIndex = tabIndex or 0,
                        HasUnreadMessages = false
                    }
                )

                local fixedTabPriority = getFixedTabPriority(name)
                local fixedTabPriority2 = getFixedTabPriority(var5.selectedTabName)

                if var5.selectedTabName == nil then
                    if tbl1.type ~= "TextChat" then
                        if FFlagExpChatGlobalTabDefault then
                            var5.selectedTabName = getDefaultTabName(var5.allChannelTabs) or name
                            return var5
                        end
                        var5.selectedTabName = if var5.allChannelTabs.RBXGeneral then "RBXGeneral" else name
                        return var5
                    end
                elseif fixedTabPriority ~= nil
                    and fixedTabPriority < (fixedTabPriority2 or math.huge)
                    and fixedTabPriority2 ~= nil
                    and canReplaceUserSelectedTab(var5.hasUserSelectedTab)
                    and (not FFlagExpChatGlobalTabDefault or not isGlobalTabFirst() or name ~= "RBXGlobal" or not var5.hasUserSelectedTab)
                then
                    var5.selectedTabName = name
                end

                return var5
            end)

            if FFlagExpChatStickyTabs and var3 and getChannelTabsState(false).allChannelTabs[name] then
                var3(name)
            end
        end,
        handleChannelRemoved = function(str1: string)
            var2(function(arg1)
                local allChannelTab = arg1.allChannelTabs[str1]
                if allChannelTab == nil then
                    return arg1
                end

                local var4 = table.clone(arg1)

                var4.allChannelTabs = removeTabAndReorder(var4.allChannelTabs, allChannelTab)

                if allChannelTab.name == var4.selectedTabName then
                    if FFlagExpChatGlobalTabDefault then
                        var4.selectedTabName = getDefaultTabName(var4.allChannelTabs)
                    else
                        var4.selectedTabName = if var4.allChannelTabs.RBXGeneral then "RBXGeneral" else nil
                    end
                end

                if var4.selectedTabName and var4.allChannelTabs[var4.selectedTabName] then
                    var4.allChannelTabs = table.clone(var4.allChannelTabs)
                    local var5 = table.clone(var4.allChannelTabs[var4.selectedTabName])
                    var5.HasUnreadMessages = false
                    var4.allChannelTabs[var4.selectedTabName] = var5
                end

                return var4
            end)
        end,
        markChannelUnread = function(selectedTabName: string)
            var2(function(arg1)
                return (markTabUnread(arg1, selectedTabName))
            end)
        end,
        setChannelUnreadStatus = function(str1: string, hasUnreadMessages: boolean)
            var2(function(arg1)
                local allChannelTab = arg1.allChannelTabs[str1]
                if allChannelTab == nil or allChannelTab.HasUnreadMessages == hasUnreadMessages then
                    return arg1
                end

                local var4 = table.clone(arg1)
                var4.allChannelTabs = table.clone(var4.allChannelTabs)
                local var5 = table.clone(var4.allChannelTabs[str1])
                var5.HasUnreadMessages = hasUnreadMessages
                var4.allChannelTabs[str1] = var5
                return var4
            end)
        end,
        setChannelTabsConfigurationEnabled = function(channelTabsConfigurationEnabled: boolean)
            var2(function(arg1)
                if not GetFFlagTextChatEnableUniverseChatTabs() then
                    return arg1
                end

                if not getFFlagExpChatFixChannelTabsMidExperienceToggle() or channelTabsConfigurationEnabled then
                    local var4 = table.clone(arg1)
                    var4.channelTabsConfigurationEnabled = channelTabsConfigurationEnabled
                    return var4
                end

                local allChannelTabs = pruneNonSpecialTabs(arg1.allChannelTabs)

                local selectedTabName = arg1.selectedTabName
                if selectedTabName == nil or allChannelTabs[selectedTabName] == nil then
                    if FFlagExpChatGlobalTabDefault then
                        selectedTabName = getDefaultTabName(allChannelTabs) or (if allChannelTabs.RBXGlobal then "RBXGlobal" else nil)
                    else
                        selectedTabName = if allChannelTabs.RBXGeneral then "RBXGeneral" elseif allChannelTabs.RBXGlobal then "RBXGlobal" else nil
                    end
                end

                if selectedTabName and allChannelTabs[selectedTabName] then
                    allChannelTabs[selectedTabName].HasUnreadMessages = false
                end

                return {
                    allChannelTabs = allChannelTabs,
                    selectedTabName = selectedTabName,
                    channelTabsConfigurationEnabled = false,
                    hasUserSelectedTab = arg1.hasUserSelectedTab
                }
            end)
        end,
        setOnChannelTabAdded = function(func1: ((...any) -> (...any))?)
            var3 = func1
        end
    }
end
return createChannelTabsStore
