-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VirtualEvents = script:FindFirstAncestor("VirtualEvents")

local React = require(VirtualEvents.Parent.React)
local Foundation = require(VirtualEvents.Parent.Foundation)
local GetTextSize = require(VirtualEvents.Parent.Style).GetTextSize
local useAnimation = require(VirtualEvents.Hooks.useAnimation)

local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local function DescriptionExpander(tbl1)
    local var1 = useTokens()
    local bodyLarge = var1.Typography.BodyLarge

    local var2, var3 = React.useState(0)
    local function updateDescriptionHeight(x: number?, description) -- Luacid: Inlined by compiler; 2 call sites recovered
        local textSizeY = GetTextSize(description, bodyLarge.FontSize, bodyLarge.Font, Vector2.new(x, math.huge)).Y
        var3(textSizeY)
    end

    local var4 = React.useCallback(function(arg1)
        updateDescriptionHeight(arg1.AbsoluteSize.X, tbl1.description)
    end, { tbl1.description })

    React.useEffect(function()
        updateDescriptionHeight(tbl1.width, tbl1.description)
    end, { tbl1.description, tbl1.width })

    local bool1 = false
    local yOffset

    if tbl1.isExpanded then
        yOffset = math.min(var2, tbl1.maxHeight)
        bool1 = yOffset
    end

    if not bool1 then
        yOffset = math.min(var2, 40)
    end

    local yOffset2, setAnimationOffset = React.useState(yOffset)

    useAnimation({
        startOffset = yOffset2,
        endOffset = yOffset,
        duration = 0.1,
        easingStyle = "quadratic",
        setAnimationOffset = setAnimationOffset
    })

    local element = React.createElement("ScrollingFrame", {
        ZIndex = 2,
        Size = UDim2.new(1, 0, 0, yOffset),
        CanvasSize = UDim2.new(0, 0, 0, var2 + 2),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ScrollingEnabled = tbl1.maxHeight + 10 < var2,
        ScrollBarThickness = 0
    }, {
        Text = React.createElement(FoundationText, {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Text = tbl1.description,
            TextTruncate = Enum.TextTruncate.None,
            RichText = true,
            textStyle = var1.Color.Content.Emphasis,
            fontStyle = {
                Font = bodyLarge.Font,
                FontSize = bodyLarge.FontSize,
                LineHeight = 1
            },
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true
        })
    })

    local createElement = React.createElement
    local tbl2 = {
        ZIndex = 2,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, yOffset),
        Position = UDim2.fromScale(0, 0),
        Text = "",
        Active = var2 > 50,
        AutoButtonColor = false,
        AutomaticSize = Enum.AutomaticSize.None
    }

    tbl2[React.Event.Activated] = function()
        tbl1.setIsExpanded(true)
    end

    local element2 = createElement("TextButton", tbl2, {
        Text = React.createElement(FoundationText, {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Text = tbl1.description,
            TextTruncate = Enum.TextTruncate.AtEnd,
            RichText = true,
            textStyle = var1.Color.Content.Emphasis,
            fontStyle = {
                Font = bodyLarge.Font,
                FontSize = bodyLarge.FontSize,
                LineHeight = 1
            },
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true
        })
    })

    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl3 = {
        LayoutOrder = tbl1.layoutOrder,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, yOffset2)
    }

    tbl3[React.Change.AbsoluteSize] = function(arg1)
        var4(arg1)
    end
    local tbl4 = { Description = 0 }
    if not tbl1.isExpanded then
        element = element2
    end

    tbl4.Description = element
    return createElement2(str1, tbl3, tbl4)
end

return DescriptionExpander
