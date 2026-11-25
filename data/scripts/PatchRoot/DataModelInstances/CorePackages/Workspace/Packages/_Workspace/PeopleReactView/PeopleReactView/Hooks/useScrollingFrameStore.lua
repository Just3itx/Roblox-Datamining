-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PeopleReactView = script:FindFirstAncestor("PeopleReactView")
local PeopleReactViewParent = PeopleReactView.Parent

local React = require(PeopleReactViewParent.React)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local GetScrollingFrameStore = require(PeopleReactView.Stores.GetScrollingFrameStore)

local function useScrollingFrameStore(arg1)
    local var1 = SignalsReact.useSignalState(GetScrollingFrameStore)
    local var2 = React.useRef(false)

    if not var2.current and arg1 then
        var1.setScrollingFrame(arg1)
        var2.current = true
    end

    React.useEffect(function()
        return function()
            var1.cleanUp()
        end
    end, { var1 })

    return var1
end

return useScrollingFrameStore
