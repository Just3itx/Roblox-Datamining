-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local ButtonVariant = require(Foundation.Enums.ButtonVariant)
local InputSize = require(Foundation.Enums.InputSize)

local Icon = require(Foundation.Components.Icon)
local IconButton = require(Foundation.Components.IconButton)
local Text = require(Foundation.Components.Text)
local View = require(Foundation.Components.View)

local useTokens = require(Foundation.Providers.Style.useTokens)

local Thumbnail = require(script.Parent.Thumbnail)
local useUpsellContentVariants = require(script.Parent.useUpsellContentVariants)

local Icon2 = BuilderIcons.Icon

local function UpsellContent(tbl1)
    local var1 = useTokens()
    local var2 = useUpsellContentVariants(var1, tbl1.density)
    local bool1 = tbl1.onActivated ~= nil

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = var2.container.tag,
        LayoutOrder = 1,
        testId = `{tbl1.testId}--upsell-content`
    }
    local tbl3 = {
        Thumbnail = if tbl1.thumbnail then React.createElement(
            Thumbnail,
            {
                thumbnail = tbl1.thumbnail,
                density = tbl1.density,
                testId = tbl1.testId,
                LayoutOrder = 1
            }
        ) else nil,
        Content = React.createElement(
            View,
            {
                tag = var2.content.tag,
                LayoutOrder = 2,
                testId = `{tbl1.testId}--upsell-content--body`
            },
            {
                Title = if tbl1.title then React.createElement(
                    Text,
                    {
                        Text = tbl1.title,
                        tag = var2.title.tag,
                        LayoutOrder = 1,
                        testId = `{tbl1.testId}--title`
                    }
                ) else nil,
                Description = if tbl1.description then React.createElement(Text, {
                    Text = tbl1.description,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    sizeConstraint = var2.description.sizeConstraint,
                    tag = var2.description.tag,
                    LayoutOrder = 2,
                    testId = `{tbl1.testId}--description`
                }) else nil
            }
        ),
        Chevron = if bool1 then React.createElement(
            Icon,
            {
                name = Icon2.ChevronSmallRight,
                LayoutOrder = 3,
                testId = `{tbl1.testId}--chevron`
            }
        ) else nil,
        Close = if tbl1.onClose and not bool1 then React.createElement(IconButton, {
            onActivated = tbl1.onClose,
            icon = Icon2.X,
            variant = ButtonVariant.Utility,
            size = InputSize.Small,
            isCircular = true,
            LayoutOrder = 4,
            testId = `{tbl1.testId}--close`
        }) else nil
    }
    return createElement(var3, tbl2, tbl3)
end

return UpsellContent
