-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local t = require(CorePackages.Packages.t)

local renderWithCoreScriptsStyleProvider = require(RobloxGui.Modules.Common.renderWithCoreScriptsStyleProvider)

local scriptParentParent = script.Parent.Parent
local SetScreenSize = require(scriptParentParent.Actions.SetScreenSize)
local ReportMenu = require(scriptParentParent.Components.ReportMenu)
local ReportDialog = require(scriptParentParent.Components.ReportDialog)
local ReportCategoryDialog = require(scriptParentParent.Components.ReportCategoryDialog)

local ReportSentDialog = require(scriptParentParent.Components.ReportSentDialog)
local Toast = require(scriptParentParent.Components.Toast)
local VoiceStateContext = require(RobloxGui.Modules.VoiceChat.VoiceStateContext)

local var1 = Roact.PureComponent:extend("TrustAndSafetyApp")

var1.validateProps = t.strictInterface({ setScreenSize = t.callback })

function var1.init(_) end

function var1.render(arg1)
    local createElement = Roact.createElement
    local provider = VoiceStateContext.Provider
    local tbl1 = {
        Gui = Roact.createElement("ScreenGui", {
            AutoLocalize = false,
            DisplayOrder = 8,
            IgnoreGuiInset = true,
            OnTopOfCoreBlur = true,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
            [Roact.Change.AbsoluteSize] = arg1.props.setScreenSize
        }, {
            Content = Roact.createElement("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0)
            }, {
                ReportCategoryDialog = Roact.createElement(ReportCategoryDialog),
                ReportMenu = Roact.createElement(ReportMenu),
                ReportDialog = Roact.createElement(ReportDialog),
                ReportSentDialog = Roact.createElement(ReportSentDialog),
                Toast = Roact.createElement(Toast)
            })
        })
    }
    local voiceStateContextProvider = createElement(provider, {}, tbl1)

    return renderWithCoreScriptsStyleProvider({ VoiceStateContextProvider = voiceStateContextProvider })
end

return RoactRodux.UNSTABLE_connect2(nil, function(callback)
    return {
        setScreenSize = function(arg1)
            callback(SetScreenSize(arg1.AbsoluteSize))
        end
    }
end)(var1)
