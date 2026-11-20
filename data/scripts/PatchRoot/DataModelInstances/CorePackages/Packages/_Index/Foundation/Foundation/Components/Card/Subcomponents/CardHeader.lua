-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local _BuilderIcons = require(FoundationParent.BuilderIcons)
local React = require(FoundationParent.React)

local Icon = require(Foundation.Components.Icon)
local InputSize = require(Foundation.Enums.InputSize)
local Text = require(Foundation.Components.Text)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local getSharedVariants = require(Foundation.Components.Button.getSharedVariants)
local _useCardVariants = require(script.Parent.Parent.useCardVariants)
local useTokens = require(Foundation.Providers.Style.useTokens)

local function CardHeader(tbl1)
    local var1 = useTokens()
    local variantProps = tbl1.variantProps
    local gap = variantProps.titleRow.gap
    local name = if typeof(tbl1.icon) == "table" then tbl1.icon.name else tbl1.icon
    local variant = if typeof(tbl1.icon) == "table" then tbl1.icon.variant else nil
    local y = if tbl1.descriptionLineClamp == nil then nil else variantProps.description.lineHeight * tbl1.descriptionLineClamp
    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = variantProps.headerText.tag,
        LayoutOrder = 1,
        testId = `{tbl1.testId}--header-content`
    }
    local tbl3 = {
        Eyebrow = if tbl1.eyebrow and tbl1.title ~= nil then React.createElement(
            Text,
            {
                Text = tbl1.eyebrow,
                tag = variantProps.eyebrow.tag,
                LayoutOrder = 1,
                testId = `{tbl1.testId}--eyebrow`
            }
        ) else nil,
        TitleRow = 0,
        Description = 0
    }
    local element

    if tbl1.title == nil then
        element = nil
    else
        element = React.createElement(View, {
            tag = variantProps.titleRow.tag,
            layout = gap and {
                FillDirection = Enum.FillDirection.Horizontal,
                Padding = UDim.new(0, gap)
            } or nil,
            LayoutOrder = 2,
            testId = `{tbl1.testId}--title-row`
        }, {
            Icon = if name then React.createElement(Icon, {
                name = name,
                variant = variant,
                size = variantProps.icon.size,
                LayoutOrder = 1,
                testId = `{tbl1.testId}--icon`
            }) else nil,
            Title = if tbl1.title then React.createElement(
                Text,
                {
                    Text = tbl1.title,
                    tag = variantProps.title.tag,
                    LayoutOrder = 2,
                    testId = `{tbl1.testId}--title`
                }
            ) else nil
        })
    end

    tbl3.TitleRow = element
    local element2

    if tbl1.description then
        element2 = React.createElement(Text, {
            Text = tbl1.description,
            TextTruncate = if y then Enum.TextTruncate.AtEnd else nil,
            sizeConstraint = y and {
                MaxSize = Vector2.new(math.huge, y)
            } or nil,
            tag = variantProps.description.tag,
            LayoutOrder = 3,
            testId = `{tbl1.testId}--description`
        })
    else
        element2 = nil
    end

    tbl3.Description = element2
    local element3 = createElement(var3, tbl2, tbl3)

    local height = getSharedVariants(var1).sizes[InputSize.Small].container.height

    return React.createElement(View, {
        tag = variantProps.header.tag,
        sizeConstraint = {
            MinSize = Vector2.new(0, height)
        },
        LayoutOrder = 1,
        testId = `{tbl1.testId}--header`
    }, {
        Text = element3,
        Actions = tbl1.actions
    })
end

return CardHeader
