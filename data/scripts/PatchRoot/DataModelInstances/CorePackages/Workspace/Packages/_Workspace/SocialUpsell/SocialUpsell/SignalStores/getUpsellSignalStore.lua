-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:40:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialUpsell = script:FindFirstAncestor("SocialUpsell")
local SocialUpsellParent = SocialUpsell.Parent

local Cryo = require(SocialUpsellParent.Cryo)
local Signals = require(SocialUpsellParent.Signals)

local _UpsellEntrySurfaceType = require(SocialUpsell.Analytics.Enum.UpsellEntrySurfaceType)
local _SocialUpsellType = require(SocialUpsell.Enum.SocialUpsellType)
local _Types = require(SocialUpsell.Types)

local var1 = nil

local function createUpsellSignalStore()
    local tbl1 = ({})

    local function getOrCreateUpsellBannerDataStore(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        local tbl2 = tbl1[arg1]
        if tbl2 == nil then
            local getBannerData, setBannerData = Signals.createSignal(nil)
            tbl2 = { getBannerData = getBannerData, setBannerData = setBannerData }

            tbl1[arg1] = tbl2
        end
        return tbl2
    end

    return {
        getUpsellBannerDataGetter = function(arg1)
            return getOrCreateUpsellBannerDataStore(arg1).getBannerData
        end,
        setUpsellBannerData = function(arg1, arg2, arg3)
            getOrCreateUpsellBannerDataStore(arg1).setBannerData(function(arg4)
                local var2 = arg3 ~= nil and { isVisible = true } or Cryo.None
                local var3 = Cryo.Dictionary.join(arg4 or {}, { [arg2] = var2 })
                return if next(var3) == nil then nil else var3
            end)
        end
    }
end

return function()
    if var1 == nil then
        var1 = Signals.createComputed(createUpsellSignalStore)(false)
    end
    return var1
end
