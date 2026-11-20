-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Button = require(Foundation.Components.Button)
local Card = require(Foundation.Components.Card)
local _Types = require(Foundation.Components.Types)

local BannerSize = require(Foundation.Enums.BannerSize)
local ButtonVariant = require(Foundation.Enums.ButtonVariant)
local CardDensity = require(Foundation.Enums.CardDensity)
local CardHeaderSize = require(Foundation.Enums.CardHeaderSize)
local CardVariant = require(Foundation.Enums.CardVariant)
local InputSize = require(Foundation.Enums.InputSize)

local withCommonProps = require(Foundation.Utility.withCommonProps)
local withDefaults = require(Foundation.Utility.withDefaults)

local _Thumbnail = require(script.Parent.Subcomponents.Thumbnail)
local UpsellContent = require(script.Parent.Subcomponents.UpsellContent)

local tbl1 = {
    size = BannerSize.Medium,
    density = CardDensity.Default,
    testId = "--foundation-banner"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: Banner
    local var1 = withDefaults(arg1, tbl1)
    local primary = if arg1.actions then arg1.actions.primary else nil
    local tbl2 = {
        variant = CardVariant.Emphasis,
        density = var1.density,
        headerSize = if var1.density == CardDensity.Compact then CardHeaderSize.Small else CardHeaderSize.Medium,
        onActivated = if primary then primary.onActivated else nil,
        ref = ref
    }
    local tbl3

    if arg1.size == BannerSize.Small then
        tbl3 = { UpsellContent = 0 }
        local createElement = React.createElement
        local var2 = UpsellContent
        local tbl4 = {
            density = var1.density,
            title = var1.title,
            description = var1.description,
            thumbnail = arg1.thumbnail,
            onActivated = if primary then primary.onActivated else nil,
            onClose = if primary then nil else arg1.onClose,
            testId = var1.testId
        }
        tbl3.UpsellContent = createElement(var2, tbl4)
    else
        local secondary = if arg1.actions then arg1.actions.secondary else nil

        if arg1.onClose then
            tbl2.onClose = arg1.onClose
        end
        tbl2.title = var1.title
        tbl2.description = var1.description
        tbl2.lineClamp = {
            description = if var1.density == CardDensity.Compact then 2 else 3
        }
        tbl2.media = typeof(arg1.media) == "table" and {
            image = arg1.media.image,
            width = arg1.media.width
        } or arg1.media
        tbl3 = secondary
            and {
                SecondaryAction = React.createElement(Button, {
                    text = secondary.text,
                    onActivated = secondary.onActivated,
                    variant = ButtonVariant.SoftEmphasis,
                    size = InputSize.Small,
                    LayoutOrder = 1,
                    testId = `{var1.testId}--secondary-action`
                })
            }
            or nil
    end

    return React.createElement(Card, withCommonProps(var1, tbl2), tbl3)
end))
