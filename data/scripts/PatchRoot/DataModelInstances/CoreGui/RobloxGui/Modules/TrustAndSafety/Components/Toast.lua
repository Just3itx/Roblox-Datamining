-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:17:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local t = require(CorePackages.Packages.t)

local Toast = UIBlox.App.Dialog.Toast
local Images = UIBlox.App.ImageSet.Images

local var1 = Roact.PureComponent:extend("Toast")

var1.validateProps = t.strictInterface({ toastTitle = t.optional(t.string), toastSubtitle = t.optional(t.string) })

function var1.render(arg1)
    if not arg1.props.toastTitle then
        return nil
    end
    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 100
    }, {
        Toast = Roact.createElement(Toast, {
            duration = 3,
            toastContent = {
                iconImage = Images["icons/status/success"],
                toastTitle = arg1.props.toastTitle,
                toastSubtitle = arg1.props.toastSubtitle
            }
        })
    })
end

return RoactRodux.UNSTABLE_connect2(function(arg1, _)
    return {
        toastTitle = arg1.common.toastTitle,
        toastSubtitle = arg1.common.toastSubtitle
    }
end, nil)(var1)
