-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local React = require(AvatarExperienceProfilePictureEditorParent.React)
local Foundation = require(AvatarExperienceProfilePictureEditorParent.Foundation)
local IconOnlyMenu = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceControlBar.IconOnlyMenu)
local _ControlBarTypes = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceControlBar.ControlBarTypes)

local View = Foundation.View
local IconName = Foundation.Enums.IconName
local useTokens = Foundation.Hooks.useTokens

local function ProfilePictureCameraControlBar(tbl1)
    local var1 = useTokens()
    local var2, var3 = React.useBinding(UDim2.fromOffset(0, 0))

    local onZoomIn = tbl1.onZoomIn
    local onZoomOut = tbl1.onZoomOut
    local onRotateLeft = tbl1.onRotateLeft
    local onRotateRight = tbl1.onRotateRight

    local items = React.useMemo(function()
        return {
            {
                type = "icon",
                id = "zoom-in",
                icon = IconName.PlusLarge,
                isActive = false,
                onActivated = onZoomIn
            },
            {
                type = "icon",
                id = "zoom-out",
                icon = IconName.Minus,
                isActive = false,
                onActivated = onZoomOut
            },
            { type = "divider", id = "zoom-rotate-divider" },
            {
                type = "icon",
                id = "rotate-left",
                icon = IconName.ArrowSpinCounterClockwise,
                isActive = false,
                onActivated = onRotateLeft
            },
            {
                type = "icon",
                id = "rotate-right",
                icon = IconName.ArrowSpinClockwise,
                isActive = false,
                onActivated = onRotateRight
            }
        }
    end, {
        onZoomIn,
        onZoomOut,
        onRotateLeft,
        onRotateRight
    })
    return React.createElement(View, {
        tag = "position-top-left auto-xy",
        padding = {
            top = UDim.new(0, tbl1.topOffset or 0),
            left = UDim.new(0, var1.Padding.XLarge)
        },
        ZIndex = tbl1.zIndex,
        testId = "profile-picture-camera-control-bar"
    }, {
        Rail = React.createElement(View, {
            tag = "no-clip",
            Size = var2,
            selectionGroup = {
                SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
                SelectionBehaviorDown = Enum.SelectionBehavior.Stop
            }
        }, {
            Menu = React.createElement(IconOnlyMenu, {
                items = items,
                activeItemId = "",
                onAbsoluteSizeChanged = function(arg1)
                    var3(UDim2.fromOffset(arg1.AbsoluteSize.X, arg1.AbsoluteSize.Y))
                end
            })
        })
    })
end

return ProfilePictureCameraControlBar
