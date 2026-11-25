-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T12:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarCreationService = game:GetService("AvatarCreationService")

local SelfieQrParent = script:FindFirstAncestor("SelfieQr").Parent

local FocusNavigationUtils = require(SelfieQrParent.FocusNavigationUtils)
local Foundation = require(SelfieQrParent.Foundation)
local Http = require(SelfieQrParent.Http)
local Localization = require(SelfieQrParent.Localization)
local Promise = require(SelfieQrParent.Promise)
local QRCodeDisplay = require(SelfieQrParent.QRCodeDisplay)
local React = require(SelfieQrParent.React)
local ReactFocusNavigation = require(SelfieQrParent.ReactFocusNavigation)
local Responsive = require(SelfieQrParent.Responsive)
local RoactNetworking = require(SelfieQrParent.RoactServiceTags).RoactNetworking
local useRoactService = require(SelfieQrParent.RobloxAppHooks).useRoactService

local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local DisplayQRCode = QRCodeDisplay.DisplayQRCode
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local Image = Foundation.Image
local Icon = Foundation.Icon
local Url = Http.Url
local useLocalization = Localization.Hooks.useLocalization
local useTokens = Foundation.Hooks.useTokens

local bool1 = game:DefineFastFlag("AdoptStyleTokens", false)
local bool2 = game:DefineFastFlag("AllowQrEnlargeUniversally", false)
local bool3 = game:DefineFastFlag("ConsoleCloseAffordanceFix", false)
local bool4 = game:DefineFastFlag("EnableTimeoutUI", false)
local num1 = game:DefineFastInt("SelfieQrTimeoutSeconds", 120)

local str1 = game:DefineFastString("DebugAvatarGenerationStaticApiKey", "NOT_SET")

local tbl1 = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack
}

local function SelfieQRCodeView(tbl2)
    local var1 = useTokens()

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl3 = {
        Size = tbl2.outerSize,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = if bool4 and tbl2.errorOccurred then var1.Color.Extended.Gray.Gray_1000.Color3 elseif bool1 then var1.Color.Extended.White.White_0.Color3 else Color3.fromRGB(255, 255, 255),
        ClipsDescendants = true
    }

    local tbl4 = { QRContainer = 0, LogoContainer = 0, Corner = 0, Constraint = 0 }
    local element

    if bool4 and tbl2.errorOccurred then
        element = nil
    else
        element = React.createElement("Frame", {
            Size = UDim2.fromOffset(tbl2.sideLength, tbl2.sideLength),
            Position = UDim2.fromScale(0.5, 0.5),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = if bool1 then var1.Color.None.Transparency else 1
        }, {
            DisplayQRCode = React.createElement(
                DisplayQRCode,
                {
                    toEncode = tbl2.url,
                    ecLevel = QRCodeDisplay.ECLevels.EC_LEVEL_4,
                    sideLength = tbl2.sideLength
                }
            )
        })
    end

    tbl4.QRContainer = element
    local var2

    if bool4 and tbl2.errorOccurred then
        var2 = nil
    else
        local createElement2 = React.createElement
        local str3 = "Frame"
        local tbl5 = {
            Size = UDim2.new(0.3, 0, 0.3, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = if bool1 then var1.Color.Extended.Black.Black_0.Color3 else Color3.fromRGB(0, 0, 0),
            ZIndex = 10,
            ClipsDescendants = true
        }

        local tbl6 = {
            Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0.125, 0) }),
            Stroke = React.createElement("UIStroke", {
                Color = var1.Color.Extended.White.White_0.Color3,
                Thickness = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Round
            }),
            Icon = React.createElement(Image, {
                Size = if bool1 then UDim2.fromScale(1, 1) else UDim2.new(0.75, 0, 0.75, 0),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.fromScale(0.5, 0.5),
                BackgroundTransparency = if bool1 then nil else 1,
                Image = if bool1 then "rbxasset://textures/ui/LuaApp/ExternalSite/roblox@3x.png" else "icons/logo/block",
                ZIndex = 11
            })
        }
        var2 = createElement2(str3, tbl5, tbl6)
    end

    tbl4.LogoContainer = var2

    tbl4.Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0.065, 0) })

    tbl4.Constraint = React.createElement(
        "UIAspectRatioConstraint",
        {
            AspectRatio = 1,
            AspectType = Enum.AspectType.FitWithinMaxSize,
            DominantAxis = Enum.DominantAxis.Width
        }
    )
    return createElement(str2, tbl3, tbl4)
end

