-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:50:50Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local React = require(FoundationParent.React)

local ColorNamespace = require(Foundation.Enums.ColorNamespace)
local CursorContext = require(script.Parent.CursorContext)
local KeyUtilities = require(script.Parent.KeyUtilities)
local PresentationContext = require(Foundation.Providers.Style.PresentationContext)
local _Types = require(Foundation.Components.Types)
local useTokens = require(Foundation.Providers.Style.useTokens)
local usePresentationContext = PresentationContext.usePresentationContext

local function useCursor(arg1)
    local var1 = useTokens()
    local var2 = usePresentationContext()
    local var3 = if var2.colorNamespace then var2.colorNamespace else ColorNamespace.Color
    local var4 = React.useContext(CursorContext)
    local refCache = var4.refCache
    local setMountedCursors = var4.setMountedCursors

    local var5 = React.useMemo(function()
        if typeof(arg1) == "table" then
            return KeyUtilities.encodeKey(var1, arg1.radius, arg1.offset, arg1.borderWidth, var3)
        elseif arg1 == nil then
            return KeyUtilities.encodeKey(var1, nil, nil, nil, var3)
        end
        return KeyUtilities.encodeCursorTypeKey(arg1, var3)
    end, { arg1, var1, var3 })

    React.useEffect(function()
        setMountedCursors(function(arg2)
            if arg2[var5] == nil then
                return Dash.join(arg2, { [var5] = true })
            end

            return arg2
        end)
    end, { var5 })

    return refCache[var5]
end

return useCursor
