-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
local React = require(ServerDrivenUiParent.React)
local Foundation = require(ServerDrivenUiParent.Foundation)
local Image = Foundation.Image
local useTokens = Foundation.Hooks.useTokens

local slice = {
    center = Rect.new(35, 35, 37, 37)
}

return React.memo(function(tbl2) -- name: TileHoverShadow
    local var1 = useTokens()
    local var2 = tbl2.hoverPadding or var1.Padding.Medium
    local var3 = tbl2.containmentPadding or var1.Padding.Small
    local xOffset = var2 + 18
    local var4 = var2 + 14
    local var5 = var2 + var3 + var1.Gap.XSmall

    local var6, var7 = React.useBinding(0)

    React.useEffect(function()
        local current = tbl2.contentRef.current
        if not current then
            return
        end

        local function update() -- Luacid: Inlined by compiler; 1 call site recovered
            local absoluteSizeY = current.AbsoluteSize.Y
            var7(math.max(0, absoluteSizeY - var5))
        end

        update()
        local connection = current:GetPropertyChangedSignal("AbsoluteSize"):Connect(update)

        return function()
            connection:Disconnect()
        end
    end, { tbl2.contentRef, var5 })

    return React.createElement(Image, {
        Position = var6:map(function(num1: number): UDim2
            return UDim2.new(0.5, 0, 0.5, num1 / 2 + 2)
        end),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = var6:map(function(num1: number): UDim2
            return UDim2.new(1, xOffset, 1, var4 + num1)
        end),
        Image = "component_assets/dropshadow_56_8",
        imageStyle = {
            Color3 = var1.Color.Common.Shadow.Color3,
            Transparency = math.min(1, var1.Color.Common.Shadow.Transparency + 0.25)
        },
        slice = slice,
        ZIndex = -1
    })
end)
