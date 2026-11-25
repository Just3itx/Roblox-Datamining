-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)
local RobloxAppEnums = require(scriptParentParent.RobloxAppEnums)
local RobloxAppHooks = require(scriptParentParent.RobloxAppHooks)
local Foundation = require(scriptParentParent.Foundation)
local PeopleService = require(scriptParentParent.PeopleService)
local SwitchServer = require(scriptParentParent.SwitchServer)

local useDeviceOrientation = RobloxAppHooks.useDeviceOrientation
local useGetPeopleService = require(scriptParent.Hooks.useGetPeopleService)
local useScrollingFrameStore = require(scriptParent.Hooks.useScrollingFrameStore)
local usePeopleWindowWidth = require(scriptParent.Hooks.usePeopleWindowWidth)

local View = Foundation.View

local PeopleList = require(scriptParent.Components.PeopleList)
local PeopleCards = require(scriptParent.Components.PeopleCards)
local CoreButtonRow = require(scriptParent.Components.CoreButtonRow)
local MenuButtonsWrapper = require(scriptParent.Components.MenuButtonsWrapper)
local TitleBar = require(scriptParent.Components.TitleBar)

local Constants = require(scriptParent.Constants)
local isPeoplePageCompact = require(scriptParent.Utils.isPeoplePageCompact)
local PeoplePageLayoutContext = require(scriptParent.PeoplePageLayoutContext)

local GameSettings = UserSettings().GameSettings

local SwitchServerConfirmation = SwitchServer.SwitchServerConfirmation
local SwitchServerTelemetry = SwitchServer.SwitchServerTelemetry

local SharedFlags = require(scriptParentParent.SharedFlags)
local isSideSheetEnabled = require(scriptParentParent.InExperienceSideSheetUtils.isSideSheetEnabled)
local FFlagShowSwitchServerButton = SharedFlags.FFlagShowSwitchServerButton
local FFlagSideSheetOpenPeoplePage = SharedFlags.FFlagSideSheetOpenPeoplePage
local FFlagPeopleListButtonOverflow = require(scriptParent.Flags.FFlagPeopleListButtonOverflow)
local service = PeopleService.getService("Flags")
local GetFFlagAddPeoplePageCardLayout = service.GetFFlagAddPeoplePageCardLayout
local GetFFlagPeoplePageLazyRenderCards = service.GetFFlagPeoplePageLazyRenderCards
local GetFFlagPeoplePagePostponeInitialRender = service.GetFFlagPeoplePagePostponeInitialRender
local FFlagEnablePeopleListLazyRender = service.FFlagEnablePeopleListLazyRender
local FFlagPeoplePageRemoveUseMemoElements = service.FFlagPeoplePageRemoveUseMemoElements
local FFlagPeopleCardsEnableVirtualizedGrid = service.FFlagPeopleCardsEnableVirtualizedGrid

local FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView = service.FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView
local FFlagPeoplePageFlipVolumePopoverToFitViewport = service.FFlagPeoplePageFlipVolumePopoverToFitViewport
local FFlagPeoplePageDismissCardMenuOnScrollOutOfView = service.FFlagPeoplePageDismissCardMenuOnScrollOutOfView
local FFlagFixVirtualizedGridNumItems = service.FFlagFixVirtualizedGridNumItems

