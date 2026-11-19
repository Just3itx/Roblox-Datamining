-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:30:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent
local React = require(FoundationParent.React)
local ReactUtils = require(FoundationParent.ReactUtils)

local Components = Foundation.Components
local _Types = require(Components.Types)

local Flags = require(Foundation.Utility.Flags)
local getTextBoundsAsync = require(Foundation.Utility.getTextBoundsAsync)
local normalizeFontFace = require(Foundation.Utility.normalizeFontFace)
local usePreferences = require(Foundation.Providers.Preferences.usePreferences)

local TextService = require(Foundation.Utility.Wrappers.Services).TextService

local function useTextSize(str1: string?, arg1, vector2: Vector2?)
    if not Flags.FoundationFontFaceMigration then
        local var1, var2 = React.useState(nil)
        local preferredTextSize = usePreferences().preferredTextSize

        React.useEffect(function()
            if str1 == nil then
                var2(nil)
                return
            end

            local var3 = var2
            local var4 = TextService
            local str2 = str1
            local fontSize = arg1.FontSize
            local font = arg1.Font
            local var5 = vector2 or Vector2.new(math.huge, math.huge)
            var3(var4:GetTextSize(str2, fontSize, font, var5))
        end, {
            str1,
            arg1,
            vector2,
            preferredTextSize
        })
        return var1
    end

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
