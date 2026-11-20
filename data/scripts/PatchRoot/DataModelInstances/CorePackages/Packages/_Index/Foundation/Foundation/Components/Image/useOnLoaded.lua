-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)
local ReactIs = require(FoundationParent.ReactIs)

local ContentProvider = require(Foundation.Utility.Wrappers).Services.ContentProvider

local _Types = require(Foundation.Components.Types)

local function isFinalAssetFetchStatus(assetFetchStatus): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return assetFetchStatus == Enum.AssetFetchStatus.Success
        or assetFetchStatus == Enum.AssetFetchStatus.Failure
        or assetFetchStatus == Enum.AssetFetchStatus.TimedOut
end

local function attachOnLoaded(str1: string?, callback: (...any) -> (...any))
    if str1 == nil then
        return
    end

    local assetFetchStatus = ContentProvider:GetAssetFetchStatus(str1)

    if isFinalAssetFetchStatus(assetFetchStatus) then
        callback(assetFetchStatus)
        return
    end

    return ContentProvider:GetAssetFetchStatusChangedSignal(str1):Connect(function(assetFetchStatus2)
        if isFinalAssetFetchStatus(assetFetchStatus2) then
            callback(assetFetchStatus2)
        end
    end)
end

local function useOnLoaded<T>(arg1: T, callback: ((...any) -> (...any))?)
    React.useEffect(function()
        if not callback then
            return
        end

        local var1 = nil
        local function disconnectConnection() -- Luacid: Inlined by compiler; 4 call sites recovered
            if var1 then
                var1:Disconnect()
                var1 = nil
            end
        end

        local function handleFinalStatus(arg2)
            disconnectConnection()
            callback(arg2)
        end

        if not ReactIs.isBinding(arg1) then
            var1 = attachOnLoaded(arg1, handleFinalStatus)

            return function()
                disconnectConnection()
            end
        end

        local var2 = arg1
        var1 = attachOnLoaded(var2:getValue(), handleFinalStatus)

        local var3 = React.__subscribeToBinding(var2, function(str1: string)
            disconnectConnection()
            var1 = attachOnLoaded(str1, handleFinalStatus)
        end)

        return function()
            var3()
            disconnectConnection()
        end
    end, { arg1, callback })
end

return useOnLoaded
