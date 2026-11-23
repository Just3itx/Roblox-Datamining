-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local ChatCardEmphasisContext = require(script.Parent.ChatCardEmphasisContext)
local ChatCardEmphasisPositionContext = require(script.Parent.ChatCardEmphasisPositionContext)

local function useChatCardEmphasis(num1: number?, num2: number?)
    local var1 = React.useContext(ChatCardEmphasisContext)
    local var2 = React.useMemo(function()
        return {}
    end, {})
    local var3 = React.useContext(ChatCardEmphasisPositionContext)

    React.useLayoutEffect(function()
        if var1 == nil or num1 == nil then
            return nil
        end
        var1.register(var2, num1, num2 or 0, var3)
        return function()
            var1.unregister(var2)
        end
    end, {
        var1,
        var2,
        num1,
        num2,
        var3
    })
    local var4 = React.useMemo(function()
        return Signals.createComputed(function(arg1): boolean
            return not (var1 == nil) and var1.getEmphasizedKey(arg1) == var2
        end)
    end, { var1, var2 })
    local var5 = SignalsReact.useSignalState(var4)

    return if var1 == nil then nil else var5
end

return useChatCardEmphasis
