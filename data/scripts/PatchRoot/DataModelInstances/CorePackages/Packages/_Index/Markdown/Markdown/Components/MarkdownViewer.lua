-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ComponentsParent = script:FindFirstAncestor("Components").Parent
local ComponentsParentParent = ComponentsParent.Parent

local React = require(ComponentsParentParent.React)
local Dash = require(ComponentsParentParent.Dash)
local Foundation = require(ComponentsParentParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local MarkdownCore = require(ComponentsParentParent.MarkdownCore)

local CommonMarkComplianceParser = require(ComponentsParent.Parsers.CommonMarkComplianceParser)
local Flags = require(ComponentsParent.Flags)
local _Types = require(ComponentsParent.Types)
local MarkdownRenderer = require(script.MarkdownRenderer)
local Flags2 = MarkdownCore.Flags

local function profileParser(str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
    if str1 == "RobloxMarkdown" then
        return require(ComponentsParent.Parsers.RobloxMarkdown.RendererParser)
    elseif str1 == "CommonMark" then
        return require(ComponentsParent.Parsers.CommonMark.RendererParser)
    end
    return nil
end

local function MarkdownViewer(tbl1)
    local tokens = useTokens()

    if not (Flags2.FFlagMarkdownAssistantParity or tbl1.Markdown or tbl1.Ast) then
        warn("MarkdownViewer requires either a Markdown string or an Ast in props")
        return nil
    end

    local userRenderers = React.useMemo(function()
        return Dash.join(MarkdownRenderer.defaultRenderers, tbl1.Renderers or {}, tbl1.AdditionalFeatureRenderers or {})
    end, Flags2.FFlagMarkdownAssistantParity and { tbl1.Renderers, tbl1.AdditionalFeatureRenderers } or { tbl1.Renderers })

    local var3 = if Flags2.FFlagMarkdownTables or Flags2.FFlagMarkdownTagFallbacks then tbl1.IsStreaming and {
        isStreaming = true
    } or nil else nil
    local tbl2 = (Flags2.FFlagMarkdownTables or Flags2.FFlagMarkdownTagFallbacks)
        and {
            tbl1.Markdown,
            tbl1.Ast,
            tbl1.IsStreaming,
            tbl1.ParserProfile
        }
        or { tbl1.Markdown, tbl1.Ast, tbl1.ParserProfile }

    local var4, var5 = React.useMemo(function()
        if tbl1.Ast then
            return true, tbl1.Ast
        end
        if not tbl1.Markdown then
            return true, nil
        end

        local fFlagMarkdownDefaultRobloxProfile = Flags.FFlagMarkdownDefaultRobloxProfile
        local var4

        if Flags.FFlagMarkdownUseRobloxProfileParser or fFlagMarkdownDefaultRobloxProfile then
            local var5 = tbl1.ParserProfile or (if fFlagMarkdownDefaultRobloxProfile then "RobloxMarkdown" else nil)

            if var5 == "RobloxMarkdown" then
                var4 = profileParser("RobloxMarkdown")
            elseif var5 == "CommonMark" then
                var4 = profileParser("CommonMark")
            else
                var4 = nil
            end
        else
            var4 = nil
        end

        local var5, var6

        if var4 ~= nil then
            var5, var6 = var4.safeParse(tbl1.Markdown, var3)
        else
            var5, var6 = CommonMarkComplianceParser.safeParse(tbl1.Markdown, var3)
        end
        if not var5 then
            if tbl1.OnError then
                tbl1.OnError(var6)
                return var5, var6
            end
            warn("MarkdownViewer: Error parsing markdown.", var6)
        end

        return var5, var6
    end, tbl2)

    local var6 = React.useMemo(function()
        if not var4 then
            return nil
        end
        return MarkdownRenderer.render(var5, {
            userRenderers = userRenderers,
            linkCallback = tbl1.LinkCallback,
            markdownRendererProps = tbl1.MarkdownRendererProps,
            colorScheme = tbl1.ColorScheme,
            tokens = tokens
        })
    end, Flags2.FFlagMarkdownAssistantParity
        and {
            var4,
            var5,
            tbl1.LinkCallback,
            tbl1.MarkdownRendererProps,
            tbl1.ColorScheme,
            userRenderers,
            tokens
        }
        or {
            var4,
            var5,
            tbl1.LinkCallback,
            tbl1.MarkdownRendererProps,
            tbl1.ColorScheme,
            userRenderers
        })

    if Flags2.FFlagMarkdownAssistantParity and not (tbl1.Markdown or tbl1.Ast) then
        warn("MarkdownViewer requires either a Markdown string or an Ast in props")
        return nil
    elseif not var4 then
        return tbl1.Fallback
            or React.createElement(
                View,
                Dash.join({ tag = "size-full-0 auto-y", backgroundStyle = { Transparency = 1 } }, tbl1.WrapperProps or {}),
                React.createElement(FoundationText, { Text = "Failed to parse the provided markdown" })
            )
    else
        return React.createElement(
            View,
            Dash.join(
                {
                    tag = "col size-full-0 auto-y",
                    backgroundStyle = { Transparency = 1 },
                    BorderSizePixel = 0
                },
                tbl1.WrapperProps or {}
            ),
            var6
        )
    end
end

return MarkdownViewer
