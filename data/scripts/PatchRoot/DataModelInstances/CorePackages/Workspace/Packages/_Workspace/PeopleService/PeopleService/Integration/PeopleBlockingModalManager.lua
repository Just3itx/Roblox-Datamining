-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleServiceParent = script:FindFirstAncestor("PeopleService").Parent

local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")

local React = require(PeopleServiceParent.React)
local ReactFocusNavigation = require(PeopleServiceParent.ReactFocusNavigation)
local Signals = require(PeopleServiceParent.Signals)
local useSignalState = require(PeopleServiceParent.SignalsReact).useSignalState

local onPersonBlockButtonActivated = require(script.Parent.Parent.onPersonBlockButtonActivated)
local PeopleAnalyticsManager = require(script.Parent.Parent.Analytics.PeopleAnalyticsManager)
local FocusNavigationService = require(script.Parent.Parent.FocusNavigationService)
local SettingsHubService = require(script.Parent.SettingsHubService)

local function createPeopleBlockingModalManager()
    local localPlayer = Players.LocalPlayer

    local var1, var2 = Signals.createSignal(false)
    local var3, var4 = Signals.createSignal(nil)

    local var5 = nil

    local function closeModal() -- Luacid: Inlined by compiler; 2 call sites recovered
        FocusNavigationService.setBlockingModalRestoreMode(true)
        var2(false)
        var4(nil)
        ContextActionService:UnbindCoreAction("BlockingModalScreen")
    end

    return {
        closeModal = closeModal,
        openModal = function(arg1, arg2, arg3)
            FocusNavigationService.saveScrollPosition()

            local var6 = onPersonBlockButtonActivated(arg1, PeopleAnalyticsManager, localPlayer.UserId, arg2, var5, arg3)

            function var6.modalProps.closeModal()
                var6.resolvePromise()
                closeModal()
            end

            var4(var6.modalProps)
            var2(true)

            return var6.promise
        end,
        getModalManager = function(arg1, arg2)
            var5 = arg2

            local function BlockingModalManager()
                local current = useSignalState(var1)

                local var7 = React.useContext(ReactFocusNavigation.FocusNavigationContext)
                local var8 = React.useRef(false)

                local var9 = React.useMemo(function()
                    return var3(false)
                end, { current })

                React.useEffect(function()
                    if current then
                        ContextActionService:BindCoreAction("BlockingModalScreen", function()
                            closeModal()
                        end, false, Enum.KeyCode.ButtonB, Enum.KeyCode.Escape)
                    else
                        ContextActionService:UnbindCoreAction("BlockingModalScreen")
                    end

                    return function()
                        ContextActionService:UnbindCoreAction("BlockingModalScreen")
                    end
                end, { current })

                React.useEffect(function()
                    if var8.current and not current then
                        local var10 = SettingsHubService.pageRef()
                        if var7 and var10 then
                            var7:focusGuiObject(var10, true)
                        end
                    end

                    var8.current = current
                end, { current, var7 })

                if not (current and var9) then
                    return nil
                end

                return React.createElement(arg1, var9)
            end

            return BlockingModalManager
        end
    }
end

return (createPeopleBlockingModalManager())
