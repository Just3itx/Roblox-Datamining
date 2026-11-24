-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local UpdateSelectedCaptures = require(scriptParentParent.Actions.UpdateSelectedCaptures)
local getUpdatedSelectedCapturesArray = require(scriptParentParent.Utils.getUpdatedSelectedCapturesArray)

local Constants = require(scriptParentParent.Constants)
local _Types = require(scriptParentParent.Types)

return function(arg1)
    return function(arg2)
        local selectedCaptures = arg2:getState()[Constants.RoduxKey].CaptureManager.SelectedCaptures
        arg2:dispatch(UpdateSelectedCaptures(getUpdatedSelectedCapturesArray(selectedCaptures, arg1)))
    end
end
