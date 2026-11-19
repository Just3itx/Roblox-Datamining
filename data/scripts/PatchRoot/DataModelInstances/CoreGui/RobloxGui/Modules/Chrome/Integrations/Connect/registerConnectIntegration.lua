-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local React = require(CorePackages.Packages.React)
local Service = require(Chrome.Service)
local ChromeUtils = require(Chrome.ChromeShared.Service.ChromeUtils)
local ConnectIcon = require(script.Parent.ConnectIcon)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local InExperienceAppChatModal = require(CorePackages.Workspace.Packages.AppChat.InExperienceAppChatModal)
local ChromeIntegrationUtils = require(Chrome.Integrations.ChromeIntegrationUtils)
local LocalStore = require(Chrome.ChromeShared.Service.LocalStore)

local MappedSignal = ChromeUtils.MappedSignal

local GetFStringConnectTooltipLocalStorageKey = require(Chrome.Flags.GetFStringConnectTooltipLocalStorageKey)

local MouseIconOverrideService = require(CorePackages.Workspace.Packages.CoreScriptsCommon).MouseIconOverrideService
local Symbol = require(CorePackages.Workspace.Packages.AppCommonLib).Symbol

local FocusUtils = require(CorePackages.Workspace.Packages.Chrome).FocusUtils
local UniversalAppPolicy = require(CorePackages.Workspace.Packages.UniversalAppPolicy)

local SideSheetPlacement = require(CorePackages.Workspace.Packages.Chrome).Enums.SideSheetPlacement

local bool1 = game:DefineFastFlag("AppChatInExpUseUnibarNotification", false)

local SharedFlags = require(CorePackages.Workspace.Packages.SharedFlags)
local GetFFlagIsSquadEnabled = SharedFlags.GetFFlagIsSquadEnabled
local FFlagAppChatDistinctUnibarEntryPoint = SharedFlags.FFlagAppChatDistinctUnibarEntryPoint

local ChatEntryPointNames = require(CorePackages.Workspace.Packages.SocialCommon).Enums.ChatEntryPointNames

local mappedSignal = MappedSignal.new(InExperienceAppChatModal.default.visibilitySignal.Event, function()
    return InExperienceAppChatModal:getVisible()
end)

return function(str1: string, initialAvailability: number)
    local isSquadIndicatorEnabled = str1 == "connect_unibar" and GetFFlagIsSquadEnabled()
    local chromeUnibar = if FFlagAppChatDistinctUnibarEntryPoint and str1 == "connect_unibar" then ChatEntryPointNames.ChromeUnibar else nil
    local var1 = Service
    local tbl1 = {
        id = str1,
        sideSheetPlacement = if str1 == "connect_unibar" then SideSheetPlacement.Unibar else SideSheetPlacement.BelowFold,
        label = if UniversalAppPolicy.getAppFeaturePolicies().getCanSeeChatTerminology() then "Feature.Chat.Title.FriendsChat" else "Feature.Squads.Label.Party",
        activated = 0,
        isActivated = 0,
        components = 0,
        initialAvailability = 0
    }

    function tbl1.activated()
        if InExperienceAppChatModal:getVisible() then
            InExperienceAppChatModal.default:setVisible(false)
        else
            ChromeIntegrationUtils.dismissRobloxMenuAndRun(function()
                if Responsive.GetInputModeStore(false).getLastInputType(false) == Responsive.Input.Directional then
                    FocusUtils.FocusOffChrome()
                end
                InExperienceAppChatModal.default:setVisible(true, chromeUnibar)
            end)
        end
        LocalStore.storeForLocalPlayer(GetFStringConnectTooltipLocalStorageKey(), true)
    end
    tbl1.isActivated = mappedSignal
    tbl1.components = {
        Icon = function(arg1)
            return React.createElement(ConnectIcon, {
                integrationId = str1,
                isIconVisible = arg1.visible,
                shouldShowCustomBadge = not bool1,
                isSquadIndicatorEnabled = isSquadIndicatorEnabled
            })
        end
    }
    tbl1.initialAvailability = initialAvailability
    local var2 = var1:register(tbl1)

    if bool1 then
        if isSquadIndicatorEnabled then
            local function updateNotificationBadge(num1: number, bool2: boolean) -- Luacid: Inlined by compiler; 3 call sites recovered
                if num1 == 0 or bool2 then
                    var2.notification:clear()
                    return
                end
                var2.notification:fireCount(num1)
            end

            InExperienceAppChatModal.default.currentSquadIdSignal.Event:Connect(function(arg1)
                updateNotificationBadge(InExperienceAppChatModal.default.unreadCount, arg1 ~= "")
            end)

            InExperienceAppChatModal.default.unreadCountSignal.Event:Connect(function(arg1)
                updateNotificationBadge(arg1, InExperienceAppChatModal.default.currentSquadId ~= "")
            end)

            updateNotificationBadge(
                InExperienceAppChatModal.default.unreadCount,
                InExperienceAppChatModal.default.currentSquadId ~= ""
            )
        else
            local function updateUnreadMessageCount(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
                if arg1 == 0 then
                    var2.notification:clear()
                    return
                end
                var2.notification:fireCount(arg1)
            end

            InExperienceAppChatModal.default.unreadCountSignal.Event:Connect(function(arg1)
                updateUnreadMessageCount(arg1)
            end)

            updateUnreadMessageCount(InExperienceAppChatModal.default.unreadCount)
        end
    end

    local inExperienceRobloxConnect = Symbol.named("InExperienceRobloxConnect")
    InExperienceAppChatModal.default.visibilitySignal.Event:Connect(function(arg1)
        if arg1 then
            MouseIconOverrideService.push(inExperienceRobloxConnect, Enum.OverrideMouseIconBehavior.ForceShow)
            return
        end
        MouseIconOverrideService.pop(inExperienceRobloxConnect)
    end)

    return var2
end
