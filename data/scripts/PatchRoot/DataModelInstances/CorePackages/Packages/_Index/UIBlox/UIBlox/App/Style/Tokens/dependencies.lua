-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParent.Parent.Parent.Parent
local RbxDesignFoundationsV1 = require(scriptParentParentParentParentParent.RbxDesignFoundationsV1)
local Constants = require(scriptParentParent.Constants)

return {
    GetTokenGenerators = function(arg1)
        local var1 = arg1:lower()

        if var1 == Constants.ThemeName.Dark:lower() then
            return RbxDesignFoundationsV1.tokens.Common.Builder.Dark
        end

        if var1 == Constants.ThemeName.Light:lower() then
            return RbxDesignFoundationsV1.tokens.Common.Builder.Light
        end

        return nil
    end,
    GetFoundationTokens = function(arg1)
        local rbxDesignFoundationsV4 = require(scriptParentParentParentParentParent.RbxDesignFoundationsV4)
        local var1 = rbxDesignFoundationsV4.themes[rbxDesignFoundationsV4.Theme.Default]()
        local var2 = arg1:lower()

        if var2 == Constants.ThemeName.Dark:lower() then
            return var1.Dark
        end

        if var2 == Constants.ThemeName.Light:lower() then
            return var1.Light
        end

        return nil
    end
}
