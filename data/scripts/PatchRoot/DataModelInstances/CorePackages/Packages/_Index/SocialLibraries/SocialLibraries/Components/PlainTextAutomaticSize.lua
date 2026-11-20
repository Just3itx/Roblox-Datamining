-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local ChatBubbleContainerAutomaticSize = require(script.Parent.ChatBubbleContainerAutomaticSize)
local Roact = dependencies.Roact
local withStyle = dependencies.UIBlox.Style.withStyle
local normalizeFontFace = dependencies.Foundation.Utility.normalizeFontFace
local useTextBounds = require(SocialLibraries.Utils.useTextBounds)

game:DefineFastFlag("FixPlainTextAutomaticSizeClippingText", false)

local fastFlag = game:GetFastFlag("FixPlainTextAutomaticSizeClippingText")

local tbl1 = {
    text = "",
    maxWidth = 0,
    innerPadding = 0,
    isIncoming = false,
    hasTail = false,
    LayoutOrder = 0,
    isPending = false
}

tbl1[Roact.Change.AbsoluteSize] = function() end

local function TextContent(tbl2)
    local var1 = useTextBounds(tbl2.text, tbl2.font, tbl2.textSize, tbl2.contentMaxWidth) or Vector2.new(0, tbl2.textSize)

    local createElement = Roact.createElement
    local str1 = "TextLabel"
    local tbl3 = {
        Text = tbl2.text,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        TextColor3 = tbl2.textColor3,
        AutomaticSize = Enum.AutomaticSize.XY,
        FontFace = normalizeFontFace(tbl2.font),
        TextSize = tbl2.textSize,
        Size = 0,
        TextTransparency = 0,
        TextYAlignment = 0,
        TextWrapped = true
    }
    local bool1 = false
    local offset

    if fastFlag then
        offset = UDim2.fromOffset(math.ceil(var1.X), math.ceil(var1.Y))
        bool1 = offset
    end

    if not bool1 then
        offset = UDim2.new(0, var1.X, 0, var1.Y)
    end

    tbl3.Size = offset

    tbl3.TextTransparency = tbl2.textTransparency
    tbl3.TextYAlignment = Enum.TextYAlignment.Top
    return createElement(
        str1,
        tbl3,
        {
            SizeConstraint = Roact.createElement("UISizeConstraint", { MaxSize = Vector2.new(tbl2.contentMaxWidth, math.huge) })
        }
    )
end

local function PlainText(arg1)
    return withStyle(function(arg2)
        local maxWidth = arg1.maxWidth or tbl1.maxWidth
        local innerPadding = arg1.innerPadding or tbl1.innerPadding
        local contentMaxWidth = math.max(0, maxWidth - innerPadding)
        local body = arg2.Font.Body
        local textSize = arg1.textSize or arg2.Font.BaseSize * body.RelativeSize
        local text = arg1.text or tbl1.text
        local font = arg1.font or body.Font

        return Roact.createElement(ChatBubbleContainerAutomaticSize, {
            isIncoming = arg1.isIncoming or tbl1.isIncoming,
            hasTail = arg1.hasTail or tbl1.hasTail,
            isPending = arg1.isPending or tbl1.isPending,
            padding = innerPadding,
            LayoutOrder = arg1.LayoutOrder or tbl1.LayoutOrder,
            [Roact.Change.AbsoluteSize] = arg1[Roact.Change.AbsoluteSize] or tbl1[Roact.Change.AbsoluteSize]
        }, {
            textContent = Roact.createElement(TextContent, {
                text = text,
                font = font,
                textSize = textSize,
                contentMaxWidth = contentMaxWidth,
                textColor3 = arg2.Theme.TextEmphasis.Color,
                textTransparency = arg1.isPending and arg2.Theme.TextMuted.Transparency or 0
            })
        })
    end)
end

return PlainText
