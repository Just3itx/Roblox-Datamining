-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:20:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local CorePackages = game:GetService("CorePackages")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local RoactRodux = InGameMenuDependencies.RoactRodux
local t = InGameMenuDependencies.t

local scriptParentParentParent = script.Parent.Parent.Parent
local OpenEducationalPopup = require(scriptParentParentParent.Thunks.OpenEducationalPopup)
local ExternalEventConnection = require(scriptParentParentParent.Utility.ExternalEventConnection)
local InGameMenuPolicy = require(scriptParentParentParent.InGameMenuPolicy)
local UserLocalStore = require(scriptParentParentParent.Utility.UserLocalStore)
local SendAnalytics = require(scriptParentParentParent.Utility.SendAnalytics)
local Constants = require(scriptParentParentParent.Resources.Constants)

local var1 = Roact.PureComponent:extend("NativeCloseEventConnector")

var1.validateProps = t.strictInterface(
    {
        isEducationalPopupEnabled = t.boolean,
        maxDisplayCount = t.integer,
        openEducationalPopup = t.optional(t.callback)
    }
)
function var1.init(arg1)
    function arg1.onNativeCloseConnect()
        if arg1.props.isEducationalPopupEnabled then
            RbxAnalyticsService:ReportCounter("LeaveGame_NativeClose", 1)

            local userLocalStore = UserLocalStore.new()
            arg1.props.openEducationalPopup(GuiService, userLocalStore, arg1.props.maxDisplayCount)
        end

        SendAnalytics(Constants.AnalyticsInGameMenuName, "LeaveGame_NativeClose", {})
    end
end

function var1.render(arg1)
    return Roact.createElement(ExternalEventConnection, { event = GuiService.NativeClose, callback = arg1.onNativeCloseConnect })
end

local var2 = InGameMenuPolicy.connect(function(arg1, _)
    return {
        isEducationalPopupEnabled = arg1.enableEducationalPopup(),
        maxDisplayCount = arg1.educationalPopupMaxDisplayCount()
    }
end)(var1)

return RoactRodux.UNSTABLE_connect2(nil, function(arg1)
    return {
        openEducationalPopup = function(arg2, arg3, arg4)
            return arg1(OpenEducationalPopup(arg2, arg3, arg4))
        end
    }
end)(var2)
