-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local Responsive = require(PeopleReactViewParent.Responsive)
local usePreferredInput = Responsive.usePreferredInput
local Input = Responsive.Input

local useLastInputMode = require(PeopleReactViewParent.FocusNavigationUtils).useLastInputMode

local Foundation = require(PeopleReactViewParent.Foundation)
local getRbxThumb = Foundation.Utility.getRbxThumb
local ControlState = Foundation.Enums.ControlState
local InputSize = Foundation.Enums.InputSize
local StateLayerAffordance = Foundation.Enums.StateLayerAffordance
local ThumbnailType = Foundation.Enums.ThumbnailType
local ThumbnailSize = Foundation.Enums.ThumbnailSize
local Image = Foundation.Image
local View = Foundation.View

local PeopleService = require(PeopleReactViewParent.PeopleService)

local PersonButtonConfigs = require(PeopleReactView.Configs.PersonButtonConfigs)
local useGetPeopleService = require(PeopleReactView.Hooks.useGetPeopleService)
local useIsComponentInputEnded = require(PeopleReactView.Hooks.useIsComponentInputEnded)

local CardMenu = require(PeopleReactView.Components.Card.CardMenu)
local ConnectButton = require(PeopleReactView.Components.Card.ConnectButton)

local FFlagSideSheetOpenPeoplePage = require(PeopleReactViewParent.SharedFlags).FFlagSideSheetOpenPeoplePage
local FFlagPeoplePageAvatarBackground = require(PeopleReactView.Flags.FFlagPeoplePageAvatarBackground)
local useAvatarBackgroundImage = if FFlagPeoplePageAvatarBackground then require(PeopleReactView.Hooks.useAvatarBackgroundImage) else nil
local GetFFlagPeoplePageLazyRenderCards = PeopleService.getService("Flags").GetFFlagPeoplePageLazyRenderCards
local bool1 = game:DefineFastFlag("PeoplePageCardMenuUseVisibleProperty", false)
local bool2 = game:DefineFastFlag("PeoplePageFixCardMenuZIndex", false)

return React.memo(function(tbl1) -- name: CardThumbnail
    local ref = React.useRef(nil)
    local var2 = if GetFFlagPeoplePageLazyRenderCards() then nil else usePreferredInput()
    local var3 = if GetFFlagPeoplePageLazyRenderCards() then nil else useLastInputMode()
    local var4 = useGetPeopleService("Constants")
    local var5 = useGetPeopleService("PeopleVoiceChatStore")

    local var6 = PersonButtonConfigs(tbl1.person.UserId)
    local image = if FFlagPeoplePageAvatarBackground then useAvatarBackgroundImage(tbl1.person.UserId) else nil

    local var8 = React.useMemo(function()
        return var6[var4.PERSON_BUTTONS.INSPECT]
    end, { var6 })

    local var9 = SignalsReact.useSignalState(var5.getPlayerIsTalking(tbl1.person.UserId))

    local var10, var11 = React.useState(false)
    local var12, var13 = React.useState(false)
    local var14 = nil
    local var15 = nil
    if FFlagSideSheetOpenPeoplePage then
        var14, var15 = React.useState(false)
    end
    local var16, onIsOpenChanged = React.useState(false)
    local var18 = useIsComponentInputEnded(ref)

    local onStateChanged = React.useCallback(function(hover)
        var11(hover == ControlState.Hover)
    end, {})

    local var1 = React.useCallback(function(hover)
        var13(hover == ControlState.Hover)
    end, {})

    local var7 = if FFlagSideSheetOpenPeoplePage then React.useCallback(function(arg1)
        var15(arg1 == ControlState.Hover or arg1 == ControlState.Pressed)
    end, {}) else nil

    local var22 = React.useMemo(function()
        local bool3 = if GetFFlagPeoplePageLazyRenderCards() then tbl1.shouldShowMenu else var3 == "Focus" or var2 ~= Input.Pointer
        return var10 or var16 or var9 or bool3
    end, {
        var10,
        var16,
        var9,
        var2,
        var3,
        tbl1.shouldShowMenu
    })

    local var23 = React.useMemo(function()
        if FFlagSideSheetOpenPeoplePage then
            return var12 or var14 or var16 or var18
        end

        return var12 or var16 or var18
    end, FFlagSideSheetOpenPeoplePage and {
        var12,
        var14,
        var16,
        var18
    } or { var12, var16, var18 })

    local var24 = React.useCallback(function()
        var8.onActivated(var4.ANALYTICS.ENTRY_POINT.PEOPLE_CARD)
    end, { var8.onActivated })

    local createElement = React.createElement
    local var25 = View
    local tbl2 = {
        tag = "size-full aspect-1-1 radius-medium",
        selection = {
            Selectable = var8.shouldShow()
        },
        LayoutOrder = tbl1.layoutOrder,
        stateLayer = {
            affordance = if var23 then StateLayerAffordance.None else StateLayerAffordance.Background
        },
        onActivated = 0,
        onStateChanged = 0,
        ref = 0
    }

    if not var8.shouldShow() then
        var24 = nil
    end

    tbl2.onActivated = var24
    tbl2.onStateChanged = onStateChanged
    tbl2.ref = ref
    local tbl3 = {
        AvatarBackground = if image then React.createElement(Image, {
            tag = "size-full radius-top-medium",
            Image = image,
            ScaleType = Enum.ScaleType.Crop,
            ZIndex = 0,
            testId = "person-card-avatar-background"
        }) else nil,
        AvatarThumbnailContainer = React.createElement(View, { tag = "size-full padding-medium" }, {
            AvatarThumbnail = React.createElement(
                Image,
                {
                    tag = "size-full",
                    Image = getRbxThumb(ThumbnailType.Avatar, tbl1.person.UserId, ThumbnailSize.Medium)
                }
            )
        }),
        ThumbnailHeaderBar = 0,
        ConnectButtonAnchor = 0
    }

    local createElement2 = React.createElement
    local var26 = View
    local tbl4 = {
        tag = "row size-full-0 auto-y align-x-right padding-small",
        ZIndex = if bool2 then 2 else nil
    }
    local tbl5 = { CardMenuBackground = 0 }
    local var27

    if bool1 or var22 then
        local createElement3 = React.createElement
        local var28 = View
        local tbl6 = {
            AutomaticSize = Enum.AutomaticSize.XY,
            selection = { Selectable = false },
            stateLayer = {
                affordance = StateLayerAffordance.None
            },
            onStateChanged = var1,
            Visible = 0
        }

        if not bool1 then
            var22 = nil
        end

        tbl6.Visible = var22
        var27 = createElement3(
            var28,
            tbl6,
            {
                CardMenu = React.createElement(CardMenu, { person = tbl1.person, onIsOpenChanged = onIsOpenChanged })
            }
        )
    else
        var27 = nil
    end

    tbl5.CardMenuBackground = var27
    tbl3.ThumbnailHeaderBar = createElement2(var26, tbl4, tbl5)

    tbl3.ConnectButtonAnchor = if FFlagSideSheetOpenPeoplePage and tbl1.isCompactCardLayout then React.createElement(
        View,
        { tag = "position-bottom-left anchor-bottom-left auto-xy padding-small", ZIndex = 2 },
        {
            ConnectButtonBackground = React.createElement(ConnectButton, { person = tbl1.person, size = InputSize.Small, onStateChanged = var7 })
        }
    ) else nil
    return createElement(var25, tbl2, tbl3)
end)
