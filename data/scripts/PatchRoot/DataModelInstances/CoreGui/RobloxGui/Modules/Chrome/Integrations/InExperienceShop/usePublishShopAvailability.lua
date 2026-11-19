-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)

local InExperienceOffers = require(CorePackages.Workspace.Packages.InExperienceOffers)
local useMappedSignal = require(CorePackages.Workspace.Packages.Chrome).Hooks.useMappedSignal

local Service = require(Chrome.Service)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)

local getOffersStore = InExperienceOffers.getOffersStore

local function usePublishShopAvailability()
    local var1 = Service:integrations()[Constants.IN_EXPERIENCE_SHOP_ID]
    local bool1 = useMappedSignal(if var1 then var1.availability else nil) == Service.AvailabilitySignal.Available

    React.useEffect(function()
        getOffersStore(false).setIsShopAvailable(bool1)
    end, { bool1 })
end

return usePublishShopAvailability
