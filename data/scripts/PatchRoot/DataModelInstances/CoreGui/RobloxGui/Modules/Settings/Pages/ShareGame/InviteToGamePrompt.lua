-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")
local ContextActionService = game:GetService("ContextActionService")
local GuiService = game:GetService("GuiService")

local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local Rodux = require(CorePackages.Packages.Rodux)

local Modules = RobloxGui.Modules
local Settings = Modules.Settings
local Constants = require(Modules.Settings.Pages.ShareGame.Constants)
local GameInviteEvents = require(CorePackages.Workspace.Packages.GameInvite).GameInviteEvents

local ShareGame = Settings.Pages.ShareGame
local FullModalShareGameComponent = require(ShareGame.Components.FullModalShareGameComponent)
local AppReducer = require(ShareGame.AppReducer)

local renderWithCoreScriptsStyleProvider = require(Modules.Common.renderWithCoreScriptsStyleProvider)

local InviteStore = require(ShareGame.InviteStore)
local GetFFlagEnableSharedInviteStore = require(Modules.Flags.GetFFlagEnableSharedInviteStore)

local GetFFlagAbuseReportAnalyticsHasLaunchData = require(Modules.Settings.Flags.GetFFlagAbuseReportAnalyticsHasLaunchData)

local module = {}
module.__index = module

function module.new(mountTarget)
    local tbl1 = { mountTarget = mountTarget, isActive = false }

    setmetatable(tbl1, module)

    return tbl1
end

function module.withSocialServiceAndLocalPlayer(arg1, socialService, localPlayer)
    arg1.socialService = socialService
    arg1.localPlayer = localPlayer
    return arg1
end

function module.withAnalytics(arg1, analytics)
    arg1.analytics = analytics
    return arg1
end

function module.withRequestImpl(arg1, requestImpl)
    arg1.requestImpl = requestImpl
    return arg1
end

function module:_createTree(isVisible: boolean, tbl1)
    local store = if GetFFlagEnableSharedInviteStore() then InviteStore else Rodux.Store.new(AppReducer, nil, { Rodux.thunkMiddleware })

    return renderWithCoreScriptsStyleProvider({
        FullModalShareGame = Roact.createElement(FullModalShareGameComponent, {
            store = store,
            isVisible = isVisible,
            analytics = self.analytics,
            promptMessage = tbl1 and tbl1.promptMessage,
            inviteUserId = tbl1 and tbl1.inviteUserId,
            inviteMessageId = tbl1 and tbl1.inviteMessageId,
            launchData = tbl1 and tbl1.launchData,
            isLoading = tbl1 and tbl1.isLoading,
            requestImpl = self.requestImpl,
            onAfterClosePage = function(_)
                self:hide({})
            end
        })
    })
end

function module:show(tbl1)
    if self.isActive then
        return
    end
    self.isLoading = tbl1 and tbl1.isLoading
    self.isActive = not self.isLoading

    if tbl1 then
        local var1 = if tbl1.inviteUserId then Constants.Triggers.DeveloperSingle else Constants.Triggers.DeveloperMultiple
        local isLaunchDataProvided = not (tbl1.launchData == nil) and tbl1.launchData ~= ""
        self.analytics:sendEvent(
            var1,
            GameInviteEvents.ModalOpened,
            GetFFlagAbuseReportAnalyticsHasLaunchData() and {
                isLaunchDataProvided = isLaunchDataProvided
            } or nil
        )
    end

    if not self.instance then
        self.instance = Roact.mount(self:_createTree(true, tbl1), self.mountTarget, "invitePrompt")
    else
        self.instance = Roact.update(self.instance, self:_createTree(true, tbl1))
    end

    if self.analytics and not self.isLoading then
        self.analytics:inputShareGameEntryPoint()
    end

    ContextActionService:BindCoreAction("hideInvitePrompt", function(_, userInputState, _)
        if userInputState == Enum.UserInputState.Begin then
            self:hide()
        end
    end, false, Enum.KeyCode.ButtonB, Enum.KeyCode.Backspace)
end

function module:hide(_)
    if not (self.isActive or self.isLoading) then
        return
    end
    self.isLoading = false
    self.isActive = false

    self.instance = Roact.update(self.instance, self:_createTree(false))
    if self.socialService and self.localPlayer then
        self.socialService:InvokeGameInvitePromptClosed(self.localPlayer, {})
    end

    ContextActionService:UnbindCoreAction("hideInvitePrompt")
    GuiService.SelectedCoreObject = nil
    GuiService:RemoveSelectionGroup("invitePrompt")
end

function module.destruct(arg1)
    if arg1.instance then
        Roact.unmount(arg1.instance)
    end
end

return module
