-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MessageBusService = game:GetService("MessageBusService")

local ComponentsParent = script:FindFirstAncestor("Components").Parent
local ComponentsParentParent = ComponentsParent.Parent

local React = require(ComponentsParentParent.React)
local Dash = require(ComponentsParentParent.Dash)
local Foundation = require(ComponentsParentParent.Foundation)
local InlineLayout = require(ComponentsParentParent.InlineLayout)
local MarkdownCore = require(ComponentsParentParent.MarkdownCore)

local View = Foundation.View
local FoundationText = Foundation.Text
local Divider = Foundation.Divider

local Utils = ComponentsParent.Utils

local TextElement = InlineLayout.Components.InlineLayoutElements.TextElement
local SelectableTextElement = InlineLayout.Components.InlineLayoutElements.SelectableTextElement
local LinkElement = InlineLayout.Components.InlineLayoutElements.LinkElement
local ImageElement = InlineLayout.Components.InlineLayoutElements.ImageElement
local HardBreakElement = InlineLayout.Components.InlineLayoutElements.HardBreakElement
local mergeContexts = require(Utils.mergeContexts)
local processSoftBreaks = require(Utils.processSoftBreaks)
local shouldUseTopPadding = require(Utils.shouldUseTopPadding)
local TextStyle = require(Utils.TextStyle)
local MarkdownTable = require(script.Parent.Parent.NodeRenderers.MarkdownTable)
local renderInline = require(script.Parent.Parent.NodeRenderers.renderInline)
local renderTag = require(script.Parent.Parent.NodeRenderers.renderTag)
local BulletList = MarkdownCore.Components.BulletList

local getBaseTextElementEngineTags = TextStyle.getBaseTextElementEngineTags
local getCodeTextStyles = TextStyle.getCodeTextStyles
local normalizeStyleFont = TextStyle.normalizeStyleFont

local _Types = require(ComponentsParent.Types)
local Highlighter = MarkdownCore.Utils.Highlighter
local getNodeTypeConfig = require(ComponentsParent.Utils.getNodeTypeConfig)
local isInlineElement = InlineLayout.Utils.isInlineElement
local Flags = MarkdownCore.Flags
local var1 = Flags.FFlagMarkdownTables or Flags.FFlagMarkdownTagFallbacks

local BuilderSans = Enum.Font.BuilderSans
local uDim2 = UDim2.fromOffset(16, 16)

local Code = Enum.Font.Code

