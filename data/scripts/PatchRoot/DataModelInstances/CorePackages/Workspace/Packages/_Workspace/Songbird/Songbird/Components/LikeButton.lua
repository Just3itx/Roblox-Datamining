-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:51:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local constants = require(Songbird.constants)
local Cryo = require(Songbird.Parent.Cryo)
local React = require(Songbird.Parent.React)
local Foundation = require(Songbird.Parent.Foundation)

local tbl1 = {
    size = constants.ICON_SIZE
}

local function LikeButton(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)

    return React.createElement(Foundation.IconButton, {
        icon = if var1.isFavorited then "icons/common/ratingFilled_medium" else "icons/common/rating_medium",
        size = Foundation.Enums.IconSize.Medium,
        onActivated = not var1.onFavorite and function() end or var1.onFavorite
    })
end

return LikeButton
