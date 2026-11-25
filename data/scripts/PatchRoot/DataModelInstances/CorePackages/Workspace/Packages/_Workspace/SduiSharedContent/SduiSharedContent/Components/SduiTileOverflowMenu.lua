-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local AppBlox = require(SduiSharedContentParent.AppBlox)
local Foundation = require(SduiSharedContentParent.Foundation)
local React = require(SduiSharedContentParent.React)
local Responsive = require(SduiSharedContentParent.Responsive)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)

local GetInputModeStore = Responsive.GetInputModeStore
local InputSize = Foundation.Enums.InputSize
local getSduiComponentWrapper = SduiCoreSystem.getSduiComponentWrapper
local useGameTileOverflowMenuFocusNavigation = require(SduiSharedContentParent.GameTile).useGameTileOverflowMenuFocusNavigation
local useOverflowMenuOpen = AppBlox.useOverflowMenuOpen
local useTokens = Foundation.Hooks.useTokens

local FFlagSduiGameTileDirectAction = require(SduiSharedContentParent.SharedFlags).FFlagSduiGameTileDirectAction

return React.memo(function(tbl1) -- name: SduiTileOverflowMenu
    local var1 = useTokens()
    local var2 = useOverflowMenuOpen(tbl1.menuKey)

    local setFocusRef = useGameTileOverflowMenuFocusNavigation(tbl1.menuKey, tbl1.isSelected, tbl1.parentRef, tbl1.onMenuOpenChanged)
    local bool1 = if FFlagSduiGameTileDirectAction then GetInputModeStore(false).getLastInputType(false) == Responsive.Input.Pointer else nil

    if not (tbl1.isHovered or tbl1.isSelected or var2) then
        return nil
    end

    if FFlagSduiGameTileDirectAction and tbl1.directActionComponentConfig and tbl1.isHovered and not var2 and bool1 then
        return React.createElement(getSduiComponentWrapper(tbl1.directActionComponentConfig), {
            componentConfig = tbl1.directActionComponentConfig,
            debugName = "SduiTileOverflowMenu.DirectAction",
            sduiContext = tbl1.sduiContext,
            extraLocalProps = {
                anchorPoint = Vector2.new(1, 0),
                position = UDim2.new(1, -var1.Padding.Medium, 0, var1.Padding.Medium),
                zIndex = tbl1.zIndex
            }
        })
    end

    local createElement = React.createElement
    local sduiComponentWrapper = getSduiComponentWrapper(tbl1.componentConfig)
    local tbl2 = {
        componentConfig = tbl1.componentConfig,
        debugName = tbl1.debugName,
        sduiContext = tbl1.sduiContext,
        extraLocalProps = 0
    }
    local extraLocalProps = {
        anchorPoint = Vector2.new(1, 0),
        buttonIconBackgroundStyle = var1.Color.OverMedia.OverMedia_0,
        buttonSize = InputSize.Small,
        hasOverflowButton = 0,
        includeMenuItemTelemetry = true,
        menuKey = 0,
        onMenuOpenChanged = 0,
        position = 0,
        setFocusRef = 0,
        shouldShowAnchor = 0,
        zIndex = 0
    }

    if not FFlagSduiGameTileDirectAction then
        bool1 = GetInputModeStore(false).getLastInputType(false) == Responsive.Input.Pointer
    end

    extraLocalProps.hasOverflowButton = bool1

    extraLocalProps.menuKey = tbl1.menuKey
    extraLocalProps.onMenuOpenChanged = tbl1.onMenuOpenChanged
    extraLocalProps.position = UDim2.new(1, -var1.Padding.Medium, 0, var1.Padding.Medium)
    extraLocalProps.setFocusRef = setFocusRef
    extraLocalProps.shouldShowAnchor = tbl1.isHovered
    extraLocalProps.zIndex = tbl1.zIndex
    tbl2.extraLocalProps = extraLocalProps
    return createElement(sduiComponentWrapper, tbl2)
end)
