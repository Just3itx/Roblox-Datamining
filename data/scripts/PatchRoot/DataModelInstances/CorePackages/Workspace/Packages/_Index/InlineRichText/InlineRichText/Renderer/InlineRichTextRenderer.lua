-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InlineRichText = script:FindFirstAncestor("InlineRichText")
local InlineRichTextParent = InlineRichText.Parent
local var1 = require(InlineRichText.Logger):new(script.Name)

local Cryo = require(InlineRichTextParent.Cryo)
local Foundation = require(InlineRichTextParent.Foundation)
local React = require(InlineRichTextParent.React)
local _Types = require(InlineRichText.Types)

local InlineLayout = require(InlineRichTextParent.InlineLayout).Components.InlineLayout

local NodeType = require(InlineRichText.Enums.NodeType)
local parseXml = require(InlineRichText.Parser.parseXml)
local processChildren = require(InlineRichText.Renderer.processChildren)
local TextSpanRenderer = require(InlineRichText.Renderer.NodeRenderers.TextSpanRenderer)
local LinkRenderer = require(InlineRichText.Renderer.NodeRenderers.LinkRenderer)
local IconRenderer = require(InlineRichText.Renderer.NodeRenderers.IconRenderer)
local HardbreakRenderer = require(InlineRichText.Renderer.NodeRenderers.HardbreakRenderer)
local useLinkerOnActivated = require(InlineRichText.Linker.useLinkerOnActivated)
local LinkType = require(InlineRichText.Enums.LinkType)
local LinkBehavior = require(InlineRichText.Enums.LinkBehavior)
local getLinkType = require(InlineRichText.Linker.getLinkType)

local function createDefaultRootNode(text: string)
    return {
        name = "ROOT",
        text = "",
        type = NodeType.Root,
        children = {{
            name = "TEXT",
            text = "",
            type = NodeType.InlineCustom,
            children = {{
                name = "PLAINTEXT",
                text = text,
                type = NodeType.Plaintext,
                children = {},
                attributes = {},
                index = 2
            }},
            attributes = {},
            index = 1
        }},
        attributes = {},
        index = 0
    }
end

local tbl1 = {
    TEXT_SPAN = TextSpanRenderer,
    LINK = LinkRenderer,
    ICON = IconRenderer,
    BREAK = HardbreakRenderer
}
local tbl2 = {
    [LinkType.Http] = LinkBehavior.Webview,
    [LinkType.LinkingProtocolRegistered] = LinkBehavior.LinkingProtocol,
    [LinkType.Default] = LinkBehavior.ErrorToast
}
local tbl3 = {
    evaluateLinkBehavior = function(_: string, arg1)
        return tbl2[arg1] or LinkBehavior.ErrorToast
    end,
    errorToastText = nil,
    onActivatedSubscriber = nil
}

local function InlineRichTextRenderer(arg1)
    local ast = arg1.ast
    local text = arg1.text
    local var2 = React.useMemo(function()
        if ast then
            return ast
        end
        local var2, var3 = parseXml(text, arg1.parserOptions)
        if var2 then
            return var3
        end

        var1:warning(`Error parsing XML input into AST: {var3}`)
        return (createDefaultRootNode(text))
    end, { text, ast })

    local tokens = Foundation.Hooks.useTokens()
    local default = tokens.Color.Content.Default
    local tbl4 = {
        Font = Enum.Font.BuilderSans,
        FontSize = tokens.FontSize.FontSize_400,
        LineHeight = tokens.LineHeight.LineHeight_140
    }

    local var4 = Cryo.Dictionary.union(tbl3, arg1.linkerOptions or {})
    local var5 = useLinkerOnActivated({ errorToastTextOverride = var4.errorToastText })

    local onActivated = React.useCallback(function(arg2)
        var5(arg2)
        if not var4.onActivatedSubscriber then
            return
        end

        local success, result = pcall(function(): boolean
            var4.onActivatedSubscriber(arg2)
            return true
        end)
        if not success then
            var1:warning(`Error notifying link activation subscriber: {tostring(result)}`)
        end
    end, { var4.onActivatedSubscriber, var5 })
    local evaluateLinkBehavior = React.useCallback(function(str1: string)
        return var4.evaluateLinkBehavior(str1, getLinkType(str1))
    end, { var4.evaluateLinkBehavior })

    local var8 = React.useMemo(function()
        return {
            inlineCustomRenderers = Cryo.Dictionary.join(tbl1, arg1.renderers or {}),
            processChildren = processChildren,
            nodeProps = arg1.nodeProps or {},
            styles = {
                textStyle = Cryo.Dictionary.union(default, arg1.textStyle or {}),
                fontStyle = Cryo.Dictionary.union(tbl4, arg1.fontStyle or {})
            },
            tokens = tokens,
            linker = { onActivated = onActivated, evaluateLinkBehavior = evaluateLinkBehavior }
        }
    end, {
        arg1.renderers,
        arg1.nodeProps,
        arg1.textStyle,
        arg1.fontStyle,
        onActivated,
        evaluateLinkBehavior
    })

    local elements = React.useMemo(function()
        return processChildren(var2, var8)
    end, { var2 and var2.children, var8 })

    return React.createElement(Foundation.View, arg1.wrapperProps, {
        RichTextRoot = React.createElement(InlineLayout, {
            Elements = elements,
            HorizontalAlignment = arg1.HorizontalAlignment,
            VerticalPadding = UDim.new(0, var8.styles.fontStyle.FontSize * (var8.styles.fontStyle.LineHeight - 1) / 2)
        })
    })
end

return InlineRichTextRenderer
