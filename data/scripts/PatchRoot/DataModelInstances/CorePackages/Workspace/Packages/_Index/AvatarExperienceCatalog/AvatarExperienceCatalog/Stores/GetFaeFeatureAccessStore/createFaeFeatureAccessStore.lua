-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local Signals = require(AvatarExperienceCatalogParent.Signals)
local Promise = require(AvatarExperienceCatalogParent.Promise)
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)

local getFaeStatus = require(AvatarExperienceCatalog.Api.GetFaeStatus.getFaeStatus).getFaeStatus

local function createFaeFeatureAccessStore()
    local getCanClaimFaeItem, var2 = Signals.createSignal(false)
    local getShowFaeUpsell, var4 = Signals.createSignal(false)

    local getFetchStatus, var6 = Signals.createSignal("idle")

    return {
        getCanClaimFaeItem = getCanClaimFaeItem,
        getShowFaeUpsell = getShowFaeUpsell,
        getFetchStatus = getFetchStatus,
        fetch = function(arg1)
            var6("pending")
            local var7, _ = getFaeStatus(arg1)
            return Promise.resolve(var7):andThen(function(arg2)
                if not arg2 then
                    return Promise.reject()
                end
                local bool1 = false
                local bool2 = false
                for _, value in arg2.features do
                    if value.featureName == "AllowFaeItemToBeClaimed" then
                        bool1 = value.access == "Granted"
                    elseif value.featureName == "ShowFaeUpsellInMarketplace" then
                        if value.access ~= "Granted" then
                            bool2 = false
                        else
                            bool2 = true
                        end
                    end
                end

                var2(bool1)
                var4(bool2)
                var6("success")
                return Promise.resolve()
            end):catch(function(arg2)
                var6("idle")
                return Promise.reject(arg2)
            end)
        end,
        reset = function()
            var2(false)
            var4(false)
            var6("idle")
        end
    }
end
return createFaeFeatureAccessStore
