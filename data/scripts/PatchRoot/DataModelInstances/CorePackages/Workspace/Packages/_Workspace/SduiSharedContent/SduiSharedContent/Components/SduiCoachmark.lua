-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContent = script:FindFirstAncestor("SduiSharedContent")
local SduiSharedContentParent = SduiSharedContent.Parent

local React = require(SduiSharedContentParent.React)
local Foundation = require(SduiSharedContentParent.Foundation)
local Navigation = require(SduiSharedContentParent.Navigation)
local Drawer = require(SduiSharedContentParent.Drawer)
local RoactUtils = require(SduiSharedContentParent.RoactUtils)
local SignalsReact = require(SduiSharedContentParent.SignalsReact)
local StreamNotifications = require(SduiSharedContentParent.StreamNotifications)
local sendCoachmarkImpression = require(SduiSharedContent.Analytics.sendCoachmarkImpression)
local FFlagPromptsCoachmarkImpressionOnShow = require(SduiSharedContentParent.SharedFlags).FFlagPromptsCoachmarkImpressionOnShow
local bool1 = game:DefineFastFlag("LuaAppUseNavFocusInSduiCoachmark", false)
local bool2 = game:DefineFastFlag("LuaAppCoachmarkImpression", false)
local bool3 = game:DefineFastFlag("LuaAppHideSduiCoachmarkWhenFlyoutOpen", false)

local bool4 = game:DefineFastFlag("LuaAppHideSduiCoachmarkWhenCentralOverlayOpen", false)

local bool5 = game:DefineFastFlag("LuaAppHideSduiCoachmarkWhenNotificationStreamOpen", false)
local FFlagEnableOnScreenAPIIntegration = require(SduiSharedContentParent.SharedFlags).FFlagEnableOnScreenAPIIntegration

local useIsRouteOnScreen = require(SduiSharedContentParent.RobloxAppNavigation).useIsRouteOnScreen

local Coachmark = Foundation.Coachmark
local useNavigationFocus = Navigation.useNavigationFocus
local useDrawerVisible = Drawer.Hooks.useDrawerVisible
local useSelector = RoactUtils.Hooks.RoactRodux.useSelector
local useSignalState = SignalsReact.useSignalState
local StreamNotificationStore = StreamNotifications.StreamNotificationStore

local CollectionService = game:GetService("CollectionService")

return React.memo(function(tbl1) -- name: SduiCoachmark
    local anchorRef = React.useRef(nil)
    local var2, var3 = React.useState(false)
    local var4, var5 = React.useState(false)
    local var6 = if bool1 and FFlagEnableOnScreenAPIIntegration then useIsRouteOnScreen() elseif bool1 then useNavigationFocus() else nil
    local var7 = if bool3 then useDrawerVisible() else false

    local var8 = if bool4 then useSelector(function(arg1): boolean
        return arg1.CentralOverlay.OverlayType ~= nil
    end) else nil

    local var9 = if bool5 then useSignalState(StreamNotificationStore.getStreamPresented) else nil

    React.useEffect(function()
        local function onTagAdded(current) -- Luacid: Inlined by compiler; 1 call site recovered
            if not current:IsA("GuiObject") then
                return
            end
            anchorRef.current = current
            var5(true)
        end

        local function onTagRemoved(_)
            anchorRef.current = nil
            var5(false)
        end

        for _, value in (CollectionService:GetTagged(tbl1.collectionServiceAnchorTag)) do
            if value:IsA("GuiObject") then
                onTagAdded(value)
                break
            end
        end

        local connection = CollectionService:GetInstanceAddedSignal(tbl1.collectionServiceAnchorTag):Connect(onTagAdded)
        local connection2 = CollectionService:GetInstanceRemovedSignal(tbl1.collectionServiceAnchorTag):Connect(onTagRemoved)

        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { tbl1.collectionServiceAnchorTag })

    local onClose = React.useCallback(function()
        var3(true)
        if tbl1.onClose then
            tbl1.onClose()
        end
    end, { tbl1.onClose })

    if bool2 or FFlagPromptsCoachmarkImpressionOnShow then
        local var11 = React.useRef(false)
        local var12 = var4 and not var2 and not not ((not bool1 or var6) and not (bool3 and var7) and not (bool4 and var8 or bool5 and var9))

        local useEffect = React.useEffect
        local function func1()
            if not var12 or var11.current then
                return
            end

            if FFlagPromptsCoachmarkImpressionOnShow and tbl1.onShown then
                tbl1.onShown()
            end

            if bool2 then
                local media = tbl1.media
                local bool6 = not (typeof(media) == "table" and next(media) == nil) and media ~= nil
                sendCoachmarkImpression(tbl1.collectionServiceAnchorTag, bool6)
            end

            var11.current = true
        end

        local collectionServiceAnchorTag = tbl1.collectionServiceAnchorTag
        local media = tbl1.media
        local onShown = if FFlagPromptsCoachmarkImpressionOnShow then tbl1.onShown else nil
        useEffect(func1, { var12, collectionServiceAnchorTag, media, onShown })

        if not var12 then
            return nil
        end
    elseif not var4 or var2 or bool1 and not var6 or bool3 and var7 or bool4 and var8 or bool5 and var9 then
        return nil
    end

    return React.createElement(Coachmark, {
        title = tbl1.title,
        text = tbl1.body,
        isOpen = if bool1 then true else var4 and not var2,
        side = tbl1.side,
        align = tbl1.align,
        anchorRef = anchorRef,
        onClose = onClose,
        actions = tbl1.actions,
        media = tbl1.media,
        testId = tbl1.testId
    })
end)
