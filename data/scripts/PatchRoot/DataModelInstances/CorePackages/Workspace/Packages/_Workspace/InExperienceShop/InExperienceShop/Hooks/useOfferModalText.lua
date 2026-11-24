-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local useLocalization = require(InExperienceShop.Parent.Localization).Hooks.useLocalization

local function useOfferModalText(str1: string, timeRemaining: string?)
    local var1 = useLocalization({ endTime = { "Feature.InExperienceShop.Label.EndTime", timeRemaining = timeRemaining or "" } })

    local var2 = useLocalization({
        viewTerms = "Feature.Catalog.Action.ViewTerms",
        descriptionWithTime = {
            "Feature.InExperienceShop.Label.DescriptionWithTime",
            description = str1,
            timeRemaining = var1.endTime
        }
    })

    local tbl1 = { bodyText = 0, viewTermsText = 0 }
    if timeRemaining ~= nil then
        str1 = var2.descriptionWithTime
    end

    tbl1.bodyText = str1
    tbl1.viewTermsText = var2.viewTerms
    return tbl1
end

return useOfferModalText
