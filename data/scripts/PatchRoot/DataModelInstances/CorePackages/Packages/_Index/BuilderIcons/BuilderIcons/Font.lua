-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:51:28Z
-- Luau bytecode version: 9 | Luau type version: 3
local scriptParent = script.Parent
local family = `rbxassetid://{require(scriptParent.BuilderIconsFallback)}`

return {
    Regular = Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json", Enum.FontWeight.Regular),
    Filled = Font.new("rbxasset://LuaPackages/Packages/_Index/BuilderIcons/BuilderIcons/BuilderIcons.json", Enum.FontWeight.Bold),
    Fallback = {
        Regular = Font.new(family, Enum.FontWeight.Regular),
        Filled = Font.new(family, Enum.FontWeight.Bold)
    }
}
