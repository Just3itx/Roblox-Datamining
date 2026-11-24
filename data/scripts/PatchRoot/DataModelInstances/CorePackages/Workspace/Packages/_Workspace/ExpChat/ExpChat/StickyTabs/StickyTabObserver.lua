-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local TextChatService = game:GetService("TextChatService")

local Signals = require(ExpChatParent.Signals)
local _ExpChatShared = require(ExpChatParent.ExpChatShared)
local FriendsChatTabName = require(ExpChatParent.FriendsChat.FriendsChatTabName)
local FFlagExpChatUseChannelTabsStore = require(ExpChatParent.SharedFlags).FFlagExpChatUseChannelTabsStore

local GetChannelTabsStore = require(ExpChat.Stores.GetChannelTabsStore)
local perUserAppStorage = require(ExpChat.Utils.perUserAppStorage)
local _StickyTabsStore = require(script.Parent.StickyTabsStore)
local selectTabByType = require(ExpChat.TabNavigation.selectTabByType)
local hasUserSelectedTab = require(ExpChat.mountClientApp.helpers.hasUserSelectedTab)

local num1 = game:DefineFastInt("ExpChatStickyTabTimeLimitSeconds", 10)

local module = ({})

local var1 = nil
local var2 = nil
local connection = nil
local var3 = nil

local num2 = 0

local function isCustomChannel(tabName: string): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return not (tabName == "RBXGeneral" or tabName == "RBXGlobal") and tabName ~= FriendsChatTabName
end

local function save(tabName: string) -- Luacid: Inlined by compiler; 3 call sites recovered
    local gameId = game.GameId
    perUserAppStorage.updateEntry("ExpChatStickyTab", function(tbl1): {experienceId: number, tabName: string}?
        return if tbl1.tabName == tabName and tbl1.experienceId == gameId then nil else {
            tabName = tabName,
            experienceId = gameId
        }
    end)
end

local function getTabType(channelName: string): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if channelName == "RBXGlobal" then "UniverseChat" elseif channelName == FriendsChatTabName then "FriendsChat" else "TextChat"
end

local function getAllChannelTabs(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    if FFlagExpChatUseChannelTabsStore then
        return GetChannelTabsStore(false).getChannelTabsState(false).allChannelTabs
    end

    return arg1:getState().ChannelTabs.allChannelTabs
end

local function getStickyTab(entry) -- Luacid: Inlined by compiler; 1 call site recovered
    if type(entry) ~= "table" then
        return nil
    end
    local tabName = entry.tabName

    if type(tabName) == "string" then
        if isCustomChannel(tabName) and entry.experienceId ~= game.GameId then
            return nil
        end

        return tabName
    end

    return nil
end

local function watchForTabChanges(arg1)
    if FFlagExpChatUseChannelTabsStore then
        local channelTabsStore = GetChannelTabsStore(false)
        local effect = Signals.createEffect(function(arg2)
            local selectedTabName = channelTabsStore.getSelectedTabName(arg2)
            if selectedTabName ~= nil then
                save(selectedTabName)
            end
        end)

        channelTabsStore.setOnChannelTabAdded(function(channelName)
            module:goToStickyTab(channelName)
        end)
        var2 = function()
            effect()
            channelTabsStore.setOnChannelTabAdded(nil)
        end

        return
    end

    local connection2 = arg1.changed:connect(function(arg2, arg3)
        local selectedTabName = arg2.ChannelTabs.selectedTabName
        if selectedTabName ~= nil and selectedTabName ~= arg3.ChannelTabs.selectedTabName then
            save(selectedTabName)
        end
    end)

    var2 = function()
        connection2:disconnect()
    end

    local selectedTabName = arg1:getState().ChannelTabs.selectedTabName
    if selectedTabName ~= nil then
        save(selectedTabName)
    end
end

local function watchForDeveloperDefault()
    local chatInputBarConfiguration = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
    if chatInputBarConfiguration == nil then
        return
    end
    local function onTargetChanged() -- Luacid: Inlined by compiler; 1 call site recovered
        local targetTextChannel = chatInputBarConfiguration.TargetTextChannel

        if targetTextChannel and targetTextChannel.Name ~= "RBXGeneral" and targetTextChannel.Name ~= var3 then
            var3 = nil
        end
    end

    onTargetChanged()
    connection = chatInputBarConfiguration:GetPropertyChangedSignal("TargetTextChannel"):Connect(onTargetChanged)
end

function module.start(arg1, arg2)
    arg1:stop()
    var1 = arg2
    num2 = os.clock()

    var3 = getStickyTab((perUserAppStorage.getEntry("ExpChatStickyTab")))

    watchForTabChanges(arg2)
    watchForDeveloperDefault()

    local var4 = var3

    if var4 ~= nil and getAllChannelTabs(arg2)[var4] then
        arg1:goToStickyTab(var4)
    end
end

function module.goToStickyTab(_, channelName: string)
    if channelName ~= var3 then
        return
    end

    local var4 = var1

    if var4 == nil or not getAllChannelTabs(var4)[channelName] then
        return
    end

    local num3 = os.clock() - num2

    if num1 < num3 or hasUserSelectedTab(var4) then
        var3 = nil
        return
    end

    task.defer(function()
        if var1 ~= var4 or var3 ~= channelName then
            return
        end
        var3 = nil
        if hasUserSelectedTab(var4) or not getAllChannelTabs(var4)[channelName] then
            return
        end
        selectTabByType(function(arg1)
            return var4:dispatch(arg1)
        end, {
            channelName = channelName,
            tabType = getTabType(channelName),
            shouldReorderTabs = false,
            textChannel = var4:getState().TextChannels.allTextChannels[channelName]
        })
    end)
end

function module.stop(_)
    var3 = nil
    var1 = nil
    if connection then
        connection:Disconnect()
        connection = nil
    end
    local var4 = var2
    if var4 then
        var2 = nil
        var4()
    end
end

return module
