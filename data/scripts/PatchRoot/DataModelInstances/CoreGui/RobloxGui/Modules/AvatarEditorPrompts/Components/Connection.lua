-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)

local ContextActionsBinder = require(script.ContextActionsBinder)

local var1 = Roact.PureComponent:extend("Connection")

function var1.render(_)
    return Roact.createFragment({ ContextActionsBinder = Roact.createElement(ContextActionsBinder) })
end

return var1
