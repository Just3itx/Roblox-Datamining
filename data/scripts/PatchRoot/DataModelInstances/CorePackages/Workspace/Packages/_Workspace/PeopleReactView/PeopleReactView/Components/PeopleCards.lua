-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Players = game:GetService("Players")

local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local Foundation = require(PeopleReactViewParent.Foundation)
local useScaledValue = Foundation.Hooks.useScaledValue
local useTokens = Foundation.Hooks.useTokens
local View = Foundation.View

local Responsive = require(PeopleReactViewParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local Input = Responsive.Input

local useLastInputMode = require(PeopleReactViewParent.FocusNavigationUtils).useLastInputMode

local PeopleService = require(PeopleReactViewParent.PeopleService)

local _GetScrollingFrameStore = require(PeopleReactView.Stores.GetScrollingFrameStore)

local useCardWidth = require(PeopleReactView.Hooks.useCardWidth)
local useCardLayoutValues = require(PeopleReactView.Hooks.useCardLayoutValues)
local useGetPeopleService = require(PeopleReactView.Hooks.useGetPeopleService)

local PersonCard = require(PeopleReactView.Components.Card.PersonCard)
local LazyPersonCard = require(PeopleReactView.Components.Card.LazyPersonCard)
local VirtualizedGrid = require(PeopleReactView.Components.Common.VirtualizedGrid)

local Constants = require(PeopleReactView.Constants)

local LocalPlayer = Players.LocalPlayer

local FFlagSideSheetOpenPeoplePage = require(PeopleReactViewParent.SharedFlags).FFlagSideSheetOpenPeoplePage

local service = PeopleService.getService("Flags")
local GetFFlagPeoplePageEnablePersonSignalStore = service.GetFFlagPeoplePageEnablePersonSignalStore
local GetFFlagPeoplePageLazyRenderCards = service.GetFFlagPeoplePageLazyRenderCards
local FFlagPeoplePageRemoveUseMemoElements = service.FFlagPeoplePageRemoveUseMemoElements
local FFlagPeopleCardsEnableVirtualizedGrid = service.FFlagPeopleCardsEnableVirtualizedGrid
local num1 = game:DefineFastInt("MaxNumUniversesExposedToCardTooltip", 3)

local bool1 = false

return React.memo(function(tbl1) -- name: PeopleCards
    local var1 = useTokens()
    local medium = var1.Gap.Medium

    local var2 = useScaledValue(Constants.PEOPLEPAGE.PEOPLE_CARDS.MINIMUM_CARD_WIDTH)
    local var3 = if FFlagSideSheetOpenPeoplePage and tbl1.minimumCardWidth then tbl1.minimumCardWidth * var1.Config.UI.Scale else var2
    local var4 = nil
    local var5 = nil
    local var6 = nil
    if FFlagSideSheetOpenPeoplePage then
        var4, var5 = React.useState(false)

        var6 = React.useCallback(function(num2: number)
            var5(num2 < var2)
        end, { var2 })
    end

    local var7 = nil
    local var8 = nil
    local var9 = nil
    local var10 = nil
    local var11

    if FFlagPeopleCardsEnableVirtualizedGrid then
        local var12, var13
        var12, var8, var9, var13 = useCardLayoutValues()
        var11 = var12
        var10 = var13
    else
        var11, var7 = useCardWidth()
    end

    local var12 = nil
    local var13 = nil
    if FFlagPeopleCardsEnableVirtualizedGrid then
        var12, var13 = React.useState(false)
    end

    local var14 = useGetPeopleService("PeopleListStore")
    local var15 = if GetFFlagPeoplePageEnablePersonSignalStore() then nil else SignalsReact.useSignalState(var14.people)
    local var16 = if GetFFlagPeoplePageEnablePersonSignalStore() then SignalsReact.useSignalState(var14.peopleSignalMap.getCount) else nil
    local var17 = if GetFFlagPeoplePageLazyRenderCards() then useLastInputMode() else nil
    local var18 = if GetFFlagPeoplePageLazyRenderCards() then usePreferredInput() else nil

    local shouldShowMenu = if GetFFlagPeoplePageLazyRenderCards() then React.useMemo(function(): boolean
        return var17 == "Focus" or var18 ~= Input.Pointer
    end, { var17, var18 }) else nil

    local showTooltip = React.useMemo(function()
        if FFlagPeopleCardsEnableVirtualizedGrid and var12
            or bool1
            or not (tbl1.getUniversesExposedTo and tbl1.addUniverseToExposureList)
        then
            return false
        end

        local num2 = 0

        for _, value in (tbl1.getUniversesExposedTo(Constants.PEOPLEPAGE.CARD_TOOLTIP.UNIVERSES_EXPOSED_TO_CARD_TOOLTIP)) do
            if value == game.GameId then
                return false
            end
            num2 += 1
        end

        if num1 <= num2 then
            return false
        end

        tbl1.addUniverseToExposureList(Constants.PEOPLEPAGE.CARD_TOOLTIP.UNIVERSES_EXPOSED_TO_CARD_TOOLTIP, game.GameId)

        return true
    end, FFlagPeopleCardsEnableVirtualizedGrid and { var12, tbl1.getUniversesExposedTo, tbl1.addUniverseToExposureList }
        or { tbl1.getUniversesExposedTo, tbl1.addUniverseToExposureList })

    local onDismissTooltip = React.useCallback(function()
        bool1 = true
        if FFlagPeopleCardsEnableVirtualizedGrid then
            var13(true)
        end
    end, {})

    React.useEffect(function()
        return function()
            onDismissTooltip()
        end
    end, {})

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        local var22 = var7(var3, arg1.AbsoluteSize.X, medium)
        if FFlagSideSheetOpenPeoplePage then
            var6(var22)
        end
    end, FFlagSideSheetOpenPeoplePage and {
        var7,
        var6,
        var3,
        medium
    } or { var7, var3, medium })

    local tbl2 = ({})
    if not FFlagPeopleCardsEnableVirtualizedGrid then
        if FFlagPeoplePageRemoveUseMemoElements then
            if GetFFlagPeoplePageEnablePersonSignalStore() then
                tbl2 = {}

                var14.peopleSignalMap.iterateData(function(userId: number, arg1)
                    local var23 = tbl2
                    local str1 = "PersonCard_" .. userId
                    local createElement = React.createElement
                    local var24 = if GetFFlagPeoplePageLazyRenderCards() then LazyPersonCard else PersonCard
                    local tbl3 = {
                        width = var11,
                        person = arg1.getPerson(),
                        showTooltip = 0,
                        onDismissTooltip = 0,
                        layoutOrder = 0,
                        scrollingFrameStore = 0,
                        shouldShowMenu = 0,
                        isCompactCardLayout = 0
                    }
                    local bool2 = showTooltip

                    if bool2 then
                        if LocalPlayer == nil then
                            bool2 = false
                        else
                            bool2 = userId == LocalPlayer.UserId
                        end
                    end

                    tbl3.showTooltip = bool2
                    tbl3.onDismissTooltip = onDismissTooltip
                    tbl3.layoutOrder = arg1.getOrder
                    tbl3.scrollingFrameStore = if GetFFlagPeoplePageLazyRenderCards() then tbl1.scrollingFrameStore else nil

                    tbl3.shouldShowMenu = if GetFFlagPeoplePageLazyRenderCards() then shouldShowMenu else nil
                    tbl3.isCompactCardLayout = var4
                    var23[str1] = createElement(var24, tbl3)
                end, false)
            else
                tbl2 = {}

                for layoutOrder, person in var15 do
                    local var23 = "PersonCard_" .. person.UserId
                    local element = React.createElement(if GetFFlagPeoplePageLazyRenderCards() then LazyPersonCard else PersonCard, {
                        width = var11,
                        person = person,
                        showTooltip = showTooltip and layoutOrder == 1,
                        onDismissTooltip = onDismissTooltip,
                        layoutOrder = layoutOrder,
                        scrollingFrameStore = if GetFFlagPeoplePageLazyRenderCards() then tbl1.scrollingFrameStore else nil,
                        shouldShowMenu = if GetFFlagPeoplePageLazyRenderCards() then shouldShowMenu else nil,
                        isCompactCardLayout = var4
                    })
                    tbl2[var23] = element
                end
            end
        elseif GetFFlagPeoplePageEnablePersonSignalStore() then
            tbl2 = React.useMemo(function()
                local result = {}

                var14.peopleSignalMap.iterateData(function(userId: number, arg1)
                    local tbl3 = result
                    local str1 = "PersonCard_" .. userId
                    local createElement = React.createElement
                    local var23 = if GetFFlagPeoplePageLazyRenderCards() then LazyPersonCard else PersonCard
                    local tbl4 = {
                        width = var11,
                        person = arg1.getPerson(),
                        showTooltip = 0,
                        onDismissTooltip = 0,
                        layoutOrder = 0,
                        scrollingFrameStore = 0,
                        shouldShowMenu = 0,
                        isCompactCardLayout = 0
                    }
                    local bool2 = showTooltip

                    if bool2 then
                        if LocalPlayer == nil then
                            bool2 = false
                        else
                            bool2 = userId == LocalPlayer.UserId
                        end
                    end

                    tbl4.showTooltip = bool2

                    tbl4.onDismissTooltip = onDismissTooltip
                    tbl4.layoutOrder = arg1.getOrder
                    tbl4.scrollingFrameStore = if GetFFlagPeoplePageLazyRenderCards() then tbl1.scrollingFrameStore else nil

                    tbl4.shouldShowMenu = if GetFFlagPeoplePageLazyRenderCards() then shouldShowMenu else nil

                    tbl4.isCompactCardLayout = var4
                    tbl3[str1] = createElement(var23, tbl4)
                end, false)

                return result
            end, {
                var16,
                showTooltip,
                tbl1.scrollingFrameStore,
                shouldShowMenu,
                var4
            })
        else
            tbl2 = React.useMemo(function()
                local result = ({})

                for layoutOrder, person in var15 do
                    local var23 = "PersonCard_" .. person.UserId
                    result[var23] = React.createElement(if GetFFlagPeoplePageLazyRenderCards() then LazyPersonCard else PersonCard, {
                        width = var11,
                        person = person,
                        showTooltip = showTooltip and layoutOrder == 1,
                        onDismissTooltip = onDismissTooltip,
                        layoutOrder = layoutOrder,
                        scrollingFrameStore = if GetFFlagPeoplePageLazyRenderCards() then tbl1.scrollingFrameStore else nil,
                        shouldShowMenu = if GetFFlagPeoplePageLazyRenderCards() then shouldShowMenu else nil,
                        isCompactCardLayout = var4
                    })
                end

                return result
            end, {
                var15,
                showTooltip,
                tbl1.scrollingFrameStore,
                shouldShowMenu,
                var4
            })
        end
    end

    if not FFlagPeopleCardsEnableVirtualizedGrid then
        return (React.createElement(View, {
            tag = "size-full-0 auto-y",
            layout = {
                FillDirection = Enum.FillDirection.Horizontal,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, medium),
                Wraps = true
            },
            LayoutOrder = tbl1.LayoutOrder,
            onAbsoluteSizeChanged = onAbsoluteSizeChanged
        }, tbl2))
    end

    local onContainerWidthChanged = React.useCallback(function(num2: number)
        local var23 = var10(var3, num2, medium)
        if FFlagSideSheetOpenPeoplePage then
            var6(var23)
        end
    end, FFlagSideSheetOpenPeoplePage and {
        var10,
        var6,
        var3,
        medium
    } or { var3, medium })

    local getElement = React.useCallback(function(num2: number)
        local person = if num2 > 0 and num2 <= #var15 then var15[num2] else nil

        if not person then
            return nil
        end

        return React.createElement(PersonCard, {
            width = var11,
            person = person,
            showTooltip = showTooltip,
            onDismissTooltip = onDismissTooltip,
            shouldShowMenu = shouldShowMenu,
            isCompactCardLayout = var4
        })
    end, {
        var15,
        showTooltip,
        shouldShowMenu,
        onDismissTooltip,
        var4
    })
    return (React.createElement(VirtualizedGrid, {
        scrollingFrameStore = tbl1.scrollingFrameStore,
        itemWidth = var11,
        itemHeight = var8,
        numColumns = var9,
        gapSize = medium,
        numItems = #var15,
        layoutOrder = tbl1.LayoutOrder,
        onContainerWidthChanged = onContainerWidthChanged,
        getElement = getElement
    }))
end)
