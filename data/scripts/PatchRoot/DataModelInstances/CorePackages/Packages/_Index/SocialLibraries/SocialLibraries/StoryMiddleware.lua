-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:01:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local dependencies = require(script.Parent.dependencies)
local Roact = dependencies.Roact
local AppStyleProvider = dependencies.UIBlox.App.Style.AppStyleProvider
local tbl1 = {
    Default = { themeName = "Light", fontName = "Gotham" },
    Light = { themeName = "Light", fontName = "Gotham" },
    Dark = { themeName = "Dark", fontName = "Gotham" }
}

local function StoryMiddleware(arg1)
    return function(arg2)
        return Roact.createElement(
            AppStyleProvider,
            {
                style = arg2 and tbl1[arg2.theme] or tbl1.Default
            },
            {
                Child = Roact.createElement(arg1, arg2)
            }
        )
    end
end
return StoryMiddleware
