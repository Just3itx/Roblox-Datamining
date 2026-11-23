-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserTile = script:FindFirstAncestor("UserTile")
local UserTileParent = UserTile.Parent

local React = require(UserTileParent.React)
local _Foundation = require(UserTileParent.Foundation)
local Cryo = require(UserTileParent.Cryo)

local DataHydration = require(UserTileParent.DataHydration)
local useSignalState = require(UserTileParent.SignalsReact).useSignalState
local Signals = require(UserTileParent.Signals)

local UserTile2 = require(UserTile.Components.UserTile)
local _LayoutMode = require(script.Parent.Parent.Enums.LayoutMode)

local var1 = DataHydration.TrustedConnections.TrustedConnectionsStore.get()

local function UserTileContainer(tbl1)
    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if tbl1.userId and tbl1.userId ~= "" then
                return (var1.getIsTrustedConnection(tbl1.userId).data(arg1))
            end

            return nil
        end)
    end, { tbl1.userId })

    local isTrustedConnection = useSignalState(var2)

    local var4 = React.useMemo(function()
        return Cryo.Dictionary.join(tbl1 or {}, { isTrustedConnection = isTrustedConnection })
    end, { tbl1, isTrustedConnection })

    return React.createElement(UserTile2, var4)
end

return UserTileContainer