local font = Font.new("rbxasset://fonts/families/BuilderMono.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

local function func1(str1: string)
    print(`[Default link callback]: URL [{str1}] is clicked`)
end

local module = {
    renderers = {}
}

local function getFontFace(arg1, font2: Enum.Font): Font -- Luacid: Inlined by compiler; 3 call sites recovered
    local var2 = arg1.fontFace or arg1.font
    if typeof(var2) == "Font" then
        return var2
    elseif var2 then
        return Font.fromEnum(var2)
    end
    return Font.fromEnum(font2)
end

local function render(arg1, arg2)
    if not arg1 then
        return nil
    end

    local var2 = (if var1 and arg2.renderers then arg2.renderers else module.renderers)[arg1.name]
    if not var2 then
        warn(`No renderer found for node: {arg1.name}`)
        return nil
    end

    local var3 = var2(arg1, arg2)
    local nodeTypeConfig = getNodeTypeConfig(arg1)
    if nodeTypeConfig and not nodeTypeConfig.validateRenderResult(var3) then
        warn(`Invalid render result for node: {arg1.name} {arg1.text} of type: {arg1.type}`)
    end

    return var3
end

local function processChildren(arg1, arg2)
    local children = arg1.children
    if not children then
        return {}
    end

    local nodeTypeConfig = getNodeTypeConfig(arg1)
    local var2 = nodeTypeConfig and nodeTypeConfig.children or {}

    local result = {}
    for _, child in children do
        local type = child.type
        if not var2[type] then
            warn(
                `Invalid child node type. Parent node: {arg1.name} {arg1.text} of type: {arg1.type} has invalid child node: {child.name} {child.text} of type: {type}`
            )
        end

        local var3 = render(child, arg2)
        if not var3 then
            continue
        end

        if #var3 > 0 then
            for _, value in var3 do
                table.insert(result, value)
            end
        else
            table.insert(result, var3)
        end
    end

    return result
end

local function computeLineNumbers(text: string): string
    local textLen = #text
    local num1 = 0
    local num2 = 1
    local tbl1 = ({})

    while num1 <= textLen do
        local var2 = string.find(text, "\n", num1, true)
        if not var2 then
            break
        end

        tbl1[num2] = tostring(num2)
        num2 += 1
        num1 = var2 + 1
    end

    tbl1[num2] = tostring(num2)
    return table.concat(tbl1, "\n")
end

local function copyToClipboard(text) -- Luacid: Inlined by compiler; 1 call site recovered
    pcall(function()
        local messageId = MessageBusService:GetMessageId("ExternalContentSharing", "setClipboardText")

        return MessageBusService:Publish(messageId, { text = text })
    end)
end

local var2 = Dash.memoize(function(text)
    return function()
        copyToClipboard(text)
    end
end)

local function renderText(arg1, arg2)
    local tbl1 = {
        LayoutOrder = arg1.index,
        Text = processSoftBreaks(arg1.text),
        EngineTags = getBaseTextElementEngineTags(arg2.textStyles),
        fontStyle = {
            Font = if Flags.FFlagMarkdownAssistantParity then arg2.textStyles.fontFace else getFontFace(arg2.textStyles, BuilderSans),
            FontSize = arg2.textStyles.textSize
        },
        textStyle = {
            Color3 = if typeof(arg2.textStyles.color) == "string" then Color3.fromHex(arg2.textStyles.color) else arg2.textStyles.color,
            Transparency = arg2.textStyles.transparency
        },
        viewTags = arg2.textStyles.viewTags,
        tag = if Flags.FFlagMarkdownTables then arg2.textStyles.textTags else nil
    }
    if arg2.textStyles.selectable then
        return SelectableTextElement.new(tbl1)
    end
    return TextElement.new(tbl1)
end

local function renderHardBreak()
    return HardBreakElement
end

module.defaultRenderers = {
    ROOT = function(arg1, arg2) -- name: renderRoot
        return React.createElement(
            View,
            {
                tag = "size-full-0 auto-y col",
                BorderSizePixel = 0,
                backgroundStyle = { Transparency = 1 }
            },
            (arg2.processChildren(arg1, arg2))
        )
    end,
    HEADING = function(arg1, arg2) -- name: renderHeading
        local num1 = math.clamp(
            if not arg1.attributes or type(arg1.attributes.depth) ~= "number" then 1 else arg1.attributes.depth,
            1,
            #arg2.headerStyles
        )
        return React.createElement(
            View,
            {
                key = tostring(arg1.index),
                LayoutOrder = arg1.index,
                tag = "size-full-0 auto-y"
            },
            {
                UIPadding = shouldUseTopPadding(arg1) and React.createElement("UIPadding", { PaddingTop = UDim.new(0, 20) }),
                InlineLayout = renderInline(arg1, mergeContexts(arg2, { textStyles = arg2.headerStyles[num1] }))
            }
        )
    end,
    PARAGRAPH = function(arg1, arg2) -- name: renderParagraph
        return React.createElement(
            View,
            {
                key = tostring(arg1.index),
                LayoutOrder = arg1.index,
                tag = "size-full-0 auto-y"
            },
            {
                UIPadding = shouldUseTopPadding(arg1) and React.createElement("UIPadding", { PaddingTop = UDim.new(0, 10) }),
                InlineLayout = renderInline(arg1, arg2)
            }
        )
    end,
    CODE_BLOCK = function(arg1, arg2) -- name: renderCodeBlock
        local language = if arg1.attributes then arg1.attributes.language else nil
        local text = arg1.text
        local var3 = if language == "lua" then Highlighter.highlight(text, arg2.colorScheme) else text
        local codeTextStyles = getCodeTextStyles(arg2)

        local tbl1 = {
            TextWrapped = false,
            fontStyle = {
                FontSize = codeTextStyles.textSize,
                Font = if Flags.FFlagMarkdownAssistantParity then codeTextStyles.fontFace or font else getFontFace(codeTextStyles, Code),
                LineHeight = codeTextStyles.lineHeight
            },
            TextXAlignment = Enum.TextXAlignment.Left,
            tag = "auto-xy padding-small align-y-top"
        }

        local tbl2 = {
            Text = var3,
            textStyle = {
                Color3 = Highlighter.getTokenColor("iden")
            },
            RichText = true,
            ZIndex = 1
        }

        local tbl3 = {
            Text = text,
            textStyle = {
                Color3 = Highlighter.getTokenColor("iden"),
                Transparency = 0.4
            },
            ZIndex = 0,
            TextSelectable = true
        }

        local codeBackgroundStyles = arg2.codeBackgroundStyles or {}
        local backgroundColor3 = codeBackgroundStyles.backgroundColor3 or Highlighter.getTokenColor("background")
        local backgroundTransparency = codeBackgroundStyles.backgroundTransparency or 0

        local showLineNumbers = arg2.codeSettings and arg2.codeSettings.showLineNumbers
        local var5 = if showLineNumbers then computeLineNumbers(text) else nil
        local showCopyButton = arg2.codeSettings and arg2.codeSettings.showCopyButton

        local createElement = React.createElement
        local var6 = View
        local tbl4 = {
            key = tostring(arg1.index),
            LayoutOrder = arg1.index,
            tag = "size-full-0 auto-y col",
            backgroundStyle = { Transparency = 1 },
            BorderSizePixel = 0
        }

        local tbl5 = {
            UIPadding = React.createElement(
                "UIPadding",
                {
                    PaddingTop = if shouldUseTopPadding(arg1) then UDim.new(0, 10) else nil,
                    PaddingBottom = UDim.new(0, 10)
                }
            ),
            TitleBar = 0,
            CodeWrapper = 0
        }
        local element

        if showCopyButton then
            element = React.createElement(
                Foundation.View,
                {
                    tag = "size-full-0 auto-y row align-x-right bg-shift-300 radius-small",
                    LayoutOrder = 1
                },
                {
                    CopyToClipboardButton = React.createElement(Foundation.IconButton, {
                        size = Foundation.Enums.InputSize.Small,
                        icon = {
                            name = Foundation.Enums.IconName.TwoStackedSquares
                        },
                        onActivated = var2(text)
                    })
                }
            )
        else
            element = nil
        end

        tbl5.TitleBar = element

        tbl5.CodeWrapper = React.createElement(
            Foundation.View,
            {
                LayoutOrder = 2,
                tag = { ["size-full-0 auto-y"] = true, ["row align-y-center"] = showLineNumbers }
            },
            {
                LineNumbers = if showLineNumbers then React.createElement(Foundation.Text, {
                    Text = var5,
                    fontStyle = tbl1.fontStyle,
                    LayoutOrder = 1,
                    tag = "size-0-0 auto-xy text-align-x-right text-align-y-center padding-small bg-shift-100 content-emphasis"
                }) else nil,
                ScrollFrameWrapper = React.createElement(
                    Foundation.View,
                    {
                        tag = "size-full-0 auto-y fill",
                        Size = UDim2.fromScale(1, 0),
                        LayoutOrder = 2
                    },
                    {
                        ScrollFrame = React.createElement("ScrollingFrame", {
                            BackgroundColor3 = backgroundColor3,
                            BackgroundTransparency = backgroundTransparency,
                            BorderSizePixel = 0,
                            ScrollingDirection = Enum.ScrollingDirection.X,
                            Size = UDim2.fromScale(1, 0),
                            AutomaticSize = Enum.AutomaticSize.Y,
                            AutomaticCanvasSize = Enum.AutomaticSize.X
                        }, {
                            HighlightedCode = React.createElement(FoundationText, Dash.join(tbl1, tbl2)),
                            SelectableCodeWrapper = React.createElement(Foundation.View, {
                                tag = tbl1.tag
                            }, {
                                SelectableCode = React.createElement("TextBox", {
                                    Text = tbl3.Text,
                                    FontFace = tbl1.fontStyle.Font,
                                    TextSize = tbl1.fontStyle.FontSize,
                                    TextColor3 = tbl3.textStyle.Color3,
                                    TextTransparency = tbl3.textStyle.Transparency,
                                    BackgroundTransparency = 1,
                                    TextXAlignment = Enum.TextXAlignment.Left,
                                    TextYAlignment = Enum.TextYAlignment.Center,
                                    TextEditable = false,
                                    ZIndex = tbl3.ZIndex,
                                    Size = UDim2.fromScale(0, 0),
                                    AutomaticSize = Enum.AutomaticSize.XY,
                                    TextWrapped = false,
                                    ClearTextOnFocus = false,
                                    LineHeight = arg2.codeStyles.lineHeight
                                })
                            })
                        })
                    }
                )
            }
        )
        return createElement(var6, tbl4, tbl5)
    end,
    STYLED_TEXT = function(arg1, arg2) -- name: renderStyledText
        local style = if arg1.attributes and arg1.attributes.style then arg1.attributes.style else nil
        local tbl1 = {}
        if style == "BOLD" or style == "BOLD_2" then
            tbl1.bold = true
        elseif style == "ITALIC" or style == "ITALIC_2" then
            tbl1.italic = true
        elseif style == "UNDERLINE" then
            tbl1.underline = true
        elseif style == "STRIKE" then
            tbl1.strike = true
        elseif style == "INLINE_CODE" then
            local codeStyles = arg2.codeStyles
            tbl1 = Dash.joinDeep(codeStyles, { selectable = true })
        end
        return (arg2.processChildren(arg1, mergeContexts(arg2, { textStyles = tbl1 })))
    end,
    TEXT = renderText,
    LINK = function(arg1, arg2) -- name: renderLink
        local url = arg1.attributes and arg1.attributes.url or arg1.url or ""
        local var3 = arg2.processChildren(arg1, mergeContexts(arg2, { textStyles = { color = arg2.linkStyles.linkColor } }))

        local var4 = Dash.filter(var3, function(arg3)
            return isInlineElement(arg3) and arg3 ~= HardBreakElement
        end)
        return LinkElement.new(var4, {
            onActivated = function()
                arg2.linkCallback(url)
            end
        })
    end,
    LIST = function(arg1, arg2) -- name: renderList
        local items = {}

        local var3 = nil

        for i = #arg1.children, 1, -1 do
            local child = arg1.children[i]
            if child.name == "LIST" then
                var3 = child
            elseif var3 then
                local num1 = 1

                local tbl2 = {
                    Prefix = if child.attributes then child.attributes.prefix else nil,
                    Item = React.createElement(
                        View,
                        {
                            tag = "size-full-0 auto-y col",
                            BorderSizePixel = 0,
                            backgroundStyle = { Transparency = 1 }
                        },
                        {
                            Item = render(Dash.join(child, { index = 1 }), arg2),
                            List = render(Dash.join(var3, { index = 2 }), arg2)
                        }
                    )
                }
                table.insert(items, num1, tbl2)
                var3 = nil
            else
                table.insert(
                    items,
                    1,
                    {
                        Prefix = if child.attributes then child.attributes.prefix else nil,
                        Item = render(child, arg2)
                    }
                )
            end
        end

        return React.createElement(
            BulletList,
            {
                key = tostring(arg1.index),
                LayoutOrder = arg1.index,
                Items = items,
                TextWrapped = true,
                ListStyle = {
                    Font = if Flags.FFlagMarkdownAssistantParity then arg2.textStyles.fontFace else getFontFace(arg2.textStyles, BuilderSans),
                    TextColor = if typeof(arg2.textStyles.color) == "string" then Color3.fromHex(arg2.textStyles.color) else arg2.textStyles.color,
                    TextSize = arg2.textStyles.textSize,
                    LineHeight = arg2.textStyles.textSize
                },
                tag = "size-full-0 auto-y"
            },
            {
                UIPadding = shouldUseTopPadding(arg1) and React.createElement("UIPadding", { PaddingTop = UDim.new(0, 10) })
            }
        )
    end,
    LIST_ITEM = function(arg1, arg2) -- name: renderListItem
        return React.createElement(
            View,
            {
                key = tostring(arg1.index),
                LayoutOrder = arg1.index,
                tag = "size-full-0 auto-y"
            },
            {
                InlineLayout = renderInline(arg1, arg2)
            }
        )
    end,
    DIVIDER = function(arg1) -- name: renderThematicBreak
        return React.createElement(
            View,
            {
                key = tostring(arg1.index),
                tag = "size-full-0 auto-y",
                LayoutOrder = arg1.index
            },
            {
                UIPadding = shouldUseTopPadding(arg1) and React.createElement("UIPadding", { PaddingTop = UDim.new(0, 10) }),
                Divider = React.createElement(Divider)
            }
        )
    end,
    QUOTE = function(arg1, arg2) -- name: renderBlockquote
        return React.createElement(View, {
            key = tostring(arg1.index),
            LayoutOrder = arg1.index,
            tag = "size-full-0 auto-y padding-small",
            backgroundStyle = { Transparency = 1 }
        }, {
            InlineLayoutWrapper = React.createElement(
                View,
                {
                    backgroundStyle = {
                        Transparency = 0.9,
                        Color3 = Color3.fromRGB(163, 162, 165)
                    },
                    tag = "size-full-0 auto-y"
                },
                {
                    InlineLayout = renderInline(arg1, mergeContexts(arg2, { textStyles = { italic = true, transparency = 0.5 } }))
                }
            )
        })
    end,
    IMAGE = function(arg1, arg2) -- name: renderImage
        local url = arg1.attributes and arg1.attributes.url or arg1.url or nil
        return ImageElement.new({
            LayoutOrder = arg1.index,
            Image = url,
            Size = arg2.imageStyles.size,
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
    end,
    TAG = renderTag,
    BREAK = renderHardBreak,
    LINE_BREAK = renderHardBreak
}

if Flags.FFlagMarkdownTables then
    module.defaultRenderers.TABLE = MarkdownTable.renderTable
    module.defaultRenderers.TABLE_ROW = MarkdownTable.renderTableRow
    module.defaultRenderers.TABLE_HEADER = MarkdownTable.renderTableRow
    module.defaultRenderers.TABLE_CELL = MarkdownTable.renderTableCell
end
if Flags.FFlagMarkdownTagFallbacks then
    module.defaultRenderers.ACTION = renderText
end

function module.render(arg1, tbl1)
    module.renderers = tbl1.userRenderers

    local var3 = table.clone(tbl1.markdownRendererProps or {})
    local tbl2

    if Flags.FFlagMarkdownAssistantParity then
        var3.textStyles = normalizeStyleFont(var3.textStyles)
        var3.codeStyles = normalizeStyleFont(var3.codeStyles)
        if var3.headerStyles then
            var3.headerStyles = Dash.map(var3.headerStyles, normalizeStyleFont)
        end

        local bodyMedium = tbl1.tokens.Typography.BodyMedium
        local fontFace = normalizeStyleFont({ font = bodyMedium.Font }).fontFace
        local fontSize = bodyMedium.FontSize

        tbl2 = {
            textStyles = { textSize = fontSize, fontFace = fontFace },
            codeStyles = { textSize = fontSize, fontFace = font, lineHeight = 1.111 },
            headerStyles = {
                {
                    textSize = fontSize * 3,
                    fontFace = fontFace
                },
                {
                    textSize = fontSize * 2.5,
                    fontFace = fontFace
                },
                {
                    textSize = fontSize * 2,
                    fontFace = fontFace
                },
                {
                    textSize = fontSize * 1.5,
                    fontFace = fontFace
                },
                {
                    textSize = fontSize * 1.5,
                    fontFace = fontFace
                },
                {
                    textSize = fontSize * 1.5,
                    fontFace = fontFace
                }
            }
        }
    else
        tbl2 = {
            textStyles = { textSize = 18, font = BuilderSans },
            codeStyles = { textSize = 18, font = Code, lineHeight = 1.111 },
            headerStyles = {
                { textSize = 54, font = BuilderSans },
                { textSize = 45, font = BuilderSans },
                { textSize = 36, font = BuilderSans },
                { textSize = 27, font = BuilderSans }
            }
        }
    end

    local var4 = Dash.joinDeep({
        textStyles = tbl2.textStyles,
        codeStyles = tbl2.codeStyles,
        headerStyles = tbl2.headerStyles,
        imageStyles = { size = uDim2 },
        linkStyles = {
            linkColor = `#{tbl1.tokens.Color.Content.Link.Color3:ToHex()}`
        },
        isInline = false,
        linkCallback = tbl1.linkCallback or func1,
        colorScheme = tbl1.colorScheme,
        processChildren = processChildren
    }, var3)

    if var1 then
        var4.renderers = tbl1.userRenderers
    end

    table.freeze(var4)

    return (render(arg1, var4))
end

return module