local function getJobStatus(arg1, arg2)
    return arg1(arg2, "GET", { headers = { ["X-Static-Api-Key"] = str1 } }):andThen(function(arg3)
        local responseBody = arg3.responseBody
        if not responseBody then
            return Promise.reject("Invalid response from getJobStatus")
        end

        return responseBody
    end)
end

return function(tbl2)
    local var1, var2 = React.useState(false)
    local bool5 = Responsive.usePreferredInput() == Responsive.Input.Directional
    local var3, var4 = React.useState(false)
    local var5, var6 = React.useState(false)
    local var7 = useRoactService(RoactNetworking)
    local var8 = useTokens()

    local var9 = useLocalization({
        title = {
            "AvatarGeneration.SelfieConsent.QRTitle",
            fontStart = "<font weight=\"heavy\" size=\"24\">",
            fontEnd = "</font>"
        },
        body = {
            "AvatarGeneration.SelfieConsent.QRBody",
            fontStart = "<font size=\"18\">",
            fontEnd = "</font>"
        },
        errorTitle = {
            "AvatarGeneration.SelfieConsent.QRErrorTitle",
            fontStart = "<font weight=\"heavy\" size=\"24\">",
            fontEnd = "</font>"
        },
        errorBody = {
            "AvatarGeneration.SelfieConsent.QRErrorBody",
            fontStart = "<font size=\"18\">",
            fontEnd = "</font>"
        }
    })

    local function handleError() -- Luacid: Inlined by compiler; 3 call sites recovered
        var6(true)
        var2(false)
        var4(false)
    end

    React.useEffect(function()
        local var10 = nil
        local var11 = task.delay(num1, function()
            if bool4 then
                handleError()
                return
            end

            tbl2.displaySelfieQRCode(false)
            AvatarCreationService:HandleSelfieQRResult(false, "job not completed within time limit")
        end)

        local function poll(arg1)
            getJobStatus(var7, arg1):andThen(function(arg2)
                if arg2.status == "done" then
                    local fileId = arg2.fileIds and arg2.fileIds[1]
                    tbl2.displaySelfieQRCode(false)
                    AvatarCreationService:HandleSelfieQRResult(true, fileId)
                    return
                end

                if arg2.status == "cancelled" or arg2.status == "error" then
                    if bool4 then
                        handleError()
                        return
                    end

                    tbl2.displaySelfieQRCode(false)
                    AvatarCreationService:HandleSelfieQRResult(false, "job polling failed")
                else
                    var10 = task.delay(1, function()
                        poll(arg1)
                    end)
                end
            end):catch(function(_)
                if bool4 then
                    handleError()
                    return
                end

                tbl2.displaySelfieQRCode(false)
                AvatarCreationService:HandleSelfieQRResult(false, "job polling failed")
            end)
        end

        poll(string.format("%sml-runtime-gateway/v0.2/jobs/%s", Url.APIS_URL, tbl2.jobId))

        return function()
            if var10 then
                task.cancel(var10)
            end
            if var11 then
                task.cancel(var11)
            end
        end
    end, {})

    local tbl3 = {
        size = DialogSize.Medium,
        ZIndex = 2
    }

    if not bool5 then
        function tbl3.onClose(_)
            tbl2.displaySelfieQRCode(false)
            if bool4 then
                AvatarCreationService:HandleSelfieQRResult(false, "QR code closed before job completed or session expired")
                return
            end

            AvatarCreationService:HandleSelfieQRResult(false, "QR code closed before job completed")
        end
    end

    local var10 = if bool3 then ReactFocusNavigation.useEventMap(tbl1) else nil

    local var11 = React.useCallback(function(arg1)
        local eventData = arg1.eventData
        if not eventData or eventData.UserInputState ~= Enum.UserInputState.End then
            return
        end

        arg1:cancel()

        if var1 then
            var2(false)
            return
        end
        tbl2.displaySelfieQRCode(false)
        if bool4 then
            AvatarCreationService:HandleSelfieQRResult(false, "QR code closed before job completed or session expired")
            return
        end

        AvatarCreationService:HandleSelfieQRResult(false, "QR code closed before job completed")
    end, { var1, tbl2.displaySelfieQRCode })

    local var12 = if bool3 then ReactFocusNavigation.useEventHandler(FocusNavigationEventNameEnum.NavigateBack, var11, nil, var10) else nil

    if var1 then
        local createElement = React.createElement
        local str2 = "Frame"
        local tbl4 = {
            ref = 0,
            Size = 0,
            BackgroundColor3 = 0,
            BackgroundTransparency = 0,
            ZIndex = 7
        }

        if not bool3 then
            var12 = nil
        end

        tbl4.ref = var12
        tbl4.Size = UDim2.new(1, 0, 1, 0)
        tbl4.BackgroundColor3 = if bool1 then var8.Color.Extended.Black.Black_60.Color3 else Color3.fromRGB(0, 0, 0)

        tbl4.BackgroundTransparency = if bool1 then var8.Color.Extended.Black.Black_60.Transparency else 0.4

        local tbl5 = {
            InvisibleCloseButton = React.createElement("TextButton", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = if bool1 then var8.Color.ActionUtility.Background.Transparency else 1,
                Text = "",
                ZIndex = if bool3 then nil else 5,
                [React.Event.Activated] = bool2 and not bool5 and function()
                    var2(false)
                end or not bool3 and function()
                    var2(false)
                end or nil
            }),
            QRCodeArea = React.createElement(SelfieQRCodeView, {
                url = tbl2.url,
                sideLength = 500,
                outerSize = UDim2.fromOffset(600, 600),
                errorOccurred = if bool4 then var5 else nil
            })
        }

        return createElement(str2, tbl4, tbl5)
    end

    local createElement = React.createElement
    local str2 = "Frame"
    local tbl4 = { ref = 0, Size = 0, BackgroundColor3 = 0, BackgroundTransparency = 0, ZIndex = 0 }
    if not bool3 then
        var12 = nil
    end

    tbl4.ref = var12
    tbl4.Size = UDim2.new(1, 0, 1, 0)
    tbl4.BackgroundColor3 = if bool1 then var8.Color.Extended.Black.Black_0.Color3 else Color3.fromRGB(0, 0, 0)

    tbl4.BackgroundTransparency = if bool1 then var8.Color.None.Transparency else 1

    local tbl5 = { InvisibleCloseButton = 0, Dialog = 0 }
    local var13

    if bool3 then
        var13 = nil
    else
        local createElement2 = React.createElement
        local tbl6 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = if bool1 then var8.Color.ActionUtility.Background.Transparency else 1,
            Text = "",
            ZIndex = 1
        }

        tbl6[React.Event.Activated] = function()
            tbl2.displaySelfieQRCode(false)
            AvatarCreationService:HandleSelfieQRResult(false, "QR code closed before job completed")
        end

        var13 = createElement2("TextButton", tbl6)
    end

    tbl5.InvisibleCloseButton = var13

    local createElement2 = React.createElement
    local root = Dialog.Root
    local tbl6 = { DialogContent = 0 }
    local createElement3 = React.createElement
    local content = Dialog.Content
    local var14 = nil
    local tbl7 = {
        Layout = React.createElement("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = if bool1 then UDim.new(0, var8.Padding.Small) else UDim.new(0, 10)
        }),
        TopSpacer = React.createElement("Frame", {
            Size = if bool1 then UDim2.fromOffset(0, 56) else UDim2.new(0, 0, 0, 50),
            BackgroundTransparency = if bool1 then var8.Color.None.Transparency else 1,
            LayoutOrder = 0
        }),
        HoverFrame = 0,
        BottomSpacer = 0,
        TextContainerWrapper = 0
    }

    local createElement4 = React.createElement
    local str3 = "Frame"
    local tbl8 = {
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        LayoutOrder = 1
    }

    local tbl9 = {
        Layout = React.createElement(
            "UIListLayout",
            {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }
        ),
        InteractiveArea = 0
    }

    local createElement5 = React.createElement
    local str4 = "TextButton"
    local tbl10 = {
        Text = "",
        Size = UDim2.new(0.65, 0, 0, 0),
        BackgroundTransparency = if bool1 then var8.Color.ActionUtility.Background.Transparency else 1,
        AutoButtonColor = false
    }

    tbl10[React.Event.MouseEnter] = function()
        if bool4 and var5 then
            return
        end
        if bool2 or bool5 then
            var4(true)
        end
    end
    tbl10[React.Event.MouseLeave] = function()
        var4(false)
    end
    tbl10[React.Event.Activated] = function()
        if bool4 and var5 then
            return
        end
        if not bool2 and not bool5 then
            return
        end

        var2(true)
        if bool4 then
            var4(false)
        end
    end

    local tbl11 = {
        Constraint = React.createElement(
            "UIAspectRatioConstraint",
            {
                AspectRatio = 1,
                AspectType = Enum.AspectType.ScaleWithParentSize,
                DominantAxis = Enum.DominantAxis.Width
            }
        ),
        BorderFrame = 0,
        QRCodeArea = 0
    }

    local createElement6 = React.createElement
    local str5 = "Frame"
    local tbl12 = {
        Size = UDim2.new(0.98, 0, 0.98, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = var8.Color.ActionEmphasis.Border.Transparency
    }
    local tbl13 = {
        Stroke = React.createElement("UIStroke", {
            Color = if bool1 then var8.Color.Extended.White.White_0.Color3 else Color3.fromRGB(255, 255, 255),
            Thickness = 3,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            LineJoinMode = Enum.LineJoinMode.Round,
            Transparency = not bool1 and (if var3 then 0 else 1)
                or var3 and var8.Color.ActionEmphasis.Foreground.Transparency
                or var8.Color.ActionEmphasis.Border.Transparency
        }),
        Corner = React.createElement("UICorner", { CornerRadius = UDim.new(0.075, 0) })
    }
    tbl11.BorderFrame = createElement6(str5, tbl12, tbl13)

    tbl11.QRCodeArea = React.createElement(SelfieQRCodeView, {
        url = tbl2.url,
        sideLength = 225,
        outerSize = UDim2.new(0.95, 0, 0.95, 0),
        errorOccurred = if bool4 then var5 else nil
    })
    tbl9.InteractiveArea = createElement5(str4, tbl10, tbl11)
    tbl7.HoverFrame = createElement4(str3, tbl8, tbl9)

    tbl7.BottomSpacer = React.createElement("Frame", {
        Size = if bool1 then UDim2.fromOffset(0, var8.Gap.XXLarge) else UDim2.new(0, 0, 0, 30),
        BackgroundTransparency = if bool1 then var8.Color.None.Transparency else 1,
        LayoutOrder = 2
    })

    local createElement7 = React.createElement
    local str6 = "Frame"
    local tbl14 = {
        Size = UDim2.new(1, 0, 0, var8.Size.Size_2000),
        BackgroundTransparency = var8.Color.None.Transparency,
        LayoutOrder = 3
    }
    local tbl15 = {
        Layout = if bool4 then nil else React.createElement(
            "UIListLayout",
            {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }
        ),
        TextAndIconContainer = 0,
        TitleText = 0,
        DialogText = 0
    }
    local var15

    if bool4 then
        local createElement8 = React.createElement
        local str7 = "Frame"
        local tbl16 = {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = var8.Color.None.Transparency
        }
        local tbl17 = {
            Layout = React.createElement("UIListLayout", {
                FillDirection = if var5 then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical,
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                Padding = UDim.new(0, var8.Gap.Medium)
            }),
            WarningIcon = if var5 then React.createElement(Icon, {
                name = Foundation.Enums.IconName.TriangleExclamation,
                size = var8.Size.Size_700,
                BackgroundTransparency = var8.Color.None.Transparency,
                LayoutOrder = 1
            }) else nil,
            TextContent = 0
        }

        local createElement9 = React.createElement
        local str8 = "Frame"
        local tbl18 = {
            Size = if var5 then UDim2.new(1, -48, 0, 0) else UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = var8.Color.None.Transparency,
            LayoutOrder = 2
        }
        local tbl19 = {
            Layout = React.createElement("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                Padding = UDim.new(0, var8.Gap.Small)
            }),
            TitleText = React.createElement(Dialog.Text, {
                Text = if var5 then var9.errorTitle else var9.title,
                LayoutOrder = 3,
                TextXAlignment = if var5 then Enum.TextXAlignment.Left else Enum.TextXAlignment.Center,
                Font = Enum.Font.SourceSansBold
            }),
            DialogText = React.createElement(
                Dialog.Text,
                {
                    Text = if var5 then var9.errorBody else "",
                    LayoutOrder = 4,
                    TextXAlignment = Enum.TextXAlignment.Left
                }
            )
        }
        tbl17.TextContent = createElement9(str8, tbl18, tbl19)
        var15 = createElement8(str7, tbl16, tbl17)
    else
        var15 = nil
    end

    tbl15.TextAndIconContainer = var15

    tbl15.TitleText = if bool4 then nil else React.createElement(Dialog.Text, { Text = var9.title, LayoutOrder = 3, Font = Enum.Font.SourceSansBold })

    tbl15.DialogText = if bool4 then nil else React.createElement(Dialog.Text, { Text = var9.body, LayoutOrder = 4 })
    tbl7.TextContainerWrapper = createElement7(str6, tbl14, tbl15)
    tbl6.DialogContent = createElement3(content, var14, tbl7)
    tbl5.Dialog = createElement2(root, tbl3, tbl6)
    return createElement(str2, tbl4, tbl5)
end
