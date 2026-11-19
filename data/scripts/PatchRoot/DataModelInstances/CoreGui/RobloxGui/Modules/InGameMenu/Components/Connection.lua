-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t

local FriendStatusConnector = require(script.FriendStatusConnector)
local LastInputTypeConnector = require(script.LastInputTypeConnector)
local MouseOverrideManager = require(script.MouseOverrideManager)
local FocusHighlightManager = require(script.FocusHighlightManager)
local NativeCloseEventConnector = require(script.NativeCloseEventConnector)

local scriptParentParent = script.Parent.Parent
local InGameMenuPolicy = require(scriptParentParent.InGameMenuPolicy)

local var1 = t.strictInterface({ isEducationalPopupEnabled = t.optional(t.boolean) })

return InGameMenuPolicy.connect(function(arg1, _)
    return {
        isEducationalPopupEnabled = arg1.enableEducationalPopup()
    }
end)(function(arg1) -- name: Connection
    assert(var1)
    return Roact.createFragment({
        FriendStatusConnector = Roact.createElement(FriendStatusConnector),
        LastInputTypeConnector = Roact.createElement(LastInputTypeConnector),
        MouseOverrideManager = Roact.createElement(MouseOverrideManager),
        FocusHighlightManager = Roact.createElement(FocusHighlightManager),
        NativeCloseEventConnector = arg1.isEducationalPopupEnabled and Roact.createElement(NativeCloseEventConnector) or nil
    })
end)
