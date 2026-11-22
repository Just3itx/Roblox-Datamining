-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseAppParent = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp").Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(RobloxSubscriptionPurchaseAppParent.AppLocales).Localization
local LocalizationProvider = require(RobloxSubscriptionPurchaseAppParent.Localization).LocalizationProvider

return {
    makeTestRoot = function(child)
        return React.createElement(
            LocalizationProvider,
            {
                localization = Localization.new(LocalizationService.RobloxLocaleId)
            },
            { Child = child }
        )
    end,
    NativePurchaseFinishedWithLocalPlayer = {
        new = function() -- name: newNativePurchaseFinishedWithLocalPlayer
            local bindableEvent = Instance.new("BindableEvent")
            return {
                getSignal = function(): RBXScriptSignal
                    return bindableEvent.Event
                end,
                fire = function(num1: number, bool1: boolean)
                    bindableEvent:Fire(num1, bool1)
                end
            }
        end
    },
    NativePurchaseFinishedWithLocalPlayerV2 = {
        new = function() -- name: newNativePurchaseFinishedWithLocalPlayerV2
            local bindableEvent = Instance.new("BindableEvent")
            return {
                getSignal = function(): RBXScriptSignal
                    return bindableEvent.Event
                end,
                fire = function(num1: number, bool1: boolean, str1: string)
                    bindableEvent:Fire(num1, bool1, str1)
                end
            }
        end
    },
    NativePurchaseFinished = {
        new = function() -- name: newNativePurchaseFinished
            local bindableEvent = Instance.new("BindableEvent")
            return {
                getSignal = function(): RBXScriptSignal
                    return bindableEvent.Event
                end,
                fire = function(arg1, num1: number, bool1: boolean)
                    bindableEvent:Fire(arg1, num1, bool1)
                end
            }
        end
    },
    NativePurchaseFinishedV2 = {
        new = function() -- name: newNativePurchaseFinishedV2
            local bindableEvent = Instance.new("BindableEvent")
            return {
                getSignal = function(): RBXScriptSignal
                    return bindableEvent.Event
                end,
                fire = function(arg1, num1: number, bool1: boolean, str1: string)
                    bindableEvent:Fire(arg1, num1, bool1, str1)
                end
            }
        end
    },
    LocalPlayerHasRobloxSubscription = {
        new = function() -- name: newMockLocalPlayerHasRobloxSubscription
            local bindableEvent = Instance.new("BindableEvent")
            return {
                HasRobloxSubscription = false,
                GetPropertyChangedSignal = function(_, str1: string): RBXScriptSignal
                    assert(str1 == "HasRobloxSubscription", "Invalid property name")
                    return bindableEvent.Event
                end,
                setHasRobloxSubscription = function(tbl1, hasRobloxSubscription: boolean)
                    tbl1.HasRobloxSubscription = hasRobloxSubscription
                    bindableEvent:Fire()
                end
            }
        end
    }
}
