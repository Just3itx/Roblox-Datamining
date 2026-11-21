-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tabId = nil
local tbl1 = {}
local tbl2 = {}

local EventTypes = { TTI = "TTI", Interval = "Interval" }

local Events = {
    ChatWindowMountTTI = "ChatWindowMountTTI",
    ChatWindowTabSwitchTTI = "ChatWindowTabSwitchTTI",
    MessageSendToWindowRenderInterval = "MessageSendToWindowRenderInterval",
    MessageReceiveToWindowRenderInterval = "MessageReceiveToWindowRenderInterval",
    ChatWindowScrollInterval = "ChatWindowScrollInterval"
}

local EventConfig = {
    [Events.ChatWindowMountTTI] = {
        type = EventTypes.TTI,
        baseName = "ExpChat_ChatWindowMountTTI",
        canFinish = function(_): boolean
            return true
        end,
        onStart = function(_) end
    }
}

local tbl6 = {
    type = EventTypes.TTI,
    baseName = "ExpChat_ChatWindowTabSwitchTTI",
    canFinish = function(arg1): boolean
        return (arg1 and arg1.tabId) == tabId
    end,
    onStart = function(arg1)
        tabId = if arg1 then arg1.tabId else nil
    end
}

EventConfig[Events.ChatWindowTabSwitchTTI] = tbl6

local tbl7 = {
    type = EventTypes.Interval,
    name = "ExpChat_MessageSendToWindowRenderInterval",
    intervalMetrics = { "duration", "averageFPS", "longestFrameTime" },
    canStart = function(_): boolean
        local timestamp = tbl2.timestamp or 0
        return tbl2.id == nil or timestamp + 5 < os.clock()
    end,
    canFinish = function(arg1)
        return arg1 and arg1.messageId == tbl2.id
    end,
    onStart = function(arg1)
        if arg1 then
            tbl2 = {
                id = arg1.messageId,
                timestamp = os.clock()
            }
        end
    end,
    onFinish = function(_)
        tbl2 = {}
    end
}

EventConfig[Events.MessageSendToWindowRenderInterval] = tbl7

local tbl8 = {
    type = EventTypes.Interval,
    name = "ExpChat_MessageReceiveToWindowRenderInterval",
    intervalMetrics = { "duration", "averageFPS", "longestFrameTime" },
    canStart = function(_): boolean
        local timestamp = tbl1.timestamp or 0
        return tbl1.id == nil or timestamp + 5 < os.clock()
    end,
    canFinish = function(arg1)
        return arg1 and arg1.messageId == tbl1.id
    end,
    onStart = function(arg1)
        if arg1 then
            tbl1 = {
                id = arg1.messageId,
                timestamp = os.clock()
            }
        end
    end,
    onFinish = function(_)
        tbl1 = {}
    end
}

EventConfig[Events.MessageReceiveToWindowRenderInterval] = tbl8

EventConfig[Events.ChatWindowScrollInterval] = {
    type = EventTypes.Interval,
    name = "ExpChat_ChatWindowScrollInterval",
    intervalMetrics = { "averageFPS", "longestFrameTime" },
    canStart = function(): boolean
        return true
    end,
    canFinish = function(): boolean
        return true
    end,
    onStart = function() end,
    onFinish = function() end
}

return { EventTypes = EventTypes, Events = Events, EventConfig = EventConfig }
