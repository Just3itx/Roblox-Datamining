-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParentParent = script.Parent.Parent.Parent.Parent.Parent

local Roact = require(scriptParentParentParentParentParent.Roact)

local LayerCollectorContext = require(script.Parent.LayerCollectorContext)

local function LayerCollectorConsumer(render)
    return Roact.createElement(LayerCollectorContext.Consumer, { render = render })
end

return LayerCollectorConsumer
