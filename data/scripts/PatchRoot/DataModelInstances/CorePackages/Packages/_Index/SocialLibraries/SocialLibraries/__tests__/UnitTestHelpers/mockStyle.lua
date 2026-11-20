-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local dependencies = require(script.Parent.Parent.Parent.dependencies)
local UIBlox = dependencies.UIBlox
local Roact = dependencies.Roact

return function(testElement)
    return Roact.createElement(
        UIBlox.App.Style.AppStyleProvider,
        {
            style = { themeName = "Dark", fontName = "Gotham" }
        },
        { TestElement = testElement }
    )
end
