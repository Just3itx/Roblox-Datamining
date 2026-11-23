-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)
local GameGetGameInfoStore = require(AppChatParent.DataHydration.GameGetGameInfoStore)

local DataStatus = require(AppChatParent.DataHydration).DataStatus

local FFlagAppChatMomentShareCardLoadingSkeletons = require(AppChat.Flags.FFlagAppChatMomentShareCardLoadingSkeletons)

local computed = Signals.createComputed(function()
    return nil
end)

local function useExperienceName(num1: number?, bool1: boolean)
    local var1 = if num1 and num1 ~= 0 then tostring(num1) else nil
    local var2 = if bool1 and var1 then GameGetGameInfoStore(false).getAndFetchGameInfo(var1) else nil
    local var3 = SignalsReact.useSignalState(if var2 then var2.data else computed)
    local var4 = if FFlagAppChatMomentShareCardLoadingSkeletons then SignalsReact.useSignalState(if var2 then var2.status else computed) else nil
    return {
        name = if var3 then var3.name else nil,
        isLoading = var4 == DataStatus.NotReady
    }
end

return useExperienceName
