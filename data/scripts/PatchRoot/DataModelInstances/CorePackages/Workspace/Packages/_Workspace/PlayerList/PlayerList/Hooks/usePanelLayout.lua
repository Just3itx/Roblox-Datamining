-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:04:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local Foundation = require(scriptParentParentParent.Foundation)
local SignalsReact = require(scriptParentParentParent.SignalsReact)
local useTokens = Foundation.Hooks.useTokens
local useScaledValue = Foundation.Hooks.useScaledValue

local Constants = require(scriptParentParent.Common.Constants)
local computeMobilePanelSize = require(scriptParentParent.Common.computeMobilePanelSize)
local computeDesktopPanelHeight = require(scriptParentParent.Common.computeDesktopPanelHeight)
local PanelContentHeightStore = require(scriptParentParent.Common.PanelContentHeightStore)
local LayoutValuesContext = require(scriptParentParent.Common.LayoutValuesContext)
local getDeviceBottomInset = require(scriptParentParent.Common.getDeviceBottomInset)
local useViewportSize = require(scriptParentParent.Hooks.useViewportSize)

local FFlagPlayerListReskin = require(scriptParentParent.Flags.FFlagPlayerListReskin)
local FFlagPlayerListFixPlatformLeaderboardSizing = require(scriptParentParent.Flags.FFlagPlayerListFixPlatformLeaderboardSizing)

local function usePanelLayout(bool1: boolean, num1: number, bool2: boolean?)
    local var1 = useViewportSize()
    local var2 = useTokens()
    local scale = var2.Config.UI.Scale

    local topBarOffset = React.useContext(LayoutValuesContext).TopBarOffset or 0

    local var3 = SignalsReact.useSignalState(PanelContentHeightStore.getBodyContentHeight)

    local headerHeight = Constants.HEADER_HEIGHT * scale
    local columnHeaderHeight = Constants.COLUMN_HEADER_HEIGHT * scale
    local rowHeight = Constants.PLATFORM_ROW_HEIGHT * scale
    local var7 = Constants.ROW_PITCH * scale
    local statWidth = Constants.STAT_COLUMN_WIDTH * scale
    local var9 = Constants.PEOPLE_MIN_WIDTH * scale
    local size200 = var2.Size.Size_200
    local var10 = useScaledValue(Constants.PANEL_SIZE_MIN_CAP)
    local var11 = useScaledValue(Constants.PANEL_SIZE_MAX_CAP)
    local maxStatColumns = if bool1 then Constants.MOBILE_MAX_STAT_COLUMNS else Constants.DESKTOP_MAX_STAT_COLUMNS
    local var13 = var9 + math.min(num1, maxStatColumns) * statWidth
    local x, y

    if bool1 then
        local num2 = math.max(Constants.MOBILE_EDGE_GAP, Constants.MOBILE_EDGE_GAP * scale)
        local var14 = topBarOffset + num2 + getDeviceBottomInset() + num2
        local var15 = computeMobilePanelSize(var1, var10, var11, var14)
        x = var15.X
        y = var15.Y
    else
        if bool2 then
            x = Constants.PLATFORM_PANEL_WIDTH * scale
        else
            x = 2 * size200 + var13
        end

        local var14 = headerHeight + Constants.PANEL_HEADER_DIVIDER_HEIGHT * scale
        if FFlagPlayerListReskin and bool2 then
            var14 += Constants.PANEL_TABS_HEIGHT * scale
        end
        local var15 = var14 + var3
        local var16 = columnHeaderHeight + Constants.DESKTOP_MIN_VISIBLE_ROWS * var7
        if FFlagPlayerListFixPlatformLeaderboardSizing and bool2 then
            var16 = math.max(var16, Constants.PLATFORM_BODY_MIN_HEIGHT * scale)
        end
        local var17 = var14 + var16
        y = computeDesktopPanelHeight(var1.Y, var15, var17)
    end

    return {
        panelWidth = x,
        panelHeight = y,
        headerHeight = headerHeight,
        columnHeaderHeight = columnHeaderHeight,
        rowHeight = rowHeight,
        statWidth = statWidth,
        maxStatColumns = maxStatColumns
    }
end

return usePanelLayout
