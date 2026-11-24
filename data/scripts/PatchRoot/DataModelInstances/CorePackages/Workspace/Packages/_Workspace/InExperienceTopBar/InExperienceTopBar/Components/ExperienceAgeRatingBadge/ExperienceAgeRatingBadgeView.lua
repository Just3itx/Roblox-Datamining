-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceTopBarParent = script:FindFirstAncestor("InExperienceTopBar").Parent

local Foundation = require(InExperienceTopBarParent.Foundation)
local React = require(InExperienceTopBarParent.React)

local Badge = Foundation.Badge
local BadgeVariant = Foundation.Enums.BadgeVariant
local BadgeShape = Foundation.Enums.BadgeShape
local BadgeSize = Foundation.Enums.BadgeSize
local View = Foundation.View

local function ExperienceAgeRatingBadgeView(tbl1)
    return React.createElement(View, {
        tag = "row align-x-center align-y-center auto-xy",
        LayoutOrder = tbl1.layoutOrder,
        onAbsoluteSizeChanged = tbl1.onAbsoluteSizeChanged,
        onAbsolutePositionChanged = tbl1.onAbsolutePositionChanged
    }, {
        Rating = React.createElement(Badge, {
            text = `<b>{tbl1.text}</b>`,
            variant = BadgeVariant.Contrast,
            shape = BadgeShape.Pill,
            size = BadgeSize.Small
        })
    })
end

return ExperienceAgeRatingBadgeView
