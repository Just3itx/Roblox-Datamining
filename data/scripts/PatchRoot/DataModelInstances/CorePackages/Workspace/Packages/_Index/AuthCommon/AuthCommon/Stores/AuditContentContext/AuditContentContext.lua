-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local React = require(AuthCommonParent.React)

local Cryo = require(AuthCommonParent.Cryo)

local GetFFlagEnableAuditSystem = require(AuthCommon.Flags.GetFFlagEnableAuditSystem)

local useState = React.useState
local useMemo = React.useMemo
local useContext = React.useContext
local useCallback = React.useCallback
local useEffect = React.useEffect

local Context = React.createContext({
    capturedAuditContent = {},
    additionalAuditContent = {},
    setCapturedAuditContentItem = function() end,
    removeCapturedAuditContentItem = function() end,
    setAdditionalAuditContentItem = function() end,
    removeAdditionalAuditContentItem = function() end
})

return {
    Context = Context,
    Provider = function(tbl1) -- name: AuditContentProvider
        local capturedAuditContent, var2 = useState({})
        local additionalAuditContent, var4 = useState({})

        local setCapturedAuditContentItem = useCallback(function(str1: string, tbl2)
            var2(function(arg1)
                return (Cryo.Dictionary.join(arg1, { [str1] = tbl2 }))
            end)
        end, { var2 })

        local removeCapturedAuditContentItem = useCallback(function(str1: string)
            var2(function(arg1)
                return (Cryo.Dictionary.join(arg1, { [str1] = Cryo.None }))
            end)
        end, { var2 })

        local setAdditionalAuditContentItem = useCallback(function(str1: string, str2: string)
            var4(function(arg1)
                return Cryo.Dictionary.join(arg1, { [str1] = str2 })
            end)
        end, { var4 })

        local removeAdditionalAuditContentItem = useCallback(function(str1: string)
            var4(function(arg1)
                return Cryo.Dictionary.join(arg1, { [str1] = Cryo.None })
            end)
        end, { var4 })

        local value = useMemo(function()
            return {
                capturedAuditContent = capturedAuditContent,
                additionalAuditContent = additionalAuditContent,
                setCapturedAuditContentItem = setCapturedAuditContentItem,
                removeCapturedAuditContentItem = removeCapturedAuditContentItem,
                setAdditionalAuditContentItem = setAdditionalAuditContentItem,
                removeAdditionalAuditContentItem = removeAdditionalAuditContentItem
            }
        end, { capturedAuditContent, additionalAuditContent })

        return React.createElement(Context.Provider, { value = value }, tbl1.children)
    end,
    useCapturedAuditContent = function(str1: string?, tbl1)
        local var1 = useContext(Context)

        useEffect(function()
            if GetFFlagEnableAuditSystem() and str1 and tbl1 then
                var1.setCapturedAuditContentItem(str1, tbl1)
            end
        end, { str1, tbl1 })

        useEffect(function()
            return function()
                if not GetFFlagEnableAuditSystem() then
                    return
                end

                if str1 then
                    var1.removeCapturedAuditContentItem(str1)
                end
            end
        end, { str1 })
    end,
    useAdditionalAuditContent = function(str1: string?, str2: string?)
        local var1 = useContext(Context)

        useEffect(function()
            if GetFFlagEnableAuditSystem() and str1 and str2 then
                var1.setAdditionalAuditContentItem(str1, str2)
            end
        end, { str1, str2 })

        useEffect(function()
            return function()
                if not GetFFlagEnableAuditSystem() then
                    return
                end

                if str1 then
                    var1.removeAdditionalAuditContentItem(str1)
                end
            end
        end, { str1 })
    end,
    useAuditContentContext = function()
        local var1 = useContext(Context)

        return {
            capturedAuditContent = var1.capturedAuditContent,
            additionalAuditContent = var1.additionalAuditContent,
            setCapturedAuditContentItem = var1.setCapturedAuditContentItem,
            removeCapturedAuditContentItem = var1.removeCapturedAuditContentItem,
            setAdditionalAuditContentItem = var1.setAdditionalAuditContentItem,
            removeAdditionalAuditContentItem = var1.removeAdditionalAuditContentItem
        }
    end
}
