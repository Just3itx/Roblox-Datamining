-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local _Types = require(scriptParent.Types)
local TooltipOrientation = require(scriptParentParent.Tooltip.Enum.TooltipOrientation)
local Images = require(scriptParentParentParent.ImageSet.Images)

local uDim2 = UDim2.fromOffset(16, 8)

local CONTENT_TO_CARET_TIP = uDim2.Y.Offset - 1

local Small = {
    IMAGE = Images["component_assets/dropshadow_17_4"],
    SLICE_CENTER = Rect.new(12, 12, 13, 13),
    OFFSET = {
        [TooltipOrientation.Top] = 2,
        [TooltipOrientation.Bottom] = 6,
        [TooltipOrientation.Right] = 4,
        [TooltipOrientation.Left] = 4
    }
}

local Large = {
    IMAGE = Images["component_assets/dropshadow_17_16"],
    SLICE_CENTER = Rect.new(36, 36, 37, 37),
    OFFSET = {
        [TooltipOrientation.Top] = 28,
        [TooltipOrientation.Bottom] = 28,
        [TooltipOrientation.Right] = 28,
        [TooltipOrientation.Left] = 28
    }
}
local tbl3 = {
    DEFAULT_PADDING = 12,
    DEFAULT_LIST_PADDING = 8,
    CORNER_RADIUS = UDim.new(0, 8),
    CARET_DISTANCE = 4,
    CONTENT_TO_CARET_TIP = CONTENT_TO_CARET_TIP,
    CONTENT_TO_CARET_CENTER = CONTENT_TO_CARET_TIP - uDim2.Y.Offset / 2,
    MAX_WIDTH = 240,
    HOTKEY_PADDING = 6,
    CARET_IMAGE = Images["component_assets/triangleDown_16"],
    CARET_ROTATION = {
        [TooltipOrientation.Top] = 0,
        [TooltipOrientation.Bottom] = 180,
        [TooltipOrientation.Right] = 90,
        [TooltipOrientation.Left] = 270
    },
    CARET_SIZE = uDim2,
    CLOSE_BUTTON_SIZE = 24,
    CLOSE_BUTTON_PADDING = 4,
    DropShadow = { Small = Small, Large = Large },
    ORIENTATION_VECTOR = {
        [TooltipOrientation.Top] = Vector2.new(0, -1),
        [TooltipOrientation.Bottom] = Vector2.new(0, 1),
        [TooltipOrientation.Left] = Vector2.new(-1, 0),
        [TooltipOrientation.Right] = Vector2.new(1, 0)
    },
    OPPOSITE_ORIENTATION = {
        [TooltipOrientation.Top] = TooltipOrientation.Bottom,
        [TooltipOrientation.Bottom] = TooltipOrientation.Top,
        [TooltipOrientation.Right] = TooltipOrientation.Left,
        [TooltipOrientation.Left] = TooltipOrientation.Right
    },
    DISTANCE_TO_CONTENT = 4 + CONTENT_TO_CARET_TIP,
    SCREEN_MARGIN = 12,
    MIN_DISTANCE_TO_CARET_MIDDLE = 12 + uDim2.X.Offset / 2,
    INACTIVE_ANIMATION_TARGETS = { distanceOffset = -4, transparency = 1 },
    ACTIVE_ANIMATION_TARGETS = { distanceOffset = 0, transparency = 0 },
    ANIMATION_OPTIONS = { frequency = 5 },
    DEFAULT_DELAY_TIME = 0.4
}

return table.freeze(tbl3)
