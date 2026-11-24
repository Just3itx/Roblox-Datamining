-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local Signal = require(InExperienceShopParent.AppCommonLib).Signal

local FFlagEnableInExperienceShopUnifiedLogging = require(InExperienceShop.Flags.FFlagEnableInExperienceShopUnifiedLogging)

local function onLayoutChange() end

local function useShopImpressionsDetector(tbl1)
    if not FFlagEnableInExperienceShopUnifiedLogging then
        return {
            gridRef = { current = nil },
            onLayoutChange = onLayoutChange,
            impressionsDetector = nil
        }
    end

    local requestImpressionsSignal = React.useMemo(function()
        return Signal.new()
    end, {})

    local var2 = React.useRef(nil)

    React.useEffect(function()
        local externalScrollSignal = tbl1.externalScrollSignal
        if externalScrollSignal == nil then
            return function() end
        end

        local connection = externalScrollSignal:connect(function()
            requestImpressionsSignal:fire()
        end)

        return function()
            connection:disconnect()
        end
    end, { tbl1.externalScrollSignal, requestImpressionsSignal })

    local var1 = React.useCallback(function()
        requestImpressionsSignal:fire()
    end, { requestImpressionsSignal })

    local pageFilter = React.useCallback(function()
        return tbl1.isPageActive
    end, { tbl1.isPageActive })

    return {
        gridRef = var2,
        onLayoutChange = var1,
        impressionsDetector = React.useMemo(function()
            local analytics = require(InExperienceShop.Analytics)
            local shopTagBasedImpressionsDetector = analytics.ShopTagBasedImpressionsDetector
            local inExperienceShopUnifiedImpressionsReporter = analytics.InExperienceShopUnifiedImpressionsReporter

            return React.createElement(shopTagBasedImpressionsDetector, {
                parentRef = var2,
                pageFilter = pageFilter,
                requestImpressionsSignal = requestImpressionsSignal,
                extensions = { inExperienceShopUnifiedImpressionsReporter(tbl1.pageType) }
            })
        end, { tbl1.pageType, pageFilter, requestImpressionsSignal })
    }
end

return useShopImpressionsDetector
