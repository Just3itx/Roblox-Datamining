-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:01:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")

local module = {}
module.__index = module

module.EventName = {
    MenuOpened = "emoteMenuOpened",
    EmotePlayed = "emoteTriggered",
    EmoteFailed = "emoteTriggerFailed"
}

function module.new()
    local tbl1 = { eventStreamImpl = nil }

    setmetatable(tbl1, module)

    return tbl1
end

function module:withEventStream(eventStreamImpl)
    self.eventStreamImpl = eventStreamImpl
    return self
end

function module.onMenuOpened(arg1)
    local menuOpened = arg1.EventName.MenuOpened

    local tbl1 = {
        pid = tostring(game.PlaceId),
        uid = tostring(Players.LocalPlayer.UserId),
        btid = Stats:GetBrowserTrackerId()
    }

    arg1:_getEventStream():setRBXEventStream("emoteMenu", menuOpened, tbl1)
end

function module.onEmotePlayed(arg1, slotNumber, assetId)
    local emotePlayed = arg1.EventName.EmotePlayed

    local tbl1 = {
        pid = tostring(game.PlaceId),
        uid = tostring(Players.LocalPlayer.UserId),
        btid = Stats:GetBrowserTrackerId(),
        slotNumber = slotNumber,
        assetID = assetId
    }

    arg1:_getEventStream():setRBXEventStream("emoteMenu", emotePlayed, tbl1)
end

function module.onEmoteFailed(arg1, slotNumber, assetId, errorType)
    local emoteFailed = arg1.EventName.EmoteFailed

    local tbl1 = {
        pid = tostring(game.PlaceId),
        uid = tostring(Players.LocalPlayer.UserId),
        btid = Stats:GetBrowserTrackerId(),
        slotNumber = slotNumber,
        assetID = assetId,
        errorType = errorType,
        invokedByCoreGui = true
    }

    arg1:_getEventStream():setRBXEventStream("emoteMenu", emoteFailed, tbl1)
end

function module:_getEventStream()
    assert(self.eventStreamImpl, "EventStream implementation not found. Did you forget to construct withEventStream?")
    return self.eventStreamImpl
end

return module
