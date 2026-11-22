-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ThemeBackground = script:FindFirstAncestor("ThemeBackground")
local ThemeBackgroundParent = ThemeBackground.Parent

local Signals = require(ThemeBackgroundParent.Signals)

local _ThemeBackgroundTypes = require(ThemeBackground.ThemeBackgroundTypes)

local var1 = table.freeze({ position = Vector2.zero, size = Vector2.zero })

local function createThemeBackgroundStore()
    local getThemeBackground, var3 = Signals.createSignal(nil)
    local getGeometry, var5 = Signals.createSignal(var1)

    return {
        getThemeBackground = getThemeBackground,
        getGeometry = getGeometry,
        setThemeBackground = function(arg1)
            var3(arg1)
        end,
        setGeometry = function(arg1)
            var5(arg1)
        end,
        reset = function()
            var3(nil)
            var5(var1)
        end
    }
end
return createThemeBackgroundStore
