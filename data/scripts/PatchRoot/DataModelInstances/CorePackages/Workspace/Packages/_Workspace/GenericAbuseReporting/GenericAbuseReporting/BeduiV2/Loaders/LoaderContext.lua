-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReportingParent = script:FindFirstAncestor("GenericAbuseReporting").Parent

local React = require(GenericAbuseReportingParent.React)

local LoaderContext = React.createContext(nil)

return {
    LoaderContext = LoaderContext,
    LoaderProvider = function(tbl1)
        local cacheRef = React.useRef({})
        local registryRef = React.useRef(tbl1.loaders)
        registryRef.current = tbl1.loaders

        React.useEffect(function()
            if not tbl1.open then
                cacheRef.current = {}
            end
        end, { tbl1.open })

        local current = React.useRef({ registryRef = registryRef, cacheRef = cacheRef }).current
        return React.createElement(LoaderContext.Provider, { value = current }, tbl1.children)
    end,
    useLoaderContext = function()
        local var1 = React.useContext(LoaderContext)
        if not var1 then
            error("useLoaderContext must be used within a <LoaderProvider>")
        end
        return var1
    end
}
