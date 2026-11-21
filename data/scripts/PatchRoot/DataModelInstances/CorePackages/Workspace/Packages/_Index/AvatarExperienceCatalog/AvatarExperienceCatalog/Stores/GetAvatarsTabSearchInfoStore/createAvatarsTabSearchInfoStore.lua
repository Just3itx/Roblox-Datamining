-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:20:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local _Signals = require(AvatarExperienceCatalogParent.Signals)
local SignalsExperimental = require(AvatarExperienceCatalogParent.SignalsExperimental)
local createSessionScopedSignal = require(AvatarExperienceCatalogParent.SignalsUtils).createSessionScopedSignal

local function createAvatarsTabSearchInfoStore()
    local getSearchUuid, var2 = createSessionScopedSignal(nil)

    local getKeyword, var4 = createSessionScopedSignal(nil)

    return {
        getSearchUuid = getSearchUuid,
        getKeyword = getKeyword,
        setAvatarsTabSearchInfo = function(str1: string, str2: string)
            SignalsExperimental.batch(function()
                var2(str1)
                var4(str2)
            end)
        end,
        reset = function()
            SignalsExperimental.batch(function()
                var2(nil)
                var4(nil)
            end)
        end
    }
end

return createAvatarsTabSearchInfoStore
