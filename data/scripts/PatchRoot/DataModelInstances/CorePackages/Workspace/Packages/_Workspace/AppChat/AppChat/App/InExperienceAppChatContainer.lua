-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NotificationService = game:GetService("NotificationService")
local Players = game:GetService("Players")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppCommonLib = require(AppChatParent.AppCommonLib)
local FormFactor = require(AppChatParent.FormFactor)
local React = require(AppChatParent.React)
local RealtimeDelivery = require(AppChatParent.RealtimeDelivery)
local Responsive = require(AppChatParent.Responsive)
local RoactUtils = require(AppChatParent.RoactUtils)
local SharedFlags = require(AppChatParent.SharedFlags)
local Foundation = require(AppChatParent.Foundation)
local IconSize = Foundation.Enums.IconSize
local IconButton = Foundation.IconButton
local IconName = Foundation.Enums.IconName
local ButtonSize = Foundation.Enums.ButtonSize
local ButtonVariant = Foundation.Enums.ButtonVariant
local Loading = Foundation.Loading
local useSignalState = require(AppChatParent.SignalsReact).useSignalState

local SetFormFactor = FormFactor.Actions.SetFormFactor

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

local AppChatEntryPoint = require(AppChat.AppChatEntryPoint)
local ChatEventReceiver = require(AppChat.Components.EventReceivers.ChatEventReceiver)
local ChatExternalEventReceiver = require(AppChat.App.Components.ChatExternalEventReceiver)
local ChatPlacementContext = require(AppChat.Contexts.ChatPlacementContext)
local _InExperienceAppChatModal = require(AppChat.App.InExperienceAppChatModal)
local useParentContainerExtents = require(AppChat.Contexts.ParentContainer.useParentContainerExtents)
local Container = require(AppChat.Components.ExternalNavigationHandler.Container)
local useExternalNavigationByScreen = require(AppChat.Hooks.useExternalNavigationByScreen)
local useAppChatIsWideMode = require(AppChat.Hooks.useAppChatIsWideMode)

local ParentContainerContext = require(AppChat.Contexts.ParentContainer.ParentContainerContext)

local LocalPlayer = Players.LocalPlayer
local RobloxEventReceiver = RealtimeDelivery.RobloxEventReceiver
local Signal = AppCommonLib.Signal
local SquadAppChatEventReceiver = require(AppChatParent.SquadsCore.Components).SquadAppChatEventReceiver
local useMemo = React.useMemo
local useState = React.useState
local useEffect = React.useEffect
local useCallback = React.useCallback
local useContext = React.useContext
local useRef = React.useRef

local num1 = game:DefineFastInt("AppChatInExperienceMountMinLoadingTimeMs", 0)

local FFlagAppChatInExpSelectChatMembersMobileHeight = require(AppChat.Flags.FFlagAppChatInExpSelectChatMembersMobileHeight)
local FFlagSquadAppChatRTNFix = SharedFlags.FFlagSquadAppChatRTNFix
local FIntAppChatWideBreakpointMinHeight = require(AppChat.Flags.FIntAppChatWideBreakpointMinHeight)
local FIntAppChatWideBreakpointMinWidth = require(AppChat.Flags.FIntAppChatWideBreakpointMinWidth)
local PartyPageCarouselExperimentation = require(AppChatParent.SocialExperiments).PartyPageCarouselExperimentation
local FFlagDebugAppChatEnableDomLocators = require(AppChat.Flags.FFlagDebugAppChatEnableDomLocators)
local GetRootedNavigationStore = require(AppChat.Stores.GetRootedNavigationStore)
local DomLocators = require(AppChat.Utils.DomLocators)

local function getEnumScreens() -- Luacid: Inlined by compiler; 1 call site recovered
    return require(AppChat.EnumScreens)
end

