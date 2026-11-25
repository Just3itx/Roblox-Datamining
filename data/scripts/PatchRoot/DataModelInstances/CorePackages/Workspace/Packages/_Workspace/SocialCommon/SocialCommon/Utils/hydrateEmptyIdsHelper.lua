-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local Promise = require(SocialCommonParent.Promise)
local Cryo = require(SocialCommonParent.Cryo)

local _LuauPolyfill = require(SocialCommonParent.LuauPolyfill)

local function hydrateEmptyIdsHelper(tbl1)
    local ids = tbl1.ids
    local selector = tbl1.selector
    local hydrate = tbl1.hydrate

    if not ids then
        return Promise.resolve()
    end

    local var1 = Cryo.List.filter(ids, function(arg1): boolean
        return selector(arg1) == nil
    end)

    if #var1 > 0 then
        return (hydrate(var1))
    end

    return (Promise.resolve())
end

return hydrateEmptyIdsHelper
