-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InGameAssetReportingParent = script:FindFirstAncestor("InGameAssetReporting").Parent

local React = require(InGameAssetReportingParent.React)
local ReactOtter = require(InGameAssetReportingParent.ReactOtter)
local UIBlox = require(InGameAssetReportingParent.UIBlox)
local Localization = require(InGameAssetReportingParent.Localization)

local Foundation = require(InGameAssetReportingParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View

local useLocalization = Localization.Hooks.useLocalization

local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType

local tbl1 = { stiffness = 400, damping = 40, mass = 1 }

local function InGameAssetReportIPInfringementModal(tbl2)
    local var1, var2 = React.useState(true)
    local var3 = useLocalization({
        yourReportCode = "Feature.ReportAbuse.Label.YourReportCode",
        ipInfringementModalText = "Feature.ReportAbuse.Description.IpInfringementReportModal",
        reportCompleteClose = "Feature.ReportAbuse.Action.Close",
        thankYouIpInfringementReport = "Feature.ReportAbuse.Title.SelectInSceneIpReport"
    })

    local var4, var5 = ReactOtter.useAnimatedBinding(1, function()
        if not var1 then
            tbl2.onClose()
        end
    end)

    local var6 = React.useMemo(function(): number
        return if var1 then 0 else 1
    end, { var1 })

    React.useEffect(function()
        var5(ReactOtter.spring(var6, tbl1))
    end, { var6 })

    local onActivated = React.useCallback(function()
        var2(false)
    end, { var2 })

    local middleContent = React.useCallback(function()
        return React.createElement(View, { tag = "auto-xy col gap-small align-x-center" }, {
            text1 = React.createElement(
                FoundationText,
                {
                    Text = var3.yourReportCode,
                    tag = "auto-xy text-title-medium content-default text-align-x-center",
                    LayoutOrder = 1
                }
            ),
            text2 = React.createElement(
                FoundationText,
                {
                    Text = tbl2.reportCode,
                    tag = "auto-xy text-heading-medium content-emphasis text-align-x-center",
                    LayoutOrder = 2
                }
            ),
            text3 = React.createElement(FoundationText, {
                Text = var3.ipInfringementModalText,
                tag = "auto-xy text-body-medium content-default text-align-x-center text-wrap",
                RichText = true,
                LayoutOrder = 3
            })
        })
    end, { tbl2.reportCode })

    local createElement = React.createElement

    local tbl3 = {
        AutoButtonColor = false,
        BorderSizePixel = 0,
        BackgroundTransparency = var4:map(function(num1: number): number
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
            title = var3.thankYouIpInfringementReport,
            richText = true,
            middleContent = middleContent,
            anchorPoint = Vector2.new(0.5, 0.5),
            position = var4:map(function(alpha: number): UDim2
                return UDim2.new(0.5, 0, 0.5, 0):Lerp(UDim2.new(0.5, 0, -0.5, 0), alpha)
            end),
            buttonStackInfo = {
                buttons = {{
                    buttonType = ButtonType.PrimarySystem,
                    props = {
                        onActivated = onActivated,
                        text = var3.reportCompleteClose
                    }
                }}
            }
        })
    })
end

return InGameAssetReportIPInfringementModal
