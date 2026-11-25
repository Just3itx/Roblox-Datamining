-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local createSignal = require(scriptParentParent.Signals).createSignal

local tbl1 = ({})

local function createDefaultPlayerIconInfo(creatorId: number) -- Luacid: Inlined by compiler; 4 call sites recovered
    return {
        isPlaceOwner = game.CreatorType == Enum.CreatorType.User and creatorId == game.CreatorId,
        avatarIcon = nil,
        specialGroupIcon = nil
    }
end

local function getOrCreatePlayerSignal(creatorId: number) -- Luacid: Inlined by compiler; 3 call sites recovered
    if not tbl1[creatorId] then
        local getter, setter = createSignal((createDefaultPlayerIconInfo(creatorId)))
        tbl1[creatorId] = { getter = getter, setter = setter }
    end
    return tbl1[creatorId]
end

return {
    getPlayerIconInfoReactive = function(creatorId: number)
        return getOrCreatePlayerSignal(creatorId).getter
    end,
    setPlayerIconInfo = function(creatorId: number, tbl2)
        getOrCreatePlayerSignal(creatorId).setter(tbl2)
    end,
    addPlayer = function(creatorId: number)
        getOrCreatePlayerSignal(creatorId)
    end,
    removePlayer = function(num1: number)
        tbl1[num1] = nil
    end,
    cleanUp = function()
        tbl1 = {}
    end
}
