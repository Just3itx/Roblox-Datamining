-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:40:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)

local _ElevationLayer = require(Foundation.Enums.ElevationLayer)

local ElevationProvider = require(script.Parent.ElevationProvider)
local _elevation = require(script.Parent.elevation)

local useElevationManager = ElevationProvider.useElevationManager
local useOwnerToken = ElevationProvider.useOwnerToken

local function useElevation(layer, tbl1)
    local var1 = useElevationManager()
    local owner = useOwnerToken()

    local var3 = React.useMemo(function()
        local reserve = not (owner == nil) and owner.layer == layer

        if not tbl1.stackAboveOwner then
            return var1.acquire(layer, { reserve = reserve })
        end

        if not owner then
            return var1.acquire(layer, { reserve = false })
        end

        if reserve then
            return var1.acquire(layer, { reserve = true, owner = owner })
        end

        local zIndex = owner.zIndex + 1

        return { layer = layer, index = -1, zIndex = zIndex }
    end, {
        layer,
        owner,
        var1,
        tbl1.stackAboveOwner
    })

    React.useEffect(function()
        return function()
            if var3.index ~= nil and var3.index >= 0 then
                var1.releaseIfTop(layer, var3.index)
            end
        end
    end, { layer, var3.index })

    return var3
end

return useElevation
