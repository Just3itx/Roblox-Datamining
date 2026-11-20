-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MarkdownCoreParent = script:FindFirstAncestor("MarkdownCore").Parent

local React = require(MarkdownCoreParent.React)
local Dash = require(MarkdownCoreParent.Dash)
local Foundation = require(MarkdownCoreParent.Foundation)

local map = Dash.map

local MarkdownCore = script:FindFirstAncestor("MarkdownCore")
local Flags = require(MarkdownCore.Flags)

local View = Foundation.View
local Image = Foundation.Image
local FoundationText = Foundation.Text

local tbl1 = {
    ItemOffset = 12,
    MarkerImage = "rbxasset://textures/StudioSharedUI/dot.png",
    MarkerSize = 4,
    Padding = 6,
    LineHeight = 18,
    Font = Enum.Font.BuilderSans,
    TextColor = Color3.fromRGB(0, 0, 0),
    TextSize = 18,
    ItemIndentation = 0,
    SubItemStyle = { ItemIndentation = 20, ItemOffset = 12 }
}

local function calculateItemOffset(small: number, markerSize: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return markerSize + small
end

local function isOrdered(str1: string?): boolean | string? -- Luacid: Inlined by compiler; 1 call site recovered
    return str1 and not (str1:find("^*") or str1:find("^-"))
end

local function BulletList(tbl2)
    local var1 = Foundation.Hooks.useTokens()

    local textWrapped = tbl2.TextWrapped
    local textTruncate = tbl2.TextTruncate
    local var2 = tbl2.ListStyle or tbl1

    local items = tbl2.Items

    local itemIndentation = var2.ItemIndentation or tbl1.ItemIndentation

    local itemOffset = calculateItemOffset(var1.Gap.Small, var2.MarkerSize or tbl1.MarkerSize)
    local uDim2 = UDim2.new(1, -itemOffset, 0, 0)
    local font, var3, var4, yOffset

    if Flags.FFlagMarkdownAssistantParity then
        local bodyMedium = var1.Typography.BodyMedium
        font = var2.Font or bodyMedium.Font
        var3 = var2.TextSize or bodyMedium.FontSize
        var4 = var2.TextColor or var1.Color.Content.Default.Color3
        local lineHeight = var2.LineHeight

        if not lineHeight then
            local lineHeight2 = bodyMedium.LineHeight
            lineHeight = var3 * lineHeight2
        end

        yOffset = lineHeight
    else
        font = var2.Font or tbl1.Font
        var3 = var2.TextSize or tbl1.TextSize
        var4 = var2.TextColor or tbl1.TextColor
        yOffset = var2.LineHeight or tbl1.LineHeight
    end

    local var5 = map(items, function(contentElement, layoutOrder: number)
        local var5 = itemIndentation
        local markerImage = var2.MarkerImage or tbl1.MarkerImage
        local element = nil

        local prefix = nil
        local element2

        if type(contentElement) == "string" then
            element2 = React.createElement(FoundationText, {
                AutomaticSize = Enum.AutomaticSize.XY,
                fontStyle = { Font = font, FontSize = var3 },
                LayoutOrder = 2,
                Size = uDim2,
                Text = contentElement,
                textStyle = { Color3 = var4 },
                TextTruncate = textTruncate,
                TextWrapped = textWrapped,
                Padding = var2.Padding or tbl1.Padding,
                TextXAlignment = Enum.TextXAlignment.Left
            })
        elseif typeof(contentElement) == "table" and contentElement.Text then
            prefix = contentElement.Prefix

            local subItemStyle = var2.SubItemStyle

            local uDim2_2 = UDim2.new(1, -subItemStyle.ItemOffset or tbl1.SubItemStyle.ItemOffset, 0, 0)

            local offset = subItemStyle.ItemIndentation or var5

            markerImage = subItemStyle.MarkerStyle or markerImage

            if offset then
                element = React.createElement("UIPadding", { PaddingLeft = UDim.new(0, offset) })
            end

            element2 = React.createElement(FoundationText, {
                AutomaticSize = Enum.AutomaticSize.XY,
                LayoutOrder = 2,
                Size = uDim2_2,
                textStyle = { Color3 = var4 },
                fontStyle = { Font = font, FontSize = var3 },
                Text = contentElement.Text,
                TextWrapped = textWrapped,
                TextTruncate = textTruncate,
                TextXAlignment = Enum.TextXAlignment.Left
            })
        elseif typeof(contentElement) == "table" and contentElement.Item then
            prefix = contentElement.Prefix

            element2 = React.createElement(View, { tag = "auto-y", LayoutOrder = 2, Size = uDim2 }, { ContentElement = contentElement.Item })
        else
            element2 = React.createElement(View, { tag = "auto-y", LayoutOrder = 2, Size = uDim2 }, { ContentElement = contentElement })
        end

        local createElement = React.createElement
        local var6 = View
        local tbl3 = {
            key = tostring(layoutOrder),
            testId = "--markdown--bullet-list-item",
            LayoutOrder = layoutOrder,
            tag = "gap-xsmall auto-xy row align-x-left align-y-top"
        }
        local tbl4 = { Marker = 0, Content = 0, Padding = 0 }
        local createElement2 = React.createElement
        local var7 = View
        local tbl5 = {
            LayoutOrder = 1,
            Size = UDim2.fromOffset(var2.MarkerSize or tbl1.MarkerSize, yOffset)
        }
        local tbl6 = { Image = 0 }
        local element3

        if isOrdered(prefix) then
            element3 = React.createElement(FoundationText, {
                tag = "position-center-left anchor-center-left",
                Text = `{prefix}.`,
                fontStyle = { Font = font, FontSize = var3 },
                textStyle = { Color3 = var4 },
                Size = UDim2.fromOffset(var2.MarkerSize or tbl1.MarkerSize, var2.MarkerSize or tbl1.MarkerSize)
            })
        else
            element3 = React.createElement(Image, {
                tag = "position-center-left anchor-center-left",
                Image = markerImage,
                imageStyle = { Color3 = var4 },
                LayoutOrder = 1,
                Size = UDim2.fromOffset(var2.MarkerSize or tbl1.MarkerSize, var2.MarkerSize or tbl1.MarkerSize)
            })
        end

        tbl6.Image = element3
        tbl4.Marker = createElement2(var7, tbl5, tbl6)

        tbl4.Content = element2
        tbl4.Padding = element
        return createElement(var6, tbl3, tbl4)
    end)

    local size = tbl2.Size
    local position = tbl2.Position
    local xy = Enum.AutomaticSize.XY
    if size and (size.X.Scale > 0 or size.X.Offset > 0) then
        xy = Enum.AutomaticSize.Y
    end

    return React.createElement(View, {
        testId = "--markdown--bullet-list",
        tag = "col align-x-left gap-xsmall",
        AutomaticSize = xy,
        backgroundStyle = { Transparency = 1 },
        LayoutOrder = tbl2.LayoutOrder or 1,
        Position = position,
        Size = size
    }, Dash.assign(var5, tbl2.children or {}))
end

return BulletList
