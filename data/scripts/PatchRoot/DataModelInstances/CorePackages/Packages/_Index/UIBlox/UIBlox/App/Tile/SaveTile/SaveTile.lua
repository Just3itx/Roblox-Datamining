-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParent = scriptParentParent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)
local Cryo = require(scriptParentParentParentParentParent.Cryo)
local t = require(scriptParentParentParentParentParent.t)

local Images = require(scriptParentParentParentParent.App.ImageSet.Images)
local Tile = require(scriptParentParent.BaseTile.Tile)

local var1 = Roact.PureComponent:extend("SaveTile")

var1.validateProps = t.strictInterface({
    hasRoundedCorners = t.optional(t.boolean),
    onActivated = t.optional(t.callback),
    isDisabled = t.optional(t.boolean),
    thumbnail = t.optional(t.union(t.string, t.table)),
    thumbnailSize = t.optional(t.UDim2),
    thumbnailTransparency = t.optional(t.number),
    NextSelectionLeft = t.optional(t.table),
    NextSelectionRight = t.optional(t.table),
    NextSelectionUp = t.optional(t.table),
    NextSelectionDown = t.optional(t.table),
    thumbnailRef = t.optional(t.table),
    isRoactGamepadEnabled = t.optional(t.boolean)
})

var1.defaultProps = {
    hasRoundedCorners = true,
    thumbnail = Images["icons/actions/edit/add"],
    thumbnailSize = UDim2.new(0, 36, 0, 36),
    thumbnailTransparency = 0,
    isRoactGamepadEnabled = true
}

function var1.render(arg1)
    local hasRoundedCorners = arg1.props.hasRoundedCorners
    local onActivated = arg1.props.onActivated
    local isDisabled = arg1.props.isDisabled
    local thumbnail = arg1.props.thumbnail
    local thumbnailSize = arg1.props.thumbnailSize
    local thumbnailTransparency = arg1.props.thumbnailTransparency

    return Roact.createElement(Tile, {
        hasRoundedCorners = hasRoundedCorners,
        name = "",
        onActivated = onActivated,
        isDisabled = isDisabled,
        thumbnail = thumbnail,
        thumbnailSize = thumbnailSize,
        thumbnailTransparency = thumbnailTransparency,
        isRoactGamepadEnabled = arg1.props.isRoactGamepadEnabled,
        NextSelectionLeft = arg1.props.NextSelectionLeft,
        NextSelectionRight = arg1.props.NextSelectionRight,
        NextSelectionUp = arg1.props.NextSelectionUp,
        NextSelectionDown = arg1.props.NextSelectionDown,
        [Roact.Ref] = arg1.props.thumbnailRef
    })
end

return Roact.forwardRef(function(arg1, thumbnailRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { thumbnailRef = thumbnailRef }))
end)
