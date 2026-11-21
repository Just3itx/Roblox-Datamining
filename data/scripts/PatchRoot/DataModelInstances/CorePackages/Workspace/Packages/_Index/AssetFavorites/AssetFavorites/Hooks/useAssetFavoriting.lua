-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AssetFavorites = script:FindFirstAncestor("AssetFavorites")

local Cryo = require(AssetFavorites.Parent.Cryo)
local React = require(AssetFavorites.Parent.React)
local StatusCodes = require(AssetFavorites.Parent.Http).StatusCodes
local HttpRequest = require(AssetFavorites.Parent.HttpRequest)

local FFlagLuaAppDefaultHttpRetry = require(AssetFavorites.Parent.SharedFlags).FFlagLuaAppDefaultHttpRetry
local useLocalUserId = require(AssetFavorites.Hooks.useLocalUserId)
local GetFavoriteForAsset = require(AssetFavorites.Requests.GetFavoriteForAsset)
local PostFavoriteForAsset = require(AssetFavorites.Requests.PostFavoriteForAsset)
local DeleteFavoriteForAsset = require(AssetFavorites.Requests.DeleteFavoriteForAsset)
local _LuauPolyfill = require(AssetFavorites.Parent.LuauPolyfill)
local Promise = require(AssetFavorites.Parent.Promise)
local logger = require(AssetFavorites.logger)

local useCallback = React.useCallback
local useEffect = React.useEffect
local useState = React.useState
local useRef = React.useRef
local useMemo = React.useMemo

local var1 = HttpRequest.config({
    requestFunction = HttpRequest.requestFunctions.RequestInternal,
    maxRetryCount = if FFlagLuaAppDefaultHttpRetry then game:DefineFastInt("UseAssetFavoritingHttpRetryCount", 4) else nil
})

local function useAssetFavoriting(tbl1)
    local var2 = useLocalUserId()
    local var3, var4 = useState({})
    local var5 = useRef({})

    local var6 = useCallback(function(num1: number?): boolean
        if not num1 then
            return false
        end

        if num1 <= 0 or num1 % 1 ~= 0 then
            logger:warning(`validation failed (assetId must be a positive int, got {num1})`)
            return false
        end

        if var2 and not (var2 <= 0) then
            return true
        end

        logger:warning(`validation failed (userId must be a positive int, got {var2})`)
        return false
    end, { var2 })

    local getAll = useCallback(function()
        return var3
    end, { var3 })

    local getByAssetId = useCallback(function(num1: number)
        local var8 = var3[tostring(num1)]
        return not (var8 == nil) and var8
    end, { var3 })

    local var9 = useCallback(function(num1: number): boolean
        return var3[tostring(num1)] ~= nil
    end, { var3 })

    local isLoading = useCallback(function(num1: number): boolean
        return var5.current[tostring(num1)] ~= nil
    end, {})

    local var11 = useCallback(function(num1: number, bool1: boolean)
        var4(function(arg1)
            local var11 = table.clone(arg1)
            var11[tostring(num1)] = bool1
            return var11
        end)
    end, {})

    local toggleFavorite = useCallback(function(num1: number)
        if not var6(num1) then
            return Promise.resolve(nil)
        end

        local var12 = getByAssetId(num1)

        var11(num1, not var12)
        local var13 = if var12 then DeleteFavoriteForAsset(var1, tostring(var2), tostring(num1)) else PostFavoriteForAsset(var1, tostring(var2), tostring(num1))

        return var13:catch(function(arg1)
            var11(num1, var12)
            logger:warning(arg1.StatusMessage)
        end):andThenReturn(not var12)
    end, { var2, var6, getByAssetId })

    local var13 = useMemo(function()
        return Cryo.List.filter(tbl1, function(num1: number)
            return var6(num1) and not (var9(num1) or isLoading(num1))
        end)
    end, Cryo.List.join(tbl1, { var9, isLoading, var6 }))

    useEffect(function()
        for _, value in var13 do
            local str1 = tostring(value)

            var5.current[str1] = true
            var11(value, false)
            logger:debug(`fetching initial favorite status for asset {value}`)

            GetFavoriteForAsset(var1, tostring(var2), str1):andThen(function(arg1)
                if arg1.responseCode == StatusCodes.OK and arg1.responseBody then
                    var11(value, true)
                end
            end):catch(function(arg1)
                logger:warning(arg1.StatusMessage)
            end):finally(function()
                var5.current[str1] = nil
            end)
        end
    end, { var13, var2 })

    return {
        getAll = getAll,
        getByAssetId = getByAssetId,
        toggleFavorite = toggleFavorite,
        isLoading = isLoading
    }
end

return useAssetFavoriting
