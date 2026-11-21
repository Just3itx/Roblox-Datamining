-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:20:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local React = require(AuthCommonParent.React)
local Foundation = require(AuthCommonParent.Foundation)
local InlineRichText = require(AuthCommonParent.InlineRichText)

local createLegalLinkRenderer = require(AuthCommon.Utils.createLegalLinkRenderer)

local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens
local Renderer = InlineRichText.Renderer
local prepareRichTextCopy = InlineRichText.prepareRichTextCopy

local function LegalTextWithLinks(tbl1)
    local var1 = useTokens()
    local onLinkActivated = tbl1.onLinkActivated
    local renderers = React.useMemo(function()
        return {
            LINK = createLegalLinkRenderer(function(str1: string)
                if onLinkActivated then
                    onLinkActivated(str1)
                end
            end)
        }
    end, { onLinkActivated })
    local text = React.useMemo(function()
        return prepareRichTextCopy(tbl1.text)
    end, { tbl1.text })

    return React.createElement(
        View,
        {
            tag = "size-full-0 auto-y",
            LayoutOrder = tbl1.LayoutOrder,
            testId = tbl1.testId
        },
        {
            Text = React.createElement(Renderer, {
                text = text,
                renderers = renderers,
                textStyle = var1.Color.Content.Muted,
                fontStyle = var1.Typography.CaptionSmall,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                wrapperProps = { tag = "size-full-0 auto-y" }
            })
        }
    )
end

return LegalTextWithLinks
