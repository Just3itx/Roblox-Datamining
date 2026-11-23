-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Display = require(BuildExperienceParent.Display)
local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local ReactRoblox = require(BuildExperienceParent.ReactRoblox)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local BuildPillMenu = require(script.Parent.BuildPillMenu)
local BuildPillMenuPageHost = require(script.Parent.BuildPillMenuPageHost)
local GetBuildPillMenuPortalStore = require(BuildExperience.Stores.GetBuildPillMenuPortalStore)
local FFlagBuildPublishNavigationSheet = require(BuildExperience.Flags.FFlagBuildPublishNavigationSheet)
local PublishSheetController = if FFlagBuildPublishNavigationSheet then require(BuildExperience.Components.PublishSheet.PublishSheetController) else nil
local View = Foundation.View
local useOverlay = Foundation.Hooks.useOverlay
local useStyleSheet = Foundation.Hooks.useStyleSheet
local useTokens = Foundation.Hooks.useTokens

local function isSideSheet(displaySize, vector2: Vector2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return displaySize ~= Enum.DisplaySize.Small or vector2.X > vector2.Y
end

local function getOverlayPosition(arg1, arg2): UDim2 -- Luacid: unused: defined but never referenced
    local vector2 = if arg2:IsA("GuiObject") then arg2.AbsolutePosition else Vector2.zero
    local var1 = arg1.AbsolutePosition - vector2

    return UDim2.fromOffset(var1.X, var1.Y)
end

return React.memo(function(tbl1) -- name: BuildPillMenuPortal
    local buildPillMenuPortalStore = GetBuildPillMenuPortalStore()
    local var1 = SignalsReact.useSignalState(buildPillMenuPortalStore.getPortalTarget)
    local var2 = useOverlay()
    local styleSheet = useStyleSheet()
    local var4 = useTokens()
    local displayStore = Display.GetDisplayStore(false)
    local displaySize = SignalsReact.useSignalState(displayStore.getDisplaySize)
    local var5 = SignalsReact.useSignalState(displayStore.getViewportSize)
    local var6 = React.useRef(nil)
    local activePage, var8 = React.useState(nil)
    local isOpen, var10 = React.useState(false)
    local sheet = if tbl1.sheet ~= nil and isSideSheet(displaySize, var5) then tbl1.sheet else nil

    local var11 = React.useCallback(function()
        local current = var6.current
        if var1 == nil or var2 == nil or current == nil then
            return
        end

        local var11 = var1
        local var12 = var2
        local vector2 = if var12:IsA("GuiObject") then var12.AbsolutePosition else Vector2.zero
        local var13 = var11.AbsolutePosition - vector2

        current.Position = UDim2.fromOffset(var13.X, var13.Y)
    end, { var1, var2 })

    local var12 = React.useCallback(function(current)
        var6.current = current
        var11()
    end, { var11 })

    local onOpenPage = React.useCallback(function(page)
        if FFlagBuildPublishNavigationSheet and page == "publish" then
            var10(true)
            return
        end
        var8({ type = "overflow", page = page })
    end, {})

    local onOpenAgentsPage = React.useCallback(function()
        var8({ type = "agents" })
    end, {})

    local onOpenInvitePicker = React.useCallback(function()
        var8({ type = "invitePicker" })
    end, {})

    local var16 = React.useCallback(function()
        var8({ type = "playtestManagement" })
    end, {})

    local onOpenCreatorCreditPage = React.useCallback(function()
        var8({ type = "creator-credit" })
    end, {})

    local onClose = React.useCallback(function()
        var8(nil)
    end, {})

    local onOpenChat = React.useCallback(function(str1: string)
        onClose()
        if tbl1.onOpenChat ~= nil then
            tbl1.onOpenChat(str1)
        end
    end, { onClose, tbl1.onOpenChat })

    local var3 = React.useCallback(function()
        var10(false)
    end, {})

    local navigateToSubPage = React.useCallback(function(screen: string, tbl2)
        var8({
            type = "screen",
            screen = screen,
            target = {
                universeId = tbl2.universeId,
                placeId = tbl2.placeId,
                sessionId = tbl2.sessionId,
                isNewGameTarget = tbl2.isNewGameTarget or false
            }
        })
    end, {})

    React.useLayoutEffect(function()
        if sheet == nil then
            return
        end

        local clipsDescendants = sheet.ClipsDescendants

        sheet.ClipsDescendants = false

        return function()
            sheet.ClipsDescendants = clipsDescendants
        end
    end, { sheet })

    React.useLayoutEffect(function()
        if sheet ~= nil then
            return
        end
        if var1 == nil or var2 == nil then
            return
        end

        var11()

        local connection = var1:GetPropertyChangedSignal("AbsolutePosition"):Connect(var11)
        local connection2 = if var2:IsA("GuiObject") then var2:GetPropertyChangedSignal("AbsolutePosition"):Connect(var11) else nil

        return function()
            connection:Disconnect()
            if connection2 ~= nil then
                connection2:Disconnect()
            end
        end
    end, {
        sheet,
        var1,
        var2,
        var11
    })

    if var1 == nil or var2 == nil then
        return nil
    end

    local createElement = React.createElement
    local fragment = React.Fragment
    local var22 = nil
    local tbl2 = {
        StyleLink = React.createElement("StyleLink", { StyleSheet = styleSheet }),
        Container = 0
    }
    local createElement2 = React.createElement
    local var23 = View
    local tbl3 = {
        AnchorPoint = if sheet ~= nil then Vector2.new(1, 0) else var1.AnchorPoint,
        Position = if sheet == nil then nil else UDim2.fromOffset(-var4.Padding.Large, 0),
        ref = 0,
        ZIndex = 999,
        tag = "auto-xy",
        testId = "build-pill-menu-overlay-container"
    }

    if sheet ~= nil then
        var12 = nil
    end

    tbl3.ref = var12
    tbl2.Container = createElement2(var23, tbl3, {
        Pill = React.createElement(BuildPillMenu, {
            target = tbl1.target,
            testId = tbl1.testId,
            onOpenPage = onOpenPage,
            onOpenInvitePicker = onOpenInvitePicker,
            onOpenPlaytestManagement = var16,
            onOpenAgentsPage = onOpenAgentsPage,
            onOpenCreatorCreditPage = onOpenCreatorCreditPage
        })
    })
    local element = createElement(fragment, var22, tbl2)

    return React.createElement(React.Fragment, nil, {
        Pill = ReactRoblox.createPortal(element, if sheet == nil then var2 else sheet),
        Page = React.createElement(BuildPillMenuPageHost, {
            activePage = activePage,
            target = tbl1.target,
            onClose = onClose,
            onOpenChat = onOpenChat,
            onInvitesSent = var16,
            onOpenInvitePicker = onOpenInvitePicker
        }),
        PublishSheet = if FFlagBuildPublishNavigationSheet then React.createElement(PublishSheetController, {
            isOpen = isOpen,
            target = tbl1.target,
            onClose = var3,
            navigateToSubPage = navigateToSubPage,
            showPreviewButton = false
        }) else nil
    })
end)
