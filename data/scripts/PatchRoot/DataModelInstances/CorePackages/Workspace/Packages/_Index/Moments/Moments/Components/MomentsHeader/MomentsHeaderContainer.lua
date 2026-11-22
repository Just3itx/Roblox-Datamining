-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local ImmersiveHeaderChrome = require(script.Parent.ImmersiveHeaderChrome)
local MomentsHeaderView = require(script.Parent.MomentsHeaderView)
local useMomentsHeaderViewModel = require(script.Parent.useMomentsHeaderViewModel)

local function MomentsHeaderContainer(arg1)
    local bool1 = arg1.animateWithImmersiveChrome == true
    local bool2 = arg1.showHamburger ~= false
    local var1 = useMomentsHeaderViewModel(arg1, bool1, bool2)

    local children = React.createElement(MomentsHeaderView, var1)

    if bool1 then
        return React.createElement(ImmersiveHeaderChrome, { layoutOrder = arg1.layoutOrder, children = children })
    end

    return children
end

return MomentsHeaderContainer
