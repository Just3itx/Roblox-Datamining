-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)

local Context = React.createContext(nil)

return {
    Provider = function(tbl1) -- name: MediaPreloadProvider
        return React.createElement(Context.Provider, { value = tbl1.controllerProvider }, tbl1.children)
    end,
    Context = Context,
    useMediaControllerProvider = function()
        return React.useContext(Context)
    end
}
