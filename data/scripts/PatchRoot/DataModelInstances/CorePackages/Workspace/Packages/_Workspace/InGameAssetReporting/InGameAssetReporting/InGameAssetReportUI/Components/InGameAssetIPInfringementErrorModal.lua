-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReporting = script:FindFirstAncestor("InGameAssetReporting")
local InGameAssetReportingParent = InGameAssetReporting.Parent

local React = require(InGameAssetReportingParent.React)
local ReactOtter = require(InGameAssetReportingParent.ReactOtter)
local UIBlox = require(InGameAssetReportingParent.UIBlox)
local withLocalization = require(InGameAssetReportingParent.Localization).withLocalization

local Constants = require(InGameAssetReporting.InGameAssetReportUI.Resources.Constants)

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local IpErrorCodes = Constants.IpErrorCodes

local tbl1 = {
    titleKey = "Feature.ReportAbuse.Heading.IpNoReportableContent",
    descriptionKey = "Feature.ReportAbuse.Description.IpNoReportableContent",
    showReportExperience = true
}

local tbl2 = {
    titleKey = "InGame.CommonUI.Title.Error",
    descriptionKey = "Feature.ReportAbuse.Description.IpGenericError",
    showReportExperience = false
}

local tbl3 = {
    [IpErrorCodes.ClientNoAssetsExtracted] = tbl1,
    [IpErrorCodes.NoEligibleContents] = tbl1,
    [IpErrorCodes.Unknown] = tbl2
}

local tbl4 = { stiffness = 400, damping = 40, mass = 1 }

return React.memo(function(tbl5) -- name: InGameAssetIPInfringementErrorModal
    local var1, var2 = React.useState(true)

    local var3, var4 = ReactOtter.useAnimatedBinding(1, function()
        if not var1 then
            tbl5.onBack()
        end
    end)

    local var5 = React.useMemo(function(): number
        return if var1 then 0 else 1
    end, { var1 })

    React.useEffect(function()
        var4(ReactOtter.spring(var5, tbl4))
    end, { var5 })

    local onActivated = React.useCallback(function()
        var2(false)
    end, { var2 })

    local var7 = if tbl5.errorCode and tbl3[tbl5.errorCode] then tbl3[tbl5.errorCode] else tbl2

    return withLocalization({
        errorBack = "Feature.ReportAbuse.Action.ErrorModalGoBack",
        reportExperience = "Feature.ReportAbuse.Action.IpReportExperience",
        title = var7.titleKey,
        description = var7.descriptionKey
    })(
        function(arg1)
            local buttons = {}

            if var7.showReportExperience and tbl5.onReportExperience then
                table.insert(buttons, {
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = tbl5.onReportExperience,
                        text = arg1.reportExperience,
                        isLoading = tbl5.isReportExperienceLoading,
                        isDisabled = tbl5.isReportExperienceLoading
                    }
                })
                table.insert(
                    buttons,
                    {
                        buttonType = ButtonType.Secondary,
                        props = {
                            onActivated = onActivated,
                            text = arg1.errorBack
                        }
                    }
                )
            else
                table.insert(
                    buttons,
                    {
                        buttonType = ButtonType.PrimarySystem,
                        props = {
                            onActivated = onActivated,
                            text = arg1.errorBack
                        }
                    }
                )
            end
            local createElement = React.createElement

            local tbl7 = {
                AutoButtonColor = false,
                BorderSizePixel = 0,
                BackgroundTransparency = var3:map(function(num1: number): number
                    return num1 + 0.3
                end),
                BackgroundColor3 = Color3.fromHex("#000000"),
                Size = UDim2.new(1, 0, 1, 0),
                Text = "",
                Position = UDim2.fromScale(0.5, 0.5),
                AnchorPoint = Vector2.new(0.5, 0.5),
                [React.Event.Activated] = onActivated,
                ZIndex = 10
            }

            return createElement("TextButton", tbl7, {
                Alert = React.createElement(InteractiveAlert, {
                    screenSize = tbl5.screenSize,
                    title = arg1.title,
                    bodyText = arg1.description,
                    anchorPoint = Vector2.new(0.5, 0.5),
                    position = var3:map(function(alpha: number): UDim2
                        return UDim2.new(0.5, 0, 0.5, 0):Lerp(UDim2.new(0.5, 0, -0.5, 0), alpha)
                    end),
                    buttonStackInfo = { buttons = buttons }
                })
            })
        end
    )
end)
