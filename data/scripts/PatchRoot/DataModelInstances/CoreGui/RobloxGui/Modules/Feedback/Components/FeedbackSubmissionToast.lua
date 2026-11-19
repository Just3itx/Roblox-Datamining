-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T20:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Roact = require(CorePackages.Packages.Roact)
local RoactRodux = require(CorePackages.Packages.RoactRodux)
local UIBlox = require(CorePackages.Packages.UIBlox)
local t = require(CorePackages.Packages.t)

local Toast = UIBlox.App.Dialog.Toast

local Images = UIBlox.App.ImageSet.Images

local withLocalization = require(CorePackages.Workspace.Packages.Localization).withLocalization

local var1 = Roact.PureComponent:extend("FeedbackSubmissionToast")

var1.validateProps = t.strictInterface({ numFeedbackSubmissionAttempts = t.optional(t.number) })

function var1.render(arg1)
    if arg1.props.numFeedbackSubmissionAttempts == nil then
        return nil
    end

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 100
    }, {
        Toast = withLocalization({
            toastTitle = "CoreScripts.Feedback.SubmissionToastHeader",
            toastSubtitle = "CoreScripts.Feedback.SubmissionToastBody"
        })(
            function(tbl1)
                local toastTitle = tbl1.toastTitle
                local toastSubtitle = tbl1.toastSubtitle

                if arg1.props.numFeedbackSubmissionAttempts % 2 == 0 then
                    toastTitle = tbl1.toastTitle .. " "
                    toastSubtitle = tbl1.toastSubtitle .. " "
                end

                return Roact.createElement(Toast, {
                    duration = 3,
                    toastContent = {
                        iconImage = Images["icons/status/success"],
                        toastTitle = toastTitle,
                        toastSubtitle = toastSubtitle
                    }
                })
            end
        )
    })
end
return RoactRodux.connect(function(arg1)
    return {
        numFeedbackSubmissionAttempts = arg1.common.numFeedbackSubmissionAttempts
    }
end, nil)(var1)
