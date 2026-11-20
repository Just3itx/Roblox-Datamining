-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local ReactUtils = require(FoundationParent.ReactUtils)

local Components = Foundation.Components
local _Types = require(Components.Types)

local getTextBoundsAsync = require(Foundation.Utility.getTextBoundsAsync)
local normalizeFontFace = require(Foundation.Utility.normalizeFontFace)
local usePreferences = require(Foundation.Providers.Preferences.usePreferences)

local function useTextSize(str1: string?, arg1, vector2: Vector2?)
    local preferredTextSize = usePreferences().preferredTextSize
    local var1 = normalizeFontFace(arg1.Font)
    local fontSize = arg1.FontSize

    local var2 = ReactUtils.useAsync(function()
        if str1 == nil or fontSize == nil or typeof(var1) ~= "Font" then
            return nil
        end

        return getTextBoundsAsync(str1, var1, fontSize, if vector2 then vector2.X else nil)
    end, {
        str1,
        arg1.Font,
        fontSize,
        vector2,
        preferredTextSize
    })

    local var3 = React.useRef(nil)
    React.useEffect(function()
        if var2.status == "ok" then
            var3.current = var2.value
        end
    end, { var2 })

    return if var2.status == "ok" then var2.value else var3.current
end

return useTextSize
