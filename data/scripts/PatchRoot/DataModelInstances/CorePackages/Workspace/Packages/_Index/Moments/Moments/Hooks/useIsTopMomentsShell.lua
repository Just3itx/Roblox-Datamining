-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local GetMomentsShellStackStore = require(Moments.Stores.GetMomentsShellStackStore)

local function useIsTopMomentsShell(callback: (...any) -> (...any)): boolean
    local momentsShellStackStore = GetMomentsShellStackStore(false)
    local var1, var2 = React.useState(nil)
    React.useLayoutEffect(function()
        if momentsShellStackStore.getTopShellId(false) ~= nil then
            callback("pushed")
        end
        local var3, var4 = momentsShellStackStore.pushShell()
        var2(var3)
        return function()
            if momentsShellStackStore.getTopShellId(false) == var3 then
                callback("popped")
            end
            var4()
        end
    end, { momentsShellStackStore, callback })
    local var3 = SignalsReact.useSignalState(momentsShellStackStore.getTopShellId)
    return not (var1 == nil) and var1 == var3
end

return useIsTopMomentsShell
