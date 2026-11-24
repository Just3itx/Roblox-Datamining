-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local LoaderContext = require(script.Parent.LoaderContext)

local function isLoadDescriptor(arg1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return typeof(arg1) == "table" and arg1["$load"] ~= nil
end

local function cacheKey(str1: string, tbl1): string
    if not tbl1 then
        return str1 .. "::{}"
    end
    local tbl2 = {}
    for k in pairs(tbl1) do
        table.insert(tbl2, k)
    end
    table.sort(tbl2)
    local tbl3 = {}
    for _, value in ipairs(tbl2) do
        table.insert(tbl3, value .. "=" .. tbl1[value])
    end
    return str1 .. "::" .. table.concat(tbl3, ",")
end

local function useLoader(arg1)
    local var1 = LoaderContext.useLoaderContext()
    local registryRef = var1.registryRef
    local cacheRef = var1.cacheRef
    local bool1 = isLoadDescriptor(arg1)
    local load = if bool1 then arg1["$load"] else nil
    local params = if bool1 then arg1.params else nil
    local var2, var3 = React.useState(bool1 and { data = nil, loading = true, error = nil } or { data = arg1, loading = false, error = nil })

    local var4, var5 = React.useState(0)

    React.useEffect(function()
        if not bool1 then
            var3({ data = arg1, loading = false, error = nil })
            return
        end

        local var6 = registryRef.current[load]
        if not var6 then
            var3({ data = nil, loading = false, error = string.format("Loader \"%s\" not found in registry", load) })

            return
        end

        local str1 = cacheKey(load, params)
        local var7 = cacheRef.current[str1]
        if var7 then
            var3({ data = var7, loading = false, error = nil })
            return
        end

        local bool2 = false
        var3({ data = nil, loading = true, error = nil })

        var6.fetch(params or {}):andThen(function(arg2)
            if bool2 then
                return
            end
            cacheRef.current[str1] = arg2
            var3({ data = arg2, loading = false, error = nil })
        end):catch(function(arg2)
            if bool2 then
                return
            end
            var3({ data = nil, loading = false, error = tostring(arg2) })
        end)

        return function()
            bool2 = true
        end
    end, {
        params,
        arg1,
        var4,
        bool1
    })
    local retry = React.useCallback(function()
        if not bool1 then
            return
        end
        cacheRef.current[cacheKey(load, params)] = nil
        var5(function(arg2): number
            return arg2 + 1
        end)
    end, { arg1, params, bool1 })

    return {
        data = var2.data,
        loading = var2.loading,
        error = var2.error,
        retry = retry
    }
end

return {
    useLoader = useLoader,
    useListLoader = function(arg1)
        local tbl1 = useLoader(arg1)

        return {
            data = tbl1.data,
            loading = tbl1.loading,
            error = tbl1.error,
            retry = tbl1.retry
        }
    end,
    useGroupedListLoader = function(arg1)
        local tbl1 = useLoader(arg1)

        return {
            data = tbl1.data,
            loading = tbl1.loading,
            error = tbl1.error,
            retry = tbl1.retry
        }
    end
}
