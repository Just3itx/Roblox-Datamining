-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)
local SignalsReact = require(ExpChatParent.SignalsReact)

local GetTransparencyStore = require(ExpChat.Stores.GetTransparencyStore)
local useIsChatBackgroundVisible = require(ExpChat.Stores.GetTransparencyStore.useIsChatBackgroundVisible)
local usePausableTimeout = require(ExpChat.Stores.GetTransparencyStore.usePausableTimeout)

local DictationAnalytics = require(script.Parent.DictationAnalytics)
local DictationFTUXStorage = require(script.Parent.DictationFTUXStorage)

local function useDictationFTUX(tbl1)
    local var1 = useIsChatBackgroundVisible()

    local transparencyStore = GetTransparencyStore(false)
    local var2 = SignalsReact.useSignalState(transparencyStore.getIsTextBoxFocused)

    local var3, var4 = React.useState(function()
        return DictationFTUXStorage.hasBeenDismissed()
    end)
    local var5, var6 = React.useState(function()
        return DictationFTUXStorage.hasBeenUsed()
    end)

    local dismiss = React.useCallback(function(arg1)
        var4(function(arg2)
            if arg2 then
                return arg2
            end
            DictationFTUXStorage.markDismissed()
            DictationAnalytics.fire(DictationAnalytics.Events.FtuxDismiss, {
                [DictationAnalytics.Properties.SttMode] = DictationAnalytics.Modes.Continuous,
                [DictationAnalytics.Properties.DismissReason] = arg1 or DictationAnalytics.DismissReasons.UserInteraction
            })
            return true
        end)
    end, {})

    local markUsed = React.useCallback(function()
        var6(function(arg1)
            if arg1 then
                return arg1
            end
            DictationFTUXStorage.markUsed()
            return true
        end)
    end, {})

    local shouldShow = var5 and not var3 and tbl1.isEligible and not (tbl1.isComposing or tbl1.isActive) and not var2 and var1

    local var10 = React.useCallback(function()
        dismiss(DictationAnalytics.DismissReasons.Visibility)
    end, { dismiss })
    usePausableTimeout(shouldShow, 10, var10)

    local var11 = React.useRef(false)
    React.useEffect(function()
        if shouldShow and not var11.current then
            var11.current = true
            DictationAnalytics.fire(
                DictationAnalytics.Events.FtuxShown,
                {
                    [DictationAnalytics.Properties.SttMode] = DictationAnalytics.Modes.Continuous
                }
            )
        end
    end, { shouldShow })

    return { shouldShow = shouldShow, dismiss = dismiss, markUsed = markUsed }
end

return useDictationFTUX
