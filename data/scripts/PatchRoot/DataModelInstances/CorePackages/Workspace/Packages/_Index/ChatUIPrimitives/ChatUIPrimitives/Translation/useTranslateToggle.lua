-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent

local React = require(ChatUIPrimitivesParent.React)
local SignalsReact = require(ChatUIPrimitivesParent.SignalsReact)

local _Types = require(ChatUIPrimitives.Types)
local useStableSignal = require(ChatUIPrimitives.Hooks.useStableSignal)
local shouldOfferTranslation = require(ChatUIPrimitives.Translation.shouldOfferTranslation)

local function useTranslateToggle(bool1: boolean, str1: string?, bool2: boolean)
    local var1, var2 = useStableSignal(true)

    React.useEffect(function()
        var2(true)
    end, { str1, var2 })

    local shouldShowTranslation = SignalsReact.useSignalState(var1)

    return {
        isOffered = React.useMemo(function()
            return not (bool1 == nil) and shouldOfferTranslation(bool1, bool2)
        end, { bool1, bool2 }),
        shouldShowTranslation = shouldShowTranslation,
        onToggle = React.useCallback(function()
            var2(not var1())
        end, { var1, var2 })
    }
end

return useTranslateToggle
