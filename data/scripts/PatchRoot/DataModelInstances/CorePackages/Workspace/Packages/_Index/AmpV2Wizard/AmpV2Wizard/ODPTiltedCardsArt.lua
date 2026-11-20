-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T21:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AmpV2WizardParent = script:FindFirstAncestor("AmpV2Wizard").Parent

local React = require(AmpV2WizardParent.React)

local Foundation = require(AmpV2WizardParent.Foundation)
local View = Foundation.View
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName

local vector2 = Vector2.new(50, -16)
local vector2_2 = Vector2.new(-50, 16)

local function renderCard(tbl1)
    return React.createElement(View, {
        tag = "col align-x-center align-y-center anchor-center-center stroke-standard stroke-default radius-large bg-surface-0",
        Size = UDim2.fromOffset(112, 112),
        Position = UDim2.new(0.5, tbl1.offset.X, 0.5, tbl1.offset.Y),
        Rotation = tbl1.rotation,
        ZIndex = tbl1.zIndex
    }, {
        Glyph = tbl1.glyph
    })
end

local function ODPTiltedCardsArt(tbl1)
    return React.createElement(View, {
        tag = "size-full-0",
        Size = UDim2.new(1, 0, 0, 200),
        LayoutOrder = tbl1.LayoutOrder,
        testId = "amp-v2-wizard-tilted-cards-art"
    }, {
        ShieldCard = renderCard({
            offset = vector2,
            rotation = 15,
            zIndex = 1,
            glyph = React.createElement(Icon, { name = IconName.ShieldCheck, size = 64, tag = "content-emphasis" })
        }),
        PeopleCard = renderCard({
            offset = vector2_2,
            rotation = -15,
            zIndex = 2,
            glyph = React.createElement(Icon, { name = IconName.PersonWithSmallerPerson, size = 64, tag = "content-emphasis" })
        })
    })
end

return ODPTiltedCardsArt
