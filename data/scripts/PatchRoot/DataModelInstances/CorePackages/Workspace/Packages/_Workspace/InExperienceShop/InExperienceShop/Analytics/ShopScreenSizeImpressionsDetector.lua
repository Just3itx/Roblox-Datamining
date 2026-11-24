-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)

local getShopImpressionsViewportBounds = require(script.Parent.getShopViewportBounds).getShopImpressionsViewportBounds
local ShopImpressionsDetector = require(script.Parent.ShopImpressionsDetector)

local vector2 = Vector2.new(1920, 1080)

local function ShopScreenSizeImpressionsDetector(tbl1)
    local currentCamera = workspace.CurrentCamera
    local vector2_2 = if currentCamera then currentCamera.ViewportSize else vector2
    local var1, var2 = React.useState(vector2_2)

    React.useEffect(function()
        local currentCamera2 = workspace.CurrentCamera
        if currentCamera2 == nil then
            return function() end
        end

        local connection = currentCamera2:GetPropertyChangedSignal("ViewportSize"):Connect(function()
            var2(currentCamera2.ViewportSize)
        end)

        return function()
            connection:Disconnect()
        end
    end, {})

    local getViewPortBounds = React.useCallback(function()
        local current = if tbl1.parentRef then tbl1.parentRef.current else nil
        return getShopImpressionsViewportBounds(var1, current)
    end, { tbl1.parentRef, var1 })

    return React.createElement(ShopImpressionsDetector, {
        parentRef = tbl1.parentRef,
        onRequestImpressionsSignal = tbl1.onRequestImpressionsSignal,
        getViewPortBounds = getViewPortBounds,
        pageFilter = tbl1.pageFilter,
        collectObjectsFunc = tbl1.collectObjectsFunc,
        filterImpressionFunc = tbl1.filterImpressionFunc,
        onImpressionsDetected = tbl1.onImpressionsDetected,
        scanDebounceSeconds = tbl1.scanDebounceSeconds
    })
end

return ShopScreenSizeImpressionsDetector
