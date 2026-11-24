-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local CollectionService = game:GetService("CollectionService")
local React = require(InExperienceShopParent.React)

local UnifiedEventLogConstants = require(InExperienceShopParent.AvatarExperienceAnalytics).UnifiedEventLogConstants

local ShopScreenSizeImpressionsDetector = require(script.Parent.ShopScreenSizeImpressionsDetector)

local function ShopTagBasedImpressionsDetector(tbl1)
    local var1 = React.useRef({})
    local var2 = React.useRef({})

    local filterImpressionFunc = React.useCallback(function(arg1): boolean
        return not var1.current[arg1:GetFullName()]
    end, {})

    local onImpressionsDetected = React.useCallback(function(tbl2)
        local tbl3 = ({})

        for _, value in tbl2 do
            local fullName = value:GetFullName()

            if var1.current[fullName] then
                continue
            end

            tbl3[fullName] = value

            if not var2.current[fullName] then
                var2.current[fullName] = value.AncestryChanged:Connect(function()
                    if value.Parent then
                        return
                    end

                    var1.current[fullName] = nil
                    if var2.current[fullName] then
                        var2.current[fullName]:Disconnect()
                        var2.current[fullName] = nil
                    end
                end)
            end

            var1.current[fullName] = true
        end

        if not next(tbl3) or not tbl1.extensions then
            return
        end

        for _, visibleInstance in tbl3 do
            for _, extension in tbl1.extensions do
                extension({ visibleInstance = visibleInstance })
            end
        end
    end, { tbl1.extensions })

    React.useEffect(function()
        return function()
            for _, value in var2.current do
                if value then
                    value:Disconnect()
                end
            end
            var2.current = {}
        end
    end, {})

    local collectObjectsFunc = React.useCallback(function(): {Instance}
        return CollectionService:GetTagged(UnifiedEventLogConstants.TAG_NAME)
    end, {})

    return React.createElement(ShopScreenSizeImpressionsDetector, {
        parentRef = tbl1.parentRef,
        pageFilter = tbl1.pageFilter,
        onRequestImpressionsSignal = tbl1.requestImpressionsSignal,
        filterImpressionFunc = filterImpressionFunc,
        onImpressionsDetected = onImpressionsDetected,
        collectObjectsFunc = collectObjectsFunc
    })
end

return ShopTagBasedImpressionsDetector
