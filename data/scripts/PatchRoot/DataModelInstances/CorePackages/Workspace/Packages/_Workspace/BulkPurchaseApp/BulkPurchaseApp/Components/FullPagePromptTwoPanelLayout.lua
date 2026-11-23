-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T22:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BulkPurchaseApp = script:FindFirstAncestor("BulkPurchaseApp")
local BulkPurchaseAppParent = BulkPurchaseApp.Parent
local React = require(BulkPurchaseAppParent.React)

local useDesignTokens = require(BulkPurchaseAppParent.Style).useDesignTokens
local useScreenSize = require(BulkPurchaseAppParent.EconomyCommonCoreScriptHooks).useScreenSize
local constants = require(BulkPurchaseApp.constants)

local function FullPagePromptTwoPanelLayout(tbl1)
    local var1, var2 = React.useBinding(Vector2.new(0, 0))
    local var3 = useScreenSize()
    local var4 = useDesignTokens()
    local size300 = var4.Size.Size_300
    local bool1 = var3.X < constants.MOBILE_BREAKPOINT and var3.X < var3.Y
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = tbl1.size,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder
    }

    local tbl3 = {
        StartSlot = React.createElement("Frame", {
            Size = var1:map(function(vector2: Vector2): UDim2
                if bool1 then
                    return UDim2.new(1, 0, 1, -(vector2.Y + var4.Size.Size_600))
                end

                return UDim2.new(0.5, -size300, 1, 0)
            end),
            BackgroundTransparency = 1,
            BorderSizePixel = 0
        }, tbl1.startSlot),
        EndSlot = 0
    }

    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Size = if bool1 then UDim2.new(1, 0, 0, 0) else UDim2.new(0.5, -size300, 0, 0),
        Position = if bool1 then UDim2.new(0, 0, 1, 0) else UDim2.new(0.5, size300, 0, 0),
        AnchorPoint = if bool1 then Vector2.new(0, 1) else Vector2.new(0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y
    }

    tbl4[React.Change.AbsoluteSize] = function(arg1)
        var2(arg1.AbsoluteSize)
    end

    tbl3.EndSlot = createElement2(str2, tbl4, tbl1.endSlot)
    return createElement(str1, tbl2, tbl3)
end

return FullPagePromptTwoPanelLayout
