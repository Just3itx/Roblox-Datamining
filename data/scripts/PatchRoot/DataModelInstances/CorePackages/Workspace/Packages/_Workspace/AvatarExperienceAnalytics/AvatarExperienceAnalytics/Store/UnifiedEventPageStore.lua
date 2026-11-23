-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local GetLegacyNavigationStore = require(AvatarExperienceAnalyticsParent.NavigationRodux).GetLegacyNavigationStore
local sendAXCounterV2 = require(script.Parent.Parent.sendAXCounterV2)

local var1 = nil

local function fallbackPageName() -- Luacid: Inlined by compiler; 1 call site recovered
    local success, result = pcall(function()
        return GetLegacyNavigationStore(false).getCurrentLegacyRoute(false)
    end)

    if success and result ~= nil and #result ~= 0 then
        return result[#result].name
    end

    return nil
end

return {
    UNKNOWN = "Unknown",
    UNREGISTERED = "Unregistered",
    setPageProvider = function(func1: ((...any) -> (...any))?)
        var1 = func1
    end,
    getPageFields = function()
        local var2 = var1
        if var2 ~= nil then
            local success, result, result2 = pcall(var2)
            if not success then
                sendAXCounterV2("UnifiedEventPageResolutionFailed", { Source = "provider" })
            elseif result ~= nil then
                return {
                    navigationPage = result,
                    navigationOpaquePage = result2 or "Unknown"
                }
            end
        end

        local navigationPage = fallbackPageName()

        if navigationPage == nil then
            return { navigationPage = "Unknown", navigationOpaquePage = "Unknown" }
        end

        return {
            navigationPage = navigationPage,
            navigationOpaquePage = if var2 == nil then "Unregistered" else "Unknown"
        }
    end
}
