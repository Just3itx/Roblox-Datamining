-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:00:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local PartyIcon = require(script.Parent.PartyIcon)

local Service = require(Chrome.Service)
local ChromeIntegrationUtils = require(Chrome.Integrations.ChromeIntegrationUtils)
local GetFStringConnectTooltipLocalStorageKey = require(Chrome.Flags.GetFStringConnectTooltipLocalStorageKey)
local LocalStore = require(Chrome.ChromeShared.Service.LocalStore)

local MappedSignal = require(Chrome.ChromeShared.Service.ChromeUtils).MappedSignal

local FocusUtils = require(CorePackages.Workspace.Packages.Chrome).FocusUtils
local Chrome2 = require(CorePackages.Workspace.Packages.Chrome)
local InExperienceAppChatModal = require(CorePackages.Workspace.Packages.AppChat.InExperienceAppChatModal)
local MouseIconOverrideService = require(CorePackages.Workspace.Packages.CoreScriptsCommon).MouseIconOverrideService
local React = require(CorePackages.Packages.React)
local Responsive = require(CorePackages.Workspace.Packages.Responsive)
local Symbol = require(CorePackages.Workspace.Packages.AppCommonLib).Symbol

local ChatEntryPointNames = require(CorePackages.Workspace.Packages.SocialCommon).Enums.ChatEntryPointNames

local FFlagAppChatDistinctUnibarEntryPoint = require(CorePackages.Workspace.Packages.SharedFlags).FFlagAppChatDistinctUnibarEntryPoint

local SideSheetPlacement = Chrome2.Enums.SideSheetPlacement

local mappedSignal = MappedSignal.new(InExperienceAppChatModal.default.visibilitySignal.Event, function()
    return InExperienceAppChatModal:getVisible()
end)

return function(str1: string, initialAvailability: number)
    local var1 = Service:register({
        id = str1,
        sideSheetPlacement = SideSheetPlacement.None,
        label = "Feature.Squads.Label.Party",
        activated = function()
            if InExperienceAppChatModal:getVisible() then
                InExperienceAppChatModal.default:setVisible(false)
            else
                ChromeIntegrationUtils.dismissRobloxMenuAndRun(function()
                    if Responsive.GetInputModeStore(false).getLastInputType(false) == Responsive.Input.Directional then
                        FocusUtils.FocusOffChrome()
                    end
                    if FFlagAppChatDistinctUnibarEntryPoint then
                        InExperienceAppChatModal.default:setVisible(true, ChatEntryPointNames.ChromeUnibar)
                        return
                    end
                    InExperienceAppChatModal.default:setVisible(true)
                end)
            end

            LocalStore.storeForLocalPlayer(GetFStringConnectTooltipLocalStorageKey(), true)
        end,
        isActivated = mappedSignal,
        components = {
            Icon = function(arg1)
                return React.createElement(PartyIcon, { integrationId = str1, isIconVisible = arg1.visible })
            end
        },
        initialAvailability = initialAvailability
    })

    local inExperienceRobloxParty = Symbol.named("InExperienceRobloxParty")
    InExperienceAppChatModal.default.visibilitySignal.Event:Connect(function(arg1)
        if arg1 then
            MouseIconOverrideService.push(inExperienceRobloxParty, Enum.OverrideMouseIconBehavior.ForceShow)
            return
        end
        MouseIconOverrideService.pop(inExperienceRobloxParty)
    end)

    return var1
end
