-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local t = require(scriptParentParentParentParent.t)
local Roact = require(scriptParentParentParentParent.Roact)

local var1 = Roact.Component:extend("OnRootedListener")
var1.validateProps = t.strictInterface({ onRooted = t.callback })

function var1.init(arg1)
    function arg1.onAncestryChanged(arg2)
        if arg2:IsDescendantOf(game) then
            arg1.props.onRooted(arg2)
        end
    end
end

function var1.render(arg1)
    return Roact.createElement("Folder", { [Roact.Event.AncestryChanged] = arg1.onAncestryChanged })
end

return var1
