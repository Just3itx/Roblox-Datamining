-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local React = require(MomentsParent.React)

local _createMomentsStore = require(script.Parent.createMomentsStore)
local Parent = require(script.Parent)

local MomentsSessionContext = React.createContext(nil)

return {
    MomentsSessionContext = MomentsSessionContext,
    useMomentsSession = function()
        local var1 = React.useContext(MomentsSessionContext)
        if var1 == nil then
            return Parent()
        end
        return var1
    end
}
