-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local ColorMode = require(Foundation.Enums.ColorMode)
local RbxDesignFoundations = require(FoundationParent.RbxDesignFoundations)
local ThemeName = require(Foundation.Enums.ThemeName)

return {
    getGenerator = function(arg1, light)
        local themes = RbxDesignFoundations.themes

        local var1 = (themes[arg1] or themes[ThemeName.Default])()
        return if light == ColorMode.Light then var1.Light else var1.Dark
    end
}
