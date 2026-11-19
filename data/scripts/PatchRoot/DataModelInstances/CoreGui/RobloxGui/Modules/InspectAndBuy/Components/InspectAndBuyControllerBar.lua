-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local Roact = require(CorePackages.Packages.Roact)
local UIBlox = require(CorePackages.Packages.UIBlox)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)
local ControllerBar = UIBlox.App.Bar.ControllerBar
local ControllerShortcutKeycodes = require(script.Parent.Common.ControllerShortcutKeycodes)
local Favorite = ControllerShortcutKeycodes.Favorite
local TryOn = ControllerShortcutKeycodes.TryOn

local t = require(CorePackages.Packages.t)

local var1 = Roact.PureComponent:extend("InspectAndBuyControllerBar")

var1.validateProps = t.strictInterface({ showTryOn = t.boolean, showFavorite = t.boolean, isFavorited = t.boolean })

function var1.render(arg1)
    local rightHints = {{
        text = RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.Confirm"),
        keyCode = Enum.KeyCode.ButtonA
    }}

    if arg1.props.showTryOn then
        table.insert(rightHints, 1, {
            text = arg1.props.tryingOn and RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.TakeOff")
                or RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.TryOn"),
            keyCode = TryOn
        })
    end

    if arg1.props.showFavorite then
        table.insert(rightHints, 1, {
            text = arg1.props.isFavorited and RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.Unfavorite")
                or RobloxTranslator:FormatByKey("InGame.InspectMenu.Action.Favorite"),
            keyCode = Favorite
        })
    end

    return Roact.createElement(Roact.Portal, { target = CoreGui }, {
        InspectAndBuyControllerBar = Roact.createElement(
            "ScreenGui",
            {
                DisplayOrder = 1,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            },
            {
                ControllerBar = Roact.createElement(ControllerBar, {
                    leftHint = {
                        text = RobloxTranslator:FormatByKey("CoreScripts.TopBar.Back"),
                        keyCode = Enum.KeyCode.ButtonB
                    },
                    rightHints = rightHints
                })
            }
        )
    })
end
return var1
