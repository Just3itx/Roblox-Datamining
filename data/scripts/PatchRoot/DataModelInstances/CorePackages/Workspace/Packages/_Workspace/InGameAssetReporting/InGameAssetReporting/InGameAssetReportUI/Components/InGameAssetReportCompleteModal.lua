-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReportingParent = script:FindFirstAncestor("InGameAssetReporting").Parent

local React = require(InGameAssetReportingParent.React)
local ReactOtter = require(InGameAssetReportingParent.ReactOtter)
local UIBlox = require(InGameAssetReportingParent.UIBlox)
local withLocalization = require(InGameAssetReportingParent.Localization).withLocalization

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local tbl1 = { stiffness = 400, damping = 40, mass = 1 }

local function InGameAssetReportCompleteModal(tbl2)
    local var1, var2 = React.useState(true)

    local var3, var4 = ReactOtter.useAnimatedBinding(1, function()
        if not var1 then
            tbl2.onClose()
        end
    end)

    local var5 = React.useMemo(function(): number
        return if var1 then 0 else 1
    end, { var1 })

    React.useEffect(function()
        var4(ReactOtter.spring(var5, tbl1))
    end, { var5 })

    local onActivated = React.useCallback(function()
        var2(false)
    end, { var2 })

    return withLocalization({
        reportCompleteTitle = "Feature.ReportAbuse.Title.SelectInSceneThankYou",
        reportCompleteDescription = "Feature.ReportAbuse.Label.SelectInSceneComplete",
        reportCompleteClose = "Feature.ReportAbuse.Action.Close"
    })(
        function(arg1)
            local createElement = React.createElement

            local tbl3 = {
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

            return createElement("TextButton", tbl3, {
                Alert = React.createElement(InteractiveAlert, {
                    screenSize = tbl2.screenSize,
                    title = arg1.reportCompleteTitle,
                    bodyText = arg1.reportCompleteDescription,
                    anchorPoint = Vector2.new(0.5, 0.5),
                    position = var3:map(function(alpha: number): UDim2
                        return UDim2.new(0.5, 0, 0.5, 0):Lerp(UDim2.new(0.5, 0, -0.5, 0), alpha)
                    end),
                    buttonStackInfo = {
                        buttons = {{
                            buttonType = ButtonType.PrimarySystem,
                            props = {
                                onActivated = onActivated,
                                text = arg1.reportCompleteClose
                            }
                        }}
                    }
                })
            })
        end
    )
end

return InGameAssetReportCompleteModal
