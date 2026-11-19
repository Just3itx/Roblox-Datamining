-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Rodux = require(CorePackages.Packages.Rodux)
local scriptParentParent = script.Parent.Parent
local OpenOverlay = require(scriptParentParent.Actions.OpenOverlay)
local CloseOverlay = require(scriptParentParent.Actions.CloseOverlay)

local createReducer = Rodux.createReducer
local tbl1 = {}

tbl1[OpenOverlay.name] = function(_, arg1)
    return {
        overlay = arg1.overlay,
        overlayProps = arg1.overlayProps
    }
end

tbl1[CloseOverlay.name] = function(_, _)
    return {
        overlay = nil,
        overlayProps = {}
    }
end

return createReducer({ overlay = nil, overlayProps = {} }, tbl1)
