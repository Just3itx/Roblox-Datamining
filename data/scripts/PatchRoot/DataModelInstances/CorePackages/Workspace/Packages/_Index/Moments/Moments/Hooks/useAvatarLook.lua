-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:20:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local MomentsGetOutfitLookStore = require(MomentsParent.DataHydration.MomentsGetOutfitLookStore)
local useSignalState = SignalsReact.useSignalState
local createComputed = Signals.createComputed

local tbl1 = {
    data = createComputed(function()
        return nil
    end),
    status = createComputed(function(): string
        return "NotReady"
    end)
}

local function useAvatarLook(num1: number?)
    local bool1 = not (num1 == nil) and num1 > 0
    local var1 = if bool1 then MomentsGetOutfitLookStore(false).getAndFetchLookByOutfit(num1) else tbl1
    local var2 = useSignalState(var1.data)
    local var3 = useSignalState(var1.status)
    local look = if var2 == nil then nil else var2.look
    local status = bool1 and var3 ~= "Failed" and (var3 ~= "Ready" or look ~= nil) and (if look == nil then "Loading" else "Ready")
        or "Unavailable"

    local tbl2 = { status = status, look = 0 }
    if status ~= "Ready" then
        look = nil
    end

    tbl2.look = look
    return tbl2
end

return useAvatarLook
