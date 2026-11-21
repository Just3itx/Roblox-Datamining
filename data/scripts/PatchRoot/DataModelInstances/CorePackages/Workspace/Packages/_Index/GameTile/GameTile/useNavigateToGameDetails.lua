-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:31:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameTile = script:FindFirstAncestor("GameTile")
local GameTileParent = GameTile.Parent
local React = require(GameTileParent.React)
local OpenGameDetails = require(GameTileParent.GameDetail).OpenGameDetails
local useDispatch = require(GameTileParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useNavigation = require(GameTileParent.Navigation).useNavigation
local useRoactService = require(GameTileParent.RobloxAppHooks).useRoactService
local RoactNetworking = require(GameTileParent.RoactServiceTags).RoactNetworking
local FFlagLuaAppSduiEdpEnabled = require(GameTileParent.SharedFlags).FFlagLuaAppSduiEdpEnabled
local FFlagLuaAppStableNavigateToGameDetails = require(GameTile.Flags.FFlagLuaAppStableNavigateToGameDetails)

local function useNavigateToGameDetails()
    local var1 = useDispatch()
    local current = useNavigation()
    local var3 = if FFlagLuaAppSduiEdpEnabled then useRoactService(RoactNetworking) else nil

    if not FFlagLuaAppStableNavigateToGameDetails then
        local useCallback = React.useCallback
        local function func1(str1: string, tbl1)
            var1(OpenGameDetails(str1, current, tbl1, if FFlagLuaAppSduiEdpEnabled then var3 else nil))
        end

        local var4 = if FFlagLuaAppSduiEdpEnabled then var3 else nil
        return (useCallback(func1, { var1, current, var4 }))
    end

    local var4 = React.useRef(current)
    var4.current = current
    local useCallback = React.useCallback
    local function func1(str1: string, tbl1)
        var1(OpenGameDetails(str1, var4.current, tbl1, if FFlagLuaAppSduiEdpEnabled then var3 else nil))
    end

    local var5 = if FFlagLuaAppSduiEdpEnabled then var3 else nil
    return useCallback(func1, { var1, var5 })
end

return useNavigateToGameDetails
