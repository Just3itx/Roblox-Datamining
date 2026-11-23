-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local DataHydration = require(AppChatParent.DataHydration)
local useSignalState = require(AppChatParent.SignalsReact).useSignalState

local GetShareLinkV2Store = require(AppChat.Stores.GetShareLinkV2Store)
local _ShareLinkV2Presentation = require(script.Parent.ShareLinkV2Presentation)
local getShareLinkV2Presentation = require(script.Parent.getShareLinkV2Presentation)

local signal = Signals.createSignal(nil)
local signal2 = Signals.createSignal(DataHydration.DataStatus.NotReady)

local function useShareLinkV2Presentation(str1: string?)
    local shareLinkV2Store = GetShareLinkV2Store(false)
    local var1 = React.useMemo(function()
        if str1 then
            return (shareLinkV2Store.getAndFetchClassification(str1))
        end

        return nil
    end, { shareLinkV2Store, str1 or "" })
    local var2 = useSignalState(if var1 then var1.data else signal)
    local var3 = useSignalState(if var1 then var1.status else signal2)

    if var1 == nil then
        return nil
    end
    return getShareLinkV2Presentation(var2, var3)
end

return useShareLinkV2Presentation
