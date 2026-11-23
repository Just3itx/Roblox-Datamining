-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = game:GetService("CorePackages").Packages._Index.Foundation.Foundation
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)
local Gradient = require(Foundation.Components.Gradient)
local Image = require(Foundation.Components.Image)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local withDefaults = require(Foundation.Utility.withDefaults)

local Sheet = script:FindFirstAncestor("Sheet")
local SheetContext = require(Sheet.SheetContext)

local tbl1 = {
    height = UDim.new(1, 0),
    sticky = false
}

return React.memo(React.forwardRef(function(tbl2, ref) -- name: SheetFullBleed
    local var1 = withDefaults(tbl2, tbl1)
    local var2 = React.useContext(SheetContext)

    local setFullBleedHeight = var2.setFullBleedHeight
    local fullBleedHeight = var2.fullBleedHeight
    local innerScrollY = var2.innerScrollY
    local hasHeader = var2.hasHeader
    local hasRadius = var2.hasRadius
    local testId = var2.testId
    assert(setFullBleedHeight and hasHeader and testId, "SheetFullBleed must be used within a Sheet")

    React.useEffect(function()
        assert(
            not (var1.sticky and hasHeader:getValue()),
            "Sheet.FullBleed with sticky=true is unsupported when used with Sheet.Header"
        )
    end, { var1.sticky, hasHeader })

    local var3 = React.useCallback(function(arg1)
        setFullBleedHeight(arg1.AbsoluteSize.Y)
    end, {})

    React.useEffect(function()
        return function()
            setFullBleedHeight(0)
        end
    end, {})

    local uDim2 = UDim2.new(1, 0, var1.height.Scale, var1.height.Offset)

    local var4 = nil
    if var1.sticky then
        var4 = uDim2
    elseif innerScrollY and fullBleedHeight then
        var4 = React.joinBindings({ scrollY = innerScrollY, height = fullBleedHeight }):map(function(tbl3): UDim2
            if tbl3.height == 0 then
                return UDim2.fromScale(1, 1)
            end
            local yOffset = math.max(0, tbl3.height - tbl3.scrollY)
            return UDim2.new(1, 0, 0, yOffset)
        end)
    end

    local tbl3 = {
        RoundedCorners = if hasRadius then React.createElement(Image, {
            Image = var1.media,
            imageStyle = var1.mediaStyle,
            backgroundStyle = var1.backgroundStyle,
            aspectRatio = var1.aspectRatio,
            tag = "radius-large",
            Size = uDim2,
            testId = `{testId}--full-bleed--rounded-corners`,
            ZIndex = 1
        }) else nil,
        Image = 0,
        Content = 0
    }

    local createElement = React.createElement
    local var5 = Image
    local tbl4 = {
        Image = var1.media,
        imageStyle = var1.mediaStyle,
        backgroundStyle = var1.backgroundStyle,
        aspectRatio = var1.aspectRatio,
        onAbsoluteSizeChanged = 0,
        Size = 0,
        ZIndex = 0
    }
    if var1.sticky then
        var3 = nil
    end

    tbl4.onAbsoluteSizeChanged = var3
    tbl4.Size = uDim2
    tbl3.Image = createElement(
        var5,
        tbl4,
        hasRadius
            and {
                TransparencyGradient = React.createElement(Gradient, { fillDirection = Enum.FillDirection.Vertical, top = false })
            }
            or nil
    )
    local content = if var1.children then React.createElement(View, { aspectRatio = var1.aspectRatio, Size = uDim2, ZIndex = 2 }, var1.children) else nil
    tbl3.Content = content

    local createElement2 = React.createElement
    local var6 = View
    local tbl5 = {
        Size = var4,
        aspectRatio = if var1.sticky then var1.aspectRatio else nil,
        LayoutOrder = if var1.sticky then Constants.MIN_LAYOUT_ORDER else nil,
        ClipsDescendants = true,
        ZIndex = 2,
        testId = `{testId}--full-bleed`,
        ref = ref
    }
    if not var1.sticky and var1.aspectRatio then
        tbl3 = React.createElement(View, { Size = UDim2.new(1, 0, 0, 9999), aspectRatio = var1.aspectRatio }, tbl3)
    end

    local element2 = createElement2(var6, tbl5, tbl3)

    if not var1.sticky then
        return React.createElement("Folder", nil, element2)
    end

    return element2
end))
