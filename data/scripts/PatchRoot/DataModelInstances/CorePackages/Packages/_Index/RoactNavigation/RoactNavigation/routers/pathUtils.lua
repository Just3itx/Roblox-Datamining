-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local LuauPolyfill = require(scriptParentParentParent.LuauPolyfill)
local Array = LuauPolyfill.Array
local Object = LuauPolyfill.Object
local String = LuauPolyfill.String
local RegExp = require(scriptParentParentParent.RegExp)
local invariant = require(scriptParentParent.utils.invariant)
local NavigationActions = require(scriptParentParent.NavigationActions)
local pathToRegexp = require(scriptParent.pathToRegexp)
local compile = pathToRegexp.compile
local pathToRegexp2 = pathToRegexp.pathToRegexp
local queryString = require(scriptParent.queryString)
local ChildIsScreenRouterSymbolRoblox = require(scriptParent:FindFirstChild("ChildIsScreenRouterSymbol.roblox"))
local NullPathSymbolRoblox = require(scriptParent:FindFirstChild("NullPathSymbol.roblox"))

local decodeURIComponent = require(scriptParent.decodeURIComponent)

local module = {}

function module.getParamsFromPath(arg1, arg2, arg3)
    return (Array.reduce(Array.slice(arg2, 2), function(arg4, arg5, arg6)
        local var1 = arg3[arg6]

        if not var1 or var1.pattern == ".*" then
            return arg4
        end
        local name = var1.name

        local var2 = nil
        if arg5 then
            local success, result = pcall(decodeURIComponent, arg5)
            if success then
                var2 = result
            end
        end

        arg4[name] = var2 or arg5
        return arg4
    end, table.clone(arg1)))
end

local function getRestOfPath(arg1, extendedPathReKeys) -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1[Array.findIndex(extendedPathReKeys, function(arg2): boolean
        return arg2.pattern == ".*"
    end) + 1]
end

local function determineDelimiter(arg1, arg2)
    if not Array.isArray(arg2) then
        return arg2
    end

    if #arg2 == 1 then
        return arg2[1]
    end
    for _, value in arg2 do
        if String.startsWith(arg1, value) then
            return value
        end
    end
    return nil
end

function module.urlToPathAndParams(arg1, arg2)
    local var1 = RegExp("^(.*)\\?(.*)$"):exec(arg1)
    if var1 then
        arg1 = var1[2]
    end

    local var2 = not var1 and {} or var1[3]
    local params = queryString.parse(var2)
    local var4 = determineDelimiter(arg1, arg2)
    local str1 = string.split(arg1, if var4 == nil or var4 == "" then "://" else var4)[2]

    if str1 == nil then
        str1 = arg1
    end

    local var5 = if str1 == "/" then "" else str1

    if string.sub(var5, -1, -1) == "/" then
        var5 = string.sub(var5, 1, -2)
    end

    return { path = var5, params = params }
end

function module.createPathParser(arg1, arg2, arg3)
    local var1 = arg3.paths or {}
    local disableRouteNamePaths = arg3.disableRouteNamePaths
    local tbl1 = ({})

    for value in arg1 do
        local path = nil

        if var1[value] ~= nil then
            path = var1[value]
        elseif type(arg2[value]) == "table" then
            path = arg2[value].path
        end

        if path == nil then
            if disableRouteNamePaths then
                path = NullPathSymbolRoblox
            else
                path = value
            end
        end

        invariant(
            path == NullPathSymbolRoblox or type(path) == "string",
            "Route path for %s must be specified as a string, or RoactNavigation.NoPath.",
            value
        )

        local bool1 = path ~= NullPathSymbolRoblox

        local exactReKeys = {}
        local exactRe = if bool1 then pathToRegexp2(path, exactReKeys) else nil
        local extendedPathReKeys = {}
        local isWildcard = path == "" or not bool1

        local tbl4 = {
            exactRe = exactRe,
            exactReKeys = exactReKeys,
            extendedPathRe = pathToRegexp2(if isWildcard then "(.*)" else ("%s/(.*)"):format(path), extendedPathReKeys),
            extendedPathReKeys = extendedPathReKeys,
            isWildcard = isWildcard,
            toPath = path == NullPathSymbolRoblox and function(): string
                return ""
            end or compile(path)
        }

        tbl1[value] = tbl4
    end

    local var2 = Object.entries(tbl1)

    return {
        getActionForPathAndParams = function(arg4, arg5)
            arg4 = if arg4 == nil then "" else arg4

            arg5 = arg5 == nil and {} or arg5

            for _, value in var2 do
                local routeName = value[1]
                local var4 = value[2]
                local exactRe = var4.exactRe
                local exactReKeys = var4.exactReKeys
                local extendedPathRe = var4.extendedPathRe
                local extendedPathReKeys = var4.extendedPathReKeys
                local var5 = arg1[routeName]

                local var6 = exactRe and exactRe:exec(arg4)

                if not var6 or var6.n == 0 then
                    continue
                end

                local var7 = extendedPathRe and extendedPathRe:exec(arg4)
                local actionForPathAndParams

                if var7 and var5 then
                    local restOfPath = getRestOfPath(var7, extendedPathReKeys)

                    actionForPathAndParams = var5.getActionForPathAndParams(restOfPath, arg5)
                else
                    actionForPathAndParams = nil
                end

                return NavigationActions.navigate(
                    {
                        routeName = routeName,
                        params = module.getParamsFromPath(arg5, var6, exactReKeys),
                        action = actionForPathAndParams
                    }
                )
            end

            for _, value in var2 do
                local routeName = value[1]
                local var4 = value[2]
                local extendedPathRe = var4.extendedPathRe
                local extendedPathReKeys = var4.extendedPathReKeys
                local var5 = arg1[routeName]
                local var6 = extendedPathRe and extendedPathRe:exec(arg4)

                if not var6 or var6.n == 0 then
                    continue
                end

                local restOfPath = getRestOfPath(var6, extendedPathReKeys)
                local action = if var5 then var5.getActionForPathAndParams(restOfPath, arg5) else nil

                if not action then
                    continue
                end

                return NavigationActions.navigate(
                    {
                        routeName = routeName,
                        params = module.getParamsFromPath(arg5, var6, extendedPathReKeys),
                        action = action
                    }
                )
            end

            return nil
        end,
        getPathAndParamsForRoute = function(arg4)
            local routeName = arg4.routeName
            local params = arg4.params
            local var3 = arg1[routeName]
            local var4 = tbl1[routeName]
            local toPath = var4.toPath
            local exactReKeys = var4.exactReKeys
            local path = toPath(params)
            local tbl2 = ({})
            if params then
                for _, value in (Array.filter(Object.keys(params), function(name): boolean
                    return not Array.find(exactReKeys, function(arg5): boolean
                        return arg5.name == name
                    end)
                end)) do
                    tbl2[value] = params[value]
                end
            end

            if not var3 or var3 == ChildIsScreenRouterSymbolRoblox then
                return { path = path, params = tbl2 }
            end

            local pathAndParamsForState = var3.getPathAndParamsForState(arg4)
            local tbl3 = {
                path = if path and path ~= "" then ("%s/%s"):format(path, pathAndParamsForState.path) else pathAndParamsForState.path,
                params = 0
            }

            if pathAndParamsForState.params then
                tbl2 = Object.assign(tbl2, pathAndParamsForState.params)
            end

            tbl3.params = tbl2
            return tbl3
        end
    }
end
return module
