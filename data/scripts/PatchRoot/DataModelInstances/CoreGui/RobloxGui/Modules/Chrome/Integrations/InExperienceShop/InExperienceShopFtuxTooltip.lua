-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local Service = require(Chrome.Service)
local Constants = require(Chrome.ChromeShared.Unibar.Constants)
local useMappedSignal = require(CorePackages.Workspace.Packages.Chrome).Hooks.useMappedSignal
local CommonFtuxTooltip = require(Chrome.Integrations.CommonFtuxTooltip)

local priority = game:DefineFastInt("InExperienceShopTooltipPriority", 3500)

local localStorageKey = game:DefineFastString("InExperienceShopTooltipStorageKey", "InExperienceShopTooltipStorageKey")
local showDelay = game:DefineFastInt("InExperienceShopTooltipShowDelay", 1000)
local dismissDelay = game:DefineFastInt("InExperienceShopTooltipDismissDelay", 7000)

local function InExperienceShopFtuxTooltip(tbl1)
    local var1 = Service:integrations()[Constants.IN_EXPERIENCE_SHOP_ID]
    local availability = if var1 then var1.availability else nil
    return useMappedSignal(availability) == Service.AvailabilitySignal.Available
        and CommonFtuxTooltip({
            id = "IN_EXPERIENCE_SHOP_TOOLTIP",
            priority = priority,
            isIconVisible = tbl1.visible,
            headerKey = "CoreScripts.FTUX.Heading.InExperienceShop",
            bodyKey = "CoreScripts.FTUX.Label.InExperienceShopDescription",
            localStorageKey = localStorageKey,
            showDelay = showDelay,
            dismissDelay = dismissDelay
        })
end

return InExperienceShopFtuxTooltip