return function(tbl1)
    local var1 = useDispatch()
    local hideParentContainer = useContext(ParentContainerContext).hideParentContainer
    local var2, setActiveConversationId = useState(0)
    local navigationByScreen, updateExternalNavigationForScreen = useExternalNavigationByScreen()
    local rnBypassActionSignal = useMemo(function()
        return Signal.new()
    end, {})

    local robloxEventReceiver = useMemo(function()
        return RobloxEventReceiver.new(NotificationService)
    end, {})

    local var8 = React.useRef(nil)

    local var9 = Responsive.useOrientation()
    local bool1 = Responsive.useResponsive(
        {{
            Key = "wide",
            minWidth = FIntAppChatWideBreakpointMinWidth,
            minHeight = FIntAppChatWideBreakpointMinHeight
        }}
    ) == "wide"

    local var10 = not FFlagAppChatInExpSelectChatMembersMobileHeight or useAppChatIsWideMode(true)

    if not FFlagAppChatInExpSelectChatMembersMobileHeight and (var9 == Responsive.Keys.Portrait or not bool1) then
        var10 = false
    end

    local bool2 = not (tbl1.requestedRoute == nil
        or tbl1.requestedRoute.screen ~= getEnumScreens().ChatDetails
        or tbl1.requestedRoute.params == nil)
        and tbl1.requestedRoute.params.rooted == true
    local var11 = useRef(false)
    if bool2 then
        var11.current = true
    end

    if var11.current then
        var10 = false
    end
    local var12 = useSignalState(GetRootedNavigationStore(false).getIsNavigationPending)

    useEffect(function()
        if not PartyPageCarouselExperimentation.getAppChatFormFactorEnabled() then
            return
        end

        if var10 then
            var1(SetFormFactor(FormFactor.Enums.FormFactor.WIDE))
            return
        end
        var1(SetFormFactor(FormFactor.Enums.FormFactor.COMPACT))
    end, { var10, var1 })

    local var13, var14 = useParentContainerExtents()

    local bool3 = var9 == Responsive.DefaultKey
    local var15, var16 = useState(bool3)
    local var17 = useRef(os.clock())

    local var18 = useCallback(function()
        tbl1.hideAppChat()
        hideParentContainer()
    end, { hideParentContainer, tbl1.hideAppChat })

    useEffect(function()
        if bool3 then
            return
        end

        local var19 = os.clock() - var17.current
        local num2 = num1 / 1000

        if var19 < num2 then
            delay(num2 - var19, function()
                var16(false)
            end)

            return
        end

        var16(false)
    end, { bool3, var16 })

    local appChatEntryPoint = React.createElement(AppChatEntryPoint, {
        setActiveConversationId = setActiveConversationId,
        localUserId = if LocalPlayer then LocalPlayer.UserId else nil,
        chatPlacement = ChatPlacementContext.Enum.InExperienceDefault,
        isVisible = true,
        initialConversationId = tbl1.initialConversationId,
        setInitialConversationId = tbl1.setInitialConversationId,
        requestedRoute = tbl1.requestedRoute,
        clearRequestedRoute = tbl1.clearRequestedRoute,
        wideMode = var10,
        navigateToRootStack = var18,
        updateExternalNavigationForScreen = updateExternalNavigationForScreen
    })

    local createElement = React.createElement
    local fragment = React.Fragment
    local tbl2 = {}
    local tbl3 = {
        AppChatWindow = 0,
        ChatEventReceiver = 0,
        ChatExternalEventReceiver = 0,
        ExternalNavigationHandler = 0,
        SquadAppChatEventReceiver = 0
    }
    local createElement2 = React.createElement
    local str1 = "Frame"

    local tbl4 = {
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
        Size = var13:map(function(vector2: Vector2): UDim2
            return UDim2.fromOffset(vector2.X, vector2.Y)
        end),
        Position = var14:map(function(vector2: Vector2): UDim2
            return UDim2.fromOffset(vector2.X, vector2.Y)
        end),
        ref = var8
    }

    local tbl5 = {
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) }),
        containerRef = 0
    }
    local createElement3 = React.createElement
    local provider = Responsive.ContainerRef.Provider
    local tbl6 = { value = var8 }
    local tbl7 = { AppChatContent = 0, LoadingOverlay = 0 }
    local element2

    if var15 then
        if var12 then
            element2 = nil
        else
            element2 = React.createElement(
                Loading,
                {
                    size = IconSize.Large,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5)
                }
            )
        end
    else
        element2 = React.createElement("Frame", {
            Name = "AppChatContent",
            [React.Tag] = "data-testid=app-chat-content",
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Visible = not var12
        }, { AppChatEntryPoint = appChatEntryPoint })
    end

    tbl7.AppChatContent = element2
    local var19

    if var12 then
        local createElement4 = React.createElement
        local str2 = "Frame"
        local tbl8 = {
            Name = "AppChatLoadingOverlay",
            [React.Tag] = "data-testid=app-chat-loading-overlay",
            Active = true,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            ZIndex = 2
        }
        local tbl9 = {
            Spinner = React.createElement(
                Loading,
                {
                    size = IconSize.Large,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.fromScale(0.5, 0.5)
                }
            ),
            BackButton = React.createElement(IconButton, {
                icon = IconName.ChevronLargeLeft,
                size = ButtonSize.XSmall,
                variant = ButtonVariant.Utility,
                AnchorPoint = Vector2.new(0, 0),
                Position = UDim2.fromOffset(12, 12),
                ZIndex = 3,
                onActivated = var18,
                testId = if FFlagDebugAppChatEnableDomLocators then DomLocators.appChatLoadingOverlayBackButton() else nil
            })
        }
        var19 = createElement4(str2, tbl8, tbl9)
    else
        var19 = nil
    end

    tbl7.LoadingOverlay = var19
    tbl5.containerRef = createElement3(provider, tbl6, tbl7)
    tbl3.AppChatWindow = createElement2(str1, tbl4, tbl5)

    tbl3.ChatEventReceiver = React.createElement(ChatEventReceiver, {
        robloxEventReceiver = robloxEventReceiver,
        rnBypassActionSignal = rnBypassActionSignal,
        activeConversationId = tostring(var2)
    })
    tbl3.ChatExternalEventReceiver = React.createElement(
        ChatExternalEventReceiver,
        {
            robloxEventReceiver = robloxEventReceiver,
            localUserId = if LocalPlayer then LocalPlayer.UserId else nil
        }
    )
    tbl3.ExternalNavigationHandler = React.createElement(Container, { navigationByScreen = navigationByScreen })

    tbl3.SquadAppChatEventReceiver = if FFlagSquadAppChatRTNFix then React.createElement(SquadAppChatEventReceiver) else nil
    return createElement(fragment, tbl2, tbl3)
end
