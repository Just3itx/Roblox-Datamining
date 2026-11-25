-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local AppBlox = require(SduiSharedContentParent.AppBlox)
local Cryo = require(SduiSharedContentParent.Cryo)
local React = require(SduiSharedContentParent.React)
local SduiCoreSystem = require(SduiSharedContentParent.SduiCoreSystem)
local Signals = require(SduiSharedContentParent.Signals)
local SignalsReact = require(SduiSharedContentParent.SignalsReact)

local SduiTileOverflowMenu = require(SduiSharedContent.Components.SduiTileOverflowMenu)

local getOverflowMenuSignalStore = AppBlox.getOverflowMenuSignalStore
local useSignalState = SignalsReact.useSignalState
local useUidRefString = SduiCoreSystem.useUidRefString

local function InteractableTileWrapperMenu(tbl1)
    local isHovered = useSignalState(tbl1.getIsHovered)
    local isSelected = useSignalState(tbl1.getIsSelected)

    return React.createElement(SduiTileOverflowMenu, {
        componentConfig = tbl1.componentConfig,
        debugName = "SduiInteractableTileWrapper.OverflowMenu",
        isHovered = isHovered,
        isSelected = isSelected,
        menuKey = tbl1.menuKey,
        parentRef = tbl1.parentRef,
        sduiContext = tbl1.sduiContext,
        zIndex = 5
    })
end

local function useTileMenu(sduiContext)
    local menuKey = `sdui-interactable-tile-wrapper-{useUidRefString().current}`
    local tileRef = React.useRef(nil)

    local var2 = React.useMemo(function()
        local getIsHovered, setIsHovered = Signals.createSignal(false)
        local getIsSelected, setIsSelected = Signals.createSignal(false)
        return {
            getIsHovered = getIsHovered,
            setIsHovered = setIsHovered,
            getIsSelected = getIsSelected,
            setIsSelected = setIsSelected
        }
    end, {})

    local triggerFeedback = sduiContext.dependencies.triggerFeedback
    local appPage = sduiContext.appPage

    return React.useMemo(function()
        return {
            menuKey = menuKey,
            tileRef = tileRef,
            getIsHovered = var2.getIsHovered,
            getIsSelected = var2.getIsSelected,
            tileHandlers = {
                setGuiObject = function(current)
                    tileRef.current = current
                end,
                onMouseEnter = function()
                    var2.setIsHovered(true)
                end,
                onMouseLeave = function()
                    var2.setIsHovered(false)
                end,
                onSelectionGained = function()
                    var2.setIsSelected(true)
                end,
                onSelectionLost = function()
                    var2.setIsSelected(false)
                end,
                onTouchLongPress = function()
                    local overflowMenuSignalStore = getOverflowMenuSignalStore()
                    if triggerFeedback and not overflowMenuSignalStore.getIsMenuOpen(menuKey) then
                        triggerFeedback("TileLongPress", "Press", appPage or "Unknown")
                    end
                    overflowMenuSignalStore.openMenu(menuKey)
                end
            }
        }
    end, {
        menuKey,
        var2,
        triggerFeedback,
        appPage
    })
end

return React.memo(function(tbl1) -- name: SduiInteractableTileWrapper
    local var1 = useTileMenu(tbl1.sduiContext)

    local overflowMenuComponent = tbl1.overflowMenuComponent
    local sduiContext = tbl1.sduiContext
    local thumbnailOverflowMenuComponent = React.useMemo(function()
        if not overflowMenuComponent then
            return nil
        end

        return (React.createElement(InteractableTileWrapperMenu, {
            sduiContext = sduiContext,
            componentConfig = overflowMenuComponent,
            menuKey = var1.menuKey,
            parentRef = var1.tileRef,
            getIsHovered = var1.getIsHovered,
            getIsSelected = var1.getIsSelected
        }))
    end, { overflowMenuComponent, sduiContext, var1 })

    local tileComponent = tbl1.tileComponent
    if not tileComponent then
        return nil
    end

    local tbl2 = {
        size = tbl1.size,
        layoutOrder = tbl1.layoutOrder,
        selectionOrder = tbl1.selectionOrder
    }
    if thumbnailOverflowMenuComponent then
        tbl2 = Cryo.Dictionary.join(tbl2, var1.tileHandlers, { thumbnailOverflowMenuComponent = thumbnailOverflowMenuComponent })
    end

    return React.cloneElement(tileComponent, { parentAnalyticsContext = tbl1.analyticsContext, extraLocalProps = tbl2 })
end)