local function _createPageView(tbl1)
    local var1 = if GetFFlagAddPeoplePageCardLayout() then useGetPeopleService("PeopleAnalyticsManager") else nil

    local var2 = if GetFFlagAddPeoplePageCardLayout() then useGetPeopleService("PeopleBlockingModalManager") else React.useMemo(function()
        return PeopleService.getService("PeopleBlockingModalManager")
    end, {})

    local var3 = React.useMemo(function()
        return var2.getModalManager(tbl1.blockingModalScreen, tbl1.blockingFlags)
    end, { var2, tbl1.blockingModalScreen, tbl1.blockingFlags })

    local bool1 = useDeviceOrientation() == RobloxAppEnums.DeviceOrientationMode.Portrait

    local var4 = nil
    local bool2 = false
    if FFlagPeopleListButtonOverflow then
        local var5
        var5, var4 = usePeopleWindowWidth()

        bool2 = isPeoplePageCompact(var5)
    end

    local value = if FFlagPeopleListButtonOverflow then React.useMemo(function()
        return { isCompact = bool2 }
    end, { bool2 }) else nil

    local var6 = nil
    local var7 = nil
    if GetFFlagAddPeoplePageCardLayout() then
        var6, var7 = React.useState(GameSettings.PeoplePageLayout)
    end

    local var8 = nil
    local var9 = nil
    if GetFFlagPeoplePagePostponeInitialRender() then
        local var10
        var8, var10 = React.useState(false)
        var9 = var10
    end

    local var10 = if GetFFlagPeoplePageLazyRenderCards()
        or FFlagEnablePeopleListLazyRender
        or FFlagPeopleCardsEnableVirtualizedGrid
        or FFlagPeoplePageDismissVolumePopoverOnScrollOutOfView
        or FFlagPeoplePageFlipVolumePopoverToFitViewport
        or FFlagPeoplePageDismissCardMenuOnScrollOutOfView then useScrollingFrameStore(tbl1.scrollingFrame) else nil

    local onAbsoluteSizeChanged = if FFlagFixVirtualizedGridNumItems then React.useCallback(function(arg1)
        if var10 then
            var10.setCanvasPositionYOffset(-arg1.AbsoluteSize.Y)
        end
    end, { var10 }) else nil

    local setLayout = if GetFFlagAddPeoplePageCardLayout() then React.useCallback(function(arg1)
        var1:trackPeoplePageLayoutChanged(arg1)
        var7(arg1)
    end, {}) else nil

    local element

    if FFlagPeoplePageRemoveUseMemoElements then
        local card = Enum.PeoplePageLayout.Card

        if var6 == card then
            element = React.createElement(PeopleCards, {
                getUniversesExposedTo = tbl1.getUniversesExposedTo,
                addUniverseToExposureList = tbl1.addUniverseToExposureList,
                minimumCardWidth = if FFlagSideSheetOpenPeoplePage then tbl1.minimumCardWidth else nil,
                scrollingFrameStore = if tbl1.scrollingFrame then var10 else nil,
                LayoutOrder = 3
            })
        else
            element = React.createElement(PeopleList, {
                scrollingFrameStore = if FFlagEnablePeopleListLazyRender then if tbl1.scrollingFrame then var10 else nil else nil,
                LayoutOrder = 3
            })
        end
    elseif GetFFlagAddPeoplePageCardLayout() then
        element = React.useMemo(function()
            if var6 ~= Enum.PeoplePageLayout.Card then
                return (React.createElement(PeopleList, {
                    scrollingFrameStore = if FFlagEnablePeopleListLazyRender and tbl1.scrollingFrame then var10 else nil,
                    LayoutOrder = 3
                }))
            end

            return (React.createElement(PeopleCards, {
                getUniversesExposedTo = tbl1.getUniversesExposedTo,
                addUniverseToExposureList = tbl1.addUniverseToExposureList,
                minimumCardWidth = if FFlagSideSheetOpenPeoplePage then tbl1.minimumCardWidth else nil,
                scrollingFrameStore = if tbl1.scrollingFrame then var10 else nil,
                LayoutOrder = 3
            }))
        end, {
            var6,
            var10,
            tbl1.scrollingFrame,
            tbl1.getUniversesExposedTo,
            tbl1.addUniverseToExposureList,
            tbl1.minimumCardWidth or 0
        })
    else
        element = nil
    end

    if GetFFlagPeoplePagePostponeInitialRender() then
        React.useEffect(function()
            var9(true)
        end, {})
    end

    local var13 = nil
    local var14 = nil
    if FFlagShowSwitchServerButton then
        local var15
        var13, var15 = React.useState(false)
        var14 = var15
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local tbl2 = {}
    local tbl3 = {
        MenuButtonsWrapper = if isSideSheetEnabled then nil else React.createElement(MenuButtonsWrapper),
        CoreButtonRow = 0,
        TitleBar = 0
    }
    local createElement2 = React.createElement
    local var15 = CoreButtonRow
    local tbl4 = {
        chromeEnabled = tbl1.chromeEnabled,
        LayoutOrder = if GetFFlagAddPeoplePageCardLayout() then 1 else nil,
        buttonActivatedTable = 0
    }
    local tbl5

    if FFlagShowSwitchServerButton then
        tbl5 = {}
        tbl5[Constants.PEOPLEPAGE.BUTTON_ACTIVATED_TABLE_KEYS.SWITCH_SERVER] = function()
            SwitchServerTelemetry.sendSwitchServerButtonActions({ event_type = "click" })

            var14(true)
        end
    else
        tbl5 = nil
    end

    tbl4.buttonActivatedTable = tbl5
    tbl3.CoreButtonRow = createElement2(var15, tbl4)

    tbl3.TitleBar = if GetFFlagAddPeoplePageCardLayout() then React.createElement(TitleBar, { layout = var6, setLayout = setLayout, LayoutOrder = 2 }) else nil
    local element2 = createElement(fragment, tbl2, tbl3)

    if FFlagFixVirtualizedGridNumItems then
        element2 = React.createElement(View, {
            tag = "size-full-0 auto-y col gap-large padding-bottom-large",
            onAbsoluteSizeChanged = onAbsoluteSizeChanged,
            LayoutOrder = 1
        }, element2)
    end

    local createElement3 = React.createElement
    local var16 = View
    local tbl6 = {
        tag = {
            ["size-full col padding-bottom-small"] = FFlagFixVirtualizedGridNumItems,
            ["size-full col gap-large padding-bottom-small"] = not FFlagFixVirtualizedGridNumItems,
            ["padding-x-medium"] = not bool1
        },
        ref = 0,
        testId = "mainView"
    }
    if not FFlagPeopleListButtonOverflow then
        var4 = nil
    end

    tbl6.ref = var4

    local tbl7 = {
        PeopleHeader = element2,
        People = 0,
        BlockingModalManager = 0,
        SwitchServerConfirmation = 0
    }

    if GetFFlagPeoplePagePostponeInitialRender() and not var8 then
        element = nil
    elseif not GetFFlagAddPeoplePageCardLayout() then
        element = React.createElement(
            PeopleList,
            {
                scrollingFrameStore = if FFlagEnablePeopleListLazyRender then if tbl1.scrollingFrame then var10 else nil else nil
            }
        )
    end

    tbl7.People = element

    tbl7.BlockingModalManager = React.createElement(var3)
    tbl7.SwitchServerConfirmation = if FFlagShowSwitchServerButton and var13 then React.createElement(SwitchServerConfirmation, { setSwitchServerConfirmationOpen = var14 }) else nil
    local page = createElement3(var16, tbl6, tbl7)

    if not FFlagPeopleListButtonOverflow then
        return page
    end

    return React.createElement(PeoplePageLayoutContext.Provider, { value = value }, { Page = page })
end

return _createPageView
