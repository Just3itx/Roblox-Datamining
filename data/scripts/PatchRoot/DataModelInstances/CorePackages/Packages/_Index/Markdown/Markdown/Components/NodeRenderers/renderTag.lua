-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Markdown = script:FindFirstAncestor("Markdown")
local MarkdownParent = Markdown.Parent
local _Types = require(Markdown.Types)
local React = require(MarkdownParent.React)
local Foundation = require(MarkdownParent.Foundation)
local Dash = require(MarkdownParent.Dash)
local Flags = require(MarkdownParent.MarkdownCore).Flags

local ImageElement = require(MarkdownParent.InlineLayout).Components.InlineLayoutElements.ImageElement
local joinTags = require(Markdown.Utils.joinTags)
local mergeContexts = require(Markdown.Utils.mergeContexts)
local NodeType = require(Markdown.Enums.NodeType)

local function bold()
    return { bold = true }
end

local function italic()
    return { italic = true }
end

local function strike()
    return { strike = true }
end

local function code(arg1)
    return Dash.joinDeep(arg1.codeStyles, { selectable = true })
end

local tbl1 = {
    b = bold,
    strong = bold,
    i = italic,
    em = italic,
    s = strike,
    del = strike,
    strike = strike,
    code = code,
    kbd = code
}

local function renderTag(arg1, arg2)
    if arg1.text == "img" then
        local size = arg2.imageStyles.size
        local xOffset = if arg1.attributes and arg1.attributes.width then arg1.attributes.width else size.Width.Offset
        local yOffset = if arg1.attributes and arg1.attributes.height then arg1.attributes.height else size.Height.Offset

        if not arg2.isInline then
            return React.createElement("ImageLabel", {
                key = tostring(arg1.index),
                LayoutOrder = arg1.index,
                Image = if arg1.attributes and arg1.attributes.src then arg1.attributes.src else "",
                Size = UDim2.fromOffset(xOffset, yOffset),
                BackgroundColor3 = arg2.imageStyles.backgroundColor3,
                BackgroundTransparency = arg2.imageStyles.backgroundTransparency,
                ImageTransparency = arg2.imageStyles.transparency,
                ScaleType = arg2.imageStyles.scaleType,
                ResampleMode = arg2.imageStyles.resampleMode,
                [React.Tag] = joinTags("X-PadS X-Middle", arg2.imageStyles.tags)
            })
        end

        return ImageElement.new({
            LayoutOrder = arg1.index,
            Image = if arg1.attributes and arg1.attributes.src then arg1.attributes.src else "",
            Size = UDim2.fromOffset(xOffset, yOffset),
            backgroundStyle = {
                Transparency = arg2.imageStyles.backgroundTransparency,
                Color3 = arg2.imageStyles.backgroundColor3
            },
            imageStyle = {
                Transparency = arg2.imageStyles.transparency
            },
            ScaleType = arg2.imageStyles.scaleType,
            ResampleMode = arg2.imageStyles.resampleMode,
            tag = arg2.imageStyles.tags
        })
    elseif arg1.text == "Button" then
        if not (arg1.attributes and arg1.attributes.text and arg1.attributes.url) then
            warn("Button tag misses required text and url attributes")
            return nil
        end
        local createElement = React.createElement
        local button = Foundation.Button
        local tbl2 = {
            key = tostring(arg1.index),
            LayoutOrder = arg1.index,
            text = arg1.attributes.text,
            icon = arg1.attributes.icon,
            onActivated = 0,
            tag = "auto-xy"
        }

        function tbl2.onActivated()
            arg2.linkCallback(arg1.attributes.url)
        end

        return createElement(button, tbl2)
    elseif arg1.text == "font" then
        local color = if arg1.attributes and arg1.attributes.color then arg1.attributes.color else nil
        return arg2.processChildren(arg1, mergeContexts(arg2, { textStyles = { color = color } }))
    end

    if not Flags.FFlagMarkdownTagFallbacks then
        return nil
    end

    local href = arg1.attributes and arg1.attributes.href

    if arg1.text == "a" and href and arg2.renderers and arg2.renderers.LINK then
        return arg2.renderers.LINK(Dash.join(arg1, { attributes = Dash.join(arg1.attributes, { url = href }) }), arg2)
    end

    if arg1.type == NodeType.InlineSpan then
        local var1 = tbl1[arg1.text]
        local textStyles = not var1 and {} or var1(arg2)

        return arg2.processChildren(arg1, mergeContexts(arg2, { textStyles = textStyles }))
    end

    return React.createElement(
        Foundation.View,
        {
            key = tostring(arg1.index),
            tag = "size-full-0 auto-y col",
            LayoutOrder = arg1.index
        },
        (arg2.processChildren(arg1, arg2))
    )
end

return renderTag
