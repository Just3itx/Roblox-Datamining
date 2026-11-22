-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local React = require(ServerTriggeredModalsParent.React)
local MessageBus = require(ServerTriggeredModalsParent.MessageBus).MessageBus
local t = require(ServerTriggeredModalsParent.t)
local UniversalAppPolicy = require(ServerTriggeredModalsParent.UniversalAppPolicy)

local PromptsHandler = require(script.Parent.PromptsHandler).PromptsHandler
local PromptsEntryPoint = require(script.Parent.PromptsEntryPoint)
local isPinShortcutAvailable = require(script.Parent.isPinShortcutAvailable)
local isCustomAppEntryPointAutoJoinAvailable = require(script.Parent.isCustomAppEntryPointAutoJoinAvailable)
local isRecentInstall = require(script.Parent.isRecentInstall)
local useLocalUserId = require(ServerTriggeredModalsParent.RobloxAppHooks).useLocalUserId
local getAppFeaturePolicies = UniversalAppPolicy.getAppFeaturePolicies

local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)

local FFlagEdpGameLeavePromptsPassPinShortcutAvailable = require(ServerTriggeredModalsParent.SharedFlags).FFlagEdpGameLeavePromptsPassPinShortcutAvailable

local FFlagEdpGameLeavePromptsPassCustomAppEntryPointAutoJoin = require(ServerTriggeredModalsParent.SharedFlags).FFlagEdpGameLeavePromptsPassCustomAppEntryPointAutoJoin
local FFlagAddPinExperienceTargetDestinationGUACPolicy = SharedFlags.FFlagAddPinExperienceTargetDestinationGUACPolicy

local bool1 = game:DefineFastFlag("AvoidShowingMobileUpsellDialogOnDesktopHackyLuaFix", false)

local bool2 = game:DefineFastFlag("PassInPinShortcutTargetDestinationToUpsellResolver", false)
local FFlagEdpGameLeavePromptsPassIsRecentInstall = SharedFlags.FFlagEdpGameLeavePromptsPassIsRecentInstall

local function EdpGameLeavePromptsHandler(tbl1)
    local var1, var2 = React.useState(0)
    local var3 = React.useMemo(isPinShortcutAvailable, {})
    local var4 = React.useMemo(function()
        return FFlagEdpGameLeavePromptsPassCustomAppEntryPointAutoJoin and isCustomAppEntryPointAutoJoinAvailable()
    end, {})

    local var5 = if FFlagEdpGameLeavePromptsPassIsRecentInstall then useLocalUserId() else nil
    local var6 = if FFlagAddPinExperienceTargetDestinationGUACPolicy then getAppFeaturePolicies().getPinExperienceTargetDestination() else "HomeScreen"

    local clientAttributes = React.useMemo(function(): {universeId: any}?
        if tbl1.universeId == nil then
            return nil
        end
        local tbl2 = {
            universeId = tbl1.universeId
        }
        if FFlagEdpGameLeavePromptsPassPinShortcutAvailable then
            if bool1 and FFlagAddPinExperienceTargetDestinationGUACPolicy then
                if var6 == "Desktop" then
                    tbl2.isPinnedShortcutAvailableDesktop = tostring(var3)

                    tbl2.isPinnedShortcutAvailable = "false"
                else
                    tbl2.isPinnedShortcutAvailable = tostring(var3)
                end
            else
                tbl2.isPinnedShortcutAvailable = tostring(var3)
            end
        end
        if FFlagEdpGameLeavePromptsPassCustomAppEntryPointAutoJoin then
            tbl2.isCustomAppEntryPointAutoJoinAvailable = tostring(var4)
        end

        if FFlagEdpGameLeavePromptsPassIsRecentInstall and var1 > 0 then
            tbl2.isRecentInstall = tostring(isRecentInstall(var5))
        end

        if bool2 and FFlagAddPinExperienceTargetDestinationGUACPolicy then
            tbl2.pinnedShortcutTargetDestination = getAppFeaturePolicies().getPinExperienceTargetDestination()
        end

        return tbl2
    end, {
        tbl1.universeId,
        var3,
        var4,
        var6,
        var5,
        var1
    })

    React.useEffect(function()
        if tbl1.universeId == nil then
            return
        end
        if not (FFlagEdpGameLeavePromptsPassPinShortcutAvailable or var3) then
            return
        end

        local subscriber = MessageBus.Subscriber.new()
        local mid = MessageBus.getMessageId("Game", "onGameLeave")
        subscriber:subscribe({
            mid = mid,
            validateParams = t.table
        }, function()
            var2(function(num1: number): number
                return num1 + 1
            end)
        end)

        return function()
            subscriber:unsubscribeWithMsgId(mid)
        end
    end, { var3, tbl1.universeId })

    if var1 == 0 or clientAttributes == nil or not (FFlagEdpGameLeavePromptsPassPinShortcutAvailable or var3) then
        return nil
    end

    return React.createElement(PromptsHandler, {
        key = "EdpPrompts" .. tostring(var1),
        entryPoint = PromptsEntryPoint.ExperienceDetailsPageSessionEnd,
        clientAttributes = clientAttributes
    })
end

return EdpGameLeavePromptsHandler
