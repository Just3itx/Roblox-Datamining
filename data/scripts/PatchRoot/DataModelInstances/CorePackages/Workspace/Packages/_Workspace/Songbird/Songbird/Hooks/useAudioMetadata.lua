-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local ReactUtils = require(Songbird.Parent.ReactUtils)
local React = require(Songbird.Parent.React)

local _types = require(Songbird.types)
local getAudioMetadataAsync = require(Songbird.Requests.getAudioMetadataAsync)

local useAsync = ReactUtils.useAsync
local useState = React.useState
local useEffect = React.useEffect
local useCallback = React.useCallback

local function useAudioMetadata(tbl1)
    local var1, var2 = useState({})

    local var3 = useAsync(function()
        if #tbl1 > 0 then
            return getAudioMetadataAsync(tbl1)
        end
        return {}
    end, { table.unpack(tbl1) })

    local getAll = useCallback(function()
        return var1
    end, { var1 })

    local getByAssetId = useCallback(function(arg1)
        return var1[tostring(arg1)]
    end, { var1 })

    useEffect(function()
        if var3.status ~= "ok" or not (#var3.value > 0) then
            return
        end

        var2(function(arg1)
            local var6 = table.clone(arg1)
            for _, value in var3.value do
                var6[value.AssetId] = value
            end
            return var6
        end)
    end, { var3 })

    return { getAll = getAll, getByAssetId = getByAssetId }
end

return useAudioMetadata
