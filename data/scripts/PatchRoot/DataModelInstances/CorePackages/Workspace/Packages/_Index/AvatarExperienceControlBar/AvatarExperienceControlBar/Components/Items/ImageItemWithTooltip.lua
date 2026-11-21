-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceControlBar = script:FindFirstAncestor("AvatarExperienceControlBar")

local AvatarExperienceControlBarParent = AvatarExperienceControlBar.Parent
local React = require(AvatarExperienceControlBarParent.React)
local Foundation = require(AvatarExperienceControlBarParent.Foundation)
local FocusNavigationUtils = require(AvatarExperienceControlBarParent.FocusNavigationUtils)
local Tooltip = require(AvatarExperienceControlBar.Components.Tooltip)
local _ControlBarTypes = require(AvatarExperienceControlBar.ControlBarTypes)
local ImageItem = require(script.Parent.ImageItem)

return React.forwardRef(function(arg1, ref) -- name: ImageItemWithTooltip
    local gui = FocusNavigationUtils.FocusNavigableSurfaceRegistry.useRegistryEntry(
        FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum.Auxiliary
    )
    local var2 = table.clone(arg1.toolTipConfig)
    var2.LayoutOrder = arg1.LayoutOrder
    var2.Visible = arg1.Visible
    var2.open = not (arg1.Visible == false) and var2.open

    local children = React.createElement(
        Tooltip,
        var2,
        React.createElement(ImageItem, {
            thumbnailUrl = arg1.thumbnailUrl,
            isActive = arg1.isActive,
            size = arg1.size,
            onActivated = arg1.onActivated,
            disabled = arg1.disabled,
            enableFocusAnimation = arg1.enableFocusAnimation,
            Visible = arg1.Visible,
            LayoutOrder = arg1.LayoutOrder,
            hideIndicator = arg1.hideIndicator,
            ref = ref
        })
    )
    if arg1.toolTipConfig.compact and gui then
        return React.createElement(Foundation.OverlayProvider, { gui = gui, children = children })
    end
    return children
end)
