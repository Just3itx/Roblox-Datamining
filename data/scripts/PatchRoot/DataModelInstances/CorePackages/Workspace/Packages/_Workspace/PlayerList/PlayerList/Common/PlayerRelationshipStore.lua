-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local createSignal = require(scriptParentParentParent.Signals).createSignal

local tbl1 = ({})

local function defaultRelationship() -- Luacid: Inlined by compiler; 3 call sites recovered
    return { isBlocked = false, friendStatus = nil, isFollowing = false }
end

local function getOrCreate(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not tbl1[num1] then
        local tbl2 = defaultRelationship()
        local getter, setter = createSignal(tbl2)
        tbl1[num1] = { getter = getter, setter = setter }
    end
    return tbl1[num1]
end

return {
    getPlayerRelationshipReactive = function(num1: number)
        return (getOrCreate(num1)).getter
    end,
    patchPlayerRelationship = function(num1: number, tbl2)
        local orCreate = getOrCreate(num1)

        local var1 = orCreate.getter(false)
        local tbl3 = {
            isBlocked = if tbl2.isBlocked ~= nil then tbl2.isBlocked else var1.isBlocked,
            friendStatus = if tbl2.friendStatus ~= nil then tbl2.friendStatus else var1.friendStatus,
            isFollowing = if tbl2.isFollowing ~= nil then tbl2.isFollowing else var1.isFollowing
        }
        orCreate.setter(tbl3)
    end,
    removePlayer = function(num1: number)
        tbl1[num1] = nil
    end,
    cleanUp = function()
        tbl1 = {}
    end
}
