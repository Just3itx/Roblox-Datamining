-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local AppBlox = require(SduiSharedContentParent.AppBlox)
local OverflowMenu = AppBlox.OverflowMenu
local getOverflowMenuSignalStore = AppBlox.getOverflowMenuSignalStore
local useBackButtonBinding = require(SduiSharedContentParent.SduiSharedUtilities).useBackButtonBinding
local useUidRefString = require(SduiSharedContentParent.SduiCoreSystem).useUidRefString
local _SduiCompat = require(SduiSharedContentParent.SduiCompat)
local Foundation = require(SduiSharedContentParent.Foundation)

local FFlagLuaAppSduiGameTileFeedback = require(SduiSharedContentParent.SharedFlags).FFlagLuaAppSduiGameTileFeedback
local FFlagSduiOverflowMenuHideWhenEmpty = require(SduiSharedContentParent.SharedFlags).FFlagSduiOverflowMenuHideWhenEmpty

local function addMenuItemTelemetry(items)
    local tbl1 = {}
    for _, item in items do
        if typeof(item.id) == "string" and item.id ~= "" then
            table.insert(tbl1, item.id)
        end
    end
    local availableMenuItemIds = table.concat(tbl1, ",")

    local result = {}
    for _, item in items do
        if not item.onActivated or typeof(item.id) ~= "string" or item.id == "" then
            table.insert(result, item)
        else
            local var1 = table.clone(item)
            function var1.onActivated(_, _, _)
                item.onActivated(nil, nil, { menuItemId = item.id, availableMenuItemIds = availableMenuItemIds })
            end

            table.insert(result, var1)
        end
    end
    return result
end

return React.memo(function(tbl1) -- name: SduiOverflowMenu
    local var1 = useUidRefString()
    local menuKey = if FFlagLuaAppSduiGameTileFeedback and tbl1.menuKey then tbl1.menuKey else `sdui-overflow-menu-{var1.current}`
    local var3 = tbl1.anchorPoint or Vector2.new(0, 0)
    local var4 = tbl1.position or UDim2.new(0, 0, 0, 0)
    local var5, shouldShowAnchor

    if FFlagLuaAppSduiGameTileFeedback then
        var5 = tbl1.hasOverflowButton == nil or tbl1.hasOverflowButton
        if tbl1.shouldShowAnchor == nil then
            shouldShowAnchor = true
        else
            shouldShowAnchor = tbl1.shouldShowAnchor
        end
    else
        var5 = nil
        shouldShowAnchor = nil
    end

    local var6 = if FFlagLuaAppSduiGameTileFeedback then React.useMemo(function()
        if not tbl1.includeMenuItemTelemetry then
            return tbl1.items
        end

        return (addMenuItemTelemetry(tbl1.items))
    end, { tbl1.items, tbl1.includeMenuItemTelemetry }) else nil

    local var7 = React.useCallback(function()
        getOverflowMenuSignalStore().closeMenu(menuKey)
    end, { menuKey })
    local var8 = useBackButtonBinding(var7)

    if not FFlagLuaAppSduiGameTileFeedback then
        var6 = tbl1.items
    end

    local num1 = 0
    for _ in var6 do
        num1 += 1
    end

    local tbl2

    if num1 == #var6 then
        tbl2 = var6
    else
        tbl2 = {}
        for _, value in var6 do
            table.insert(tbl2, value)
        end
    end

    if FFlagSduiOverflowMenuHideWhenEmpty and #tbl2 == 0 then
        return nil
    end

    local bool1 = tbl1.layoutOrder ~= nil
    local tbl3 = {
        anchorPoint = 0,
        anchorPosition = 0,
        menuItems = 0,
        menuKey = 0,
        buttonVariant = 0,
        buttonIconSize = 0,
        buttonIcon = 0,
        buttonIconBackgroundStyle = 0,
        menuItemSize = 0,
        popoverAlign = 0,
        popoverSide = 0,
        menuWidth = 0,
        hasOverflowButton = 0,
        shouldShowAnchor = 0,
        buttonIsCircular = 0,
        buttonTag = 0,
        setFocusRef = 0,
        onMenuOpenChanged = 0,
        zIndex = 0
    }

    if bool1 then
        var3 = nil
    end

    tbl3.anchorPoint = var3
    if bool1 then
        var4 = nil
    end

    tbl3.anchorPosition = var4

    tbl3.menuItems = tbl2
    tbl3.menuKey = menuKey
    tbl3.buttonVariant = tbl1.buttonVariant
    tbl3.buttonIconSize = tbl1.buttonSize
    tbl3.buttonIcon = tbl1.buttonIcon
    tbl3.buttonIconBackgroundStyle = tbl1.buttonIconBackgroundStyle
    tbl3.menuItemSize = tbl1.menuItemSize
    tbl3.popoverAlign = tbl1.popoverAlign
    tbl3.popoverSide = tbl1.popoverSide
    tbl3.menuWidth = tbl1.menuWidth
    tbl3.hasOverflowButton = not FFlagLuaAppSduiGameTileFeedback or var5
    tbl3.shouldShowAnchor = not FFlagLuaAppSduiGameTileFeedback or shouldShowAnchor
    tbl3.buttonIsCircular = tbl1.buttonIsCircular
    tbl3.buttonTag = tbl1.buttonTag
    if FFlagLuaAppSduiGameTileFeedback and tbl1.setFocusRef then
        var8 = tbl1.setFocusRef
    end

    tbl3.setFocusRef = var8
    tbl3.onMenuOpenChanged = if FFlagLuaAppSduiGameTileFeedback then tbl1.onMenuOpenChanged else nil
    tbl3.zIndex = if FFlagLuaAppSduiGameTileFeedback then tbl1.zIndex else nil

    if not bool1 then
        return React.createElement(OverflowMenu, tbl3)
    end

    return React.createElement(
        Foundation.View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "auto-xy"
        },
        {
            OverflowMenu = React.createElement(OverflowMenu, tbl3)
        }
    )
end)
