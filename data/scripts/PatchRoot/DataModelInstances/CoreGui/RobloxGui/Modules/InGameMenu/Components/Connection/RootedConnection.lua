-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local var1 = Roact.PureComponent:extend("RootedConnection")

var1.validateProps = t.strictInterface({ render = t.callback })

function var1.init(arg1)
    arg1.state = { isRooted = false }

    arg1.rootRef = Roact.createRef()

    function arg1.onAncestryChanged(arg2)
        if arg2:IsDescendantOf(game) then
            arg1:setState({ isRooted = true })
        end
    end
end

function var1.render(arg1)
    local createFragment = Roact.createFragment
    local tbl1 = {
        Content = arg1.props.render(arg1.state.isRooted),
        Folder = Roact.createElement("Folder", { [Roact.Event.AncestryChanged] = arg1.onAncestryChanged, [Roact.Ref] = arg1.rootRef })
    }
    return createFragment(tbl1)
end

function var1.didMount(arg1)
    if arg1.rootRef:getValue():IsDescendantOf(game) then
        arg1:setState({ isRooted = true })
    end
end

return var1
