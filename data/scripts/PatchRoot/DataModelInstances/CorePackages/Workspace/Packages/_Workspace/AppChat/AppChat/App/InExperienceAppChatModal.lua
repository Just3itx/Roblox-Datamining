-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")

local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Tokens = require(AppChatParent.UIBlox).App.Style.Tokens
local ColorMode = require(AppChatParent.Foundation).Enums.ColorMode

local var1 = require(AppChatParent.SharedFlags).getFFlagSettingsHubIndependentBackgroundVisibility()
local getFFlagAppChatInExperienceTabBarAdjustment = require(AppChat.Flags.getFFlagAppChatInExperienceTabBarAdjustment)
local EnumScreens = require(AppChat.EnumScreens)

local ChatSessionRefCount = require(AppChat.Hooks.ChatSessionRefCount)

local module = {}
module.__index = module

local function getRootedNavigationStore() -- Luacid: Inlined by compiler; 2 call sites recovered
    return require(AppChat.Stores.GetRootedNavigationStore)(false)
end

local function isSupportedRootedRoute(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local params = tbl1.params
    local conversationId = if params then params.conversationId else nil
    return tbl1.screen == EnumScreens.ChatDetails
        and params ~= nil
        and params.rooted == true
        and type(conversationId) == "string"
        and conversationId ~= ""
end

function module._new()
    local tbl1 = {
        _visible = false,
        _wasVisible = false,
        visibilitySignal = Instance.new("BindableEvent"),
        unreadCount = 0,
        unreadCountSignal = Instance.new("BindableEvent"),
        hasReceivedInitialUnreadCount = false,
        initialUnreadCountSignal = Instance.new("BindableEvent"),
        currentSquadId = "",
        currentSquadIdSignal = Instance.new("BindableEvent"),
        requestedRoute = nil,
        requestedRouteSignal = Instance.new("BindableEvent"),
        _reserveChatSessionOnClose = false,
        topMargin = 12
    }

    setmetatable(tbl1, module)
    return tbl1
end

function module:initialize(topMargin: number?, settingsHub, viewportUtil, chatSelector, playerListManager)
    if topMargin then
        self.topMargin = topMargin
    end

    self.settingsHub = settingsHub
    self._foundationTokens = Tokens.getFoundationTokensDefaultScale(ColorMode.Dark)

    if getFFlagAppChatInExperienceTabBarAdjustment() then
        self.viewportUtil = viewportUtil
    end

    self.chatSelector = chatSelector
    self.playerListManager = playerListManager
end

function module:setVisible(_visible: boolean, str1: string?)
    if not _visible then
        getRootedNavigationStore().cancelNavigation()
    end

    if _visible == self._visible then
        return
    end

    if not _visible and self._reserveChatSessionOnClose then
        self._reserveChatSessionOnClose = false

        if ChatSessionRefCount.getReservations() == 0 then
            ChatSessionRefCount.reserve()
        end
    end

    self._visible = _visible
    self.visibilitySignal:Fire(_visible, str1)

    if _visible then
        if self.chatSelector then
            self.chatSelector:HideTemp("AppChat", true)
        end

        if self.playerListManager then
            self.playerListManager:HideTemp("AppChat", true)
        end

        local inExperienceAppChatModal = Instance.new("ScreenGui")
        inExperienceAppChatModal.DisplayOrder = game:DefineFastInt("AppChatInExperienceStandaloneContainerDisplayOrder", 4)
        inExperienceAppChatModal.Parent = CoreGui
        inExperienceAppChatModal.Name = "InExperienceAppChatModal"

        local uiPadding = Instance.new("UIPadding")
        uiPadding.PaddingTop = UDim.new(0, self.topMargin)
        uiPadding.PaddingRight = UDim.new(0, 12)
        uiPadding.PaddingBottom = UDim.new(0, 0)
        uiPadding.PaddingLeft = UDim.new(0, 12)
        uiPadding.Parent = inExperienceAppChatModal

        local uiListLayout = Instance.new("UIListLayout")
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        uiListLayout.Parent = inExperienceAppChatModal

        local imageButton = Instance.new("ImageButton")
        imageButton.BorderSizePixel = 0
        imageButton.AutoButtonColor = false
        imageButton.Modal = true
        imageButton.BackgroundTransparency = self._foundationTokens.Color.OverMedia.OverMedia_0.Transparency
        imageButton.BackgroundColor3 = self._foundationTokens.Color.OverMedia.OverMedia_0.Color3
        imageButton.Size = UDim2.fromScale(1, 1)
        imageButton.Visible = true
        imageButton.Parent = inExperienceAppChatModal

        if getFFlagAppChatInExperienceTabBarAdjustment() and self.viewportUtil then
            local function func1()
                local var2 = self.viewportUtil.screenSize:get()

                if not (var2 and var2.X and var2.Y) then
                    return
                end

                if var2.Y > var2.X then
                    uiPadding.PaddingBottom = UDim.new(0, 0)
                else
                    uiPadding.PaddingBottom = UDim.new(0, GuiService:GetSafeZoneOffsets().bottom)
                end
            end

            self.viewportUtil.screenSize:connect(func1)

            func1()
        end

        local uiSizeConstraint = Instance.new("UISizeConstraint")
        uiSizeConstraint.MaxSize = Vector2.new(850, 780)
        uiSizeConstraint.Parent = imageButton

        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(0, 8)
        uiCorner.Parent = imageButton

        self.frame = imageButton
    else
        if self.frame and self.frame.Parent then
            self.frame.Parent:Destroy()
            self.frame = nil
        end

        if self.chatSelector then
            self.chatSelector:HideTemp("AppChat", false)
        end

        if self.playerListManager then
            self.playerListManager:HideTemp("AppChat", false)
        end
    end

    if self.settingsHub and var1 then
        self.settingsHub:SetBackgroundVisibility(_visible, false)
    end
end

function module.toggleVisibility(arg1)
    if arg1.default then
        local bool1 = not arg1.default._visible
        arg1.default:setVisible(bool1)
    end
end

function module.getVisible(arg1)
    return arg1.default._visible
end

function module.setUnreadCount(tbl1, unreadCount: number)
    tbl1.default.unreadCount = unreadCount
    tbl1.default.unreadCountSignal:Fire(unreadCount)
end

function module.markInitialUnreadCountReceived(tbl1, num1: number)
    if tbl1.default.hasReceivedInitialUnreadCount then
        return
    end
    tbl1.default.hasReceivedInitialUnreadCount = true
    tbl1.default.initialUnreadCountSignal:Fire(num1)
end

function module.setCurrentSquadId(tbl1, currentSquadId: string)
    tbl1.default.currentSquadId = currentSquadId
    tbl1.default.currentSquadIdSignal:Fire(currentSquadId)
end

function module:reserveChatSessionOnClose()
    self._reserveChatSessionOnClose = true
end

function module:openToScreen(tbl1)
    local rootedNavigationStore = getRootedNavigationStore()
    local tbl2

    if isSupportedRootedRoute(tbl1) then
        local params = table.clone(tbl1.params)
        params.rootedNavigationRequestId = rootedNavigationStore.beginNavigation()
        tbl2 = {
            screen = tbl1.screen,
            params = params
        }
    else
        rootedNavigationStore.cancelNavigation()
        tbl2 = tbl1
    end

    self.requestedRoute = tbl2
    self.requestedRouteSignal:Fire(tbl2)

    if tbl1.params and tbl1.params.rooted == true then
        self:reserveChatSessionOnClose()
    end

    local entryPoint = if tbl2.params then tbl2.params.entryPoint else nil
    self:setVisible(true, entryPoint)
end

function module:clearRequestedRoute()
    self.requestedRoute = nil
    self.requestedRouteSignal:Fire(nil)
end

module.default = module._new()

return module
