-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:21:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Roact = require(AuthCommonParent.Roact)
local RoactRodux = require(AuthCommonParent.RoactRodux)
local withLocalization = require(AuthCommonParent.Localization).withLocalization

local withStyle = require(AuthCommonParent.UIBlox).Style.withStyle

local ArgCheck = require(AuthCommonParent.ArgCheck)
local FitChildren = require(AuthCommon.Components.FitChildren)
local FitTextLabel = require(AuthCommon.Components.FitTextLabel)
local FormFactor = require(AuthCommonParent.FormFactor).Enums.FormFactor

local var1 = Roact.PureComponent:extend("TitleAndParagraph")

local RegisterAuditContent = require(AuthCommon.Components.RegisterAuditContent)

local SharedFlags = require(AuthCommonParent.SharedFlags)
local GetFFlagEnableAuditForSinglePageSignUp = SharedFlags.GetFFlagEnableAuditForSinglePageSignUp
local GetFFlagEnableAuditForSso = SharedFlags.GetFFlagEnableAuditForSso

var1.defaultProps = {
    layoutOrder = 0,
    textXAlignment = Enum.TextXAlignment.Left,
    paragraphTextKeys = {},
    paragraphTextArgs = {}
}

function var1.init(arg1)
    arg1.parametersCache = {}
end

function var1.getCachedParameters(tbl1, str1: string, arg1)
    if type(arg1) ~= "table" then
        return nil
    end

    local var2 = tbl1.parametersCache[str1]
    if var2 then
        return var2
    end

    local cachedParameters = ({})
    for k, value in pairs(arg1) do
        if type(k) == "string" then
            cachedParameters[k] = tostring(value)
        end
    end

    tbl1.parametersCache[str1] = cachedParameters
    return cachedParameters
end

local function func1(arg1): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return "paragraphText" .. tostring(arg1)
end

local function func2(arg1): string -- Luacid: Inlined by compiler; 2 call sites recovered
    return "paragraphTextTemplate" .. tostring(arg1)
end

function var1.render(arg1)
    local formFactor = arg1.props.formFactor

    local layoutOrder = arg1.props.layoutOrder
    local titleTextKey = arg1.props.titleTextKey
    local paragraphTextKeys = arg1.props.paragraphTextKeys

    local width = arg1.props.width
    local textXAlignment = arg1.props.textXAlignment

    ArgCheck.isType(paragraphTextKeys, "table", "TitleAndParagraph expects paragraphTextKeys to be a table.")

    local uDim2 = UDim2.new(1, 0, 0, 0)
    if width then
        uDim2 = UDim2.new(0, width, 0, 0)
    end

    local tbl1 = { titleText = titleTextKey }

    for i, paragraphTextKey in ipairs(paragraphTextKeys) do
        tbl1[func1(i)] = paragraphTextKey

        if GetFFlagEnableAuditForSso()
            and GetFFlagEnableAuditForSinglePageSignUp()
            and arg1.props.enableAuditContentCapture
            and type(paragraphTextKey) == "table"
        then
            tbl1[func2(i)] = paragraphTextKey[1]
        end
    end

    if not GetFFlagEnableAuditForSso() and GetFFlagEnableAuditForSinglePageSignUp() and arg1.props.enableAuditContentCapture then
        tbl1.verificationLinkingTextTemplate = "Authentication.SignUp.Description.VerificationLinkingText.VariableButtonName"
    end

    return withLocalization(tbl1)(function(arg2)
        return withStyle(function(arg3)
            local var2 = arg3.Font.BaseSize * arg3.Font.Title.RelativeSize
            local font = arg3.Font.Title.Font

            local var3 = arg3.Font.BaseSize * arg3.Font.Body.RelativeSize
            local font2 = arg3.Font.Body.Font
            local offset

            if formFactor == FormFactor.COMPACT then
                var2 = arg3.Font.BaseSize * arg3.Font.Title.RelativeMinSize

                var3 = arg3.Font.BaseSize * arg3.Font.Body.RelativeMinSize
                offset = 5
            else
                offset = 12
            end

            local num1 = 0
            local tbl2 = {
                Layout = Roact.createElement(
                    "UIListLayout",
                    {
                        FillDirection = Enum.FillDirection.Vertical,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, offset)
                    }
                ),
                Title = arg2.titleText
                    and Roact.createElement(FitTextLabel, {
                        LayoutOrder = num1,
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        TextXAlignment = textXAlignment,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        Text = arg2.titleText,
                        TextSize = var2,
                        Font = font,
                        TextColor3 = arg3.Theme.SystemPrimaryDefault.Color,
                        TextTransparency = arg3.Theme.SystemPrimaryDefault.Transparency,
                        Size = UDim2.new(1, 0, 0, 0),
                        fitAxis = FitChildren.FitAxis.Height,
                        TextWrapped = true
                    })
            }

            for i, paragraphTextKey in ipairs(paragraphTextKeys) do
                num1 += 1
                local str1 = func1(i)
                local var4 = arg2[str1]
                tbl2[str1] = Roact.createElement(FitTextLabel, {
                    LayoutOrder = num1,
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = textXAlignment,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    Text = var4,
                    TextSize = var3,
                    Font = font2,
                    TextColor3 = arg3.Theme.TextDefault.Color,
                    TextTransparency = arg3.Theme.TextDefault.Transparency,
                    Size = UDim2.new(1, 0, 0, 0),
                    fitAxis = FitChildren.FitAxis.Height,
                    TextWrapped = true
                })

                if not (GetFFlagEnableAuditForSinglePageSignUp() and arg1.props.enableAuditContentCapture and RegisterAuditContent and var4) then
                    continue
                end

                local str2 = "AuditContent_" .. str1
                local translationKey = if type(paragraphTextKey) == "table" then paragraphTextKey[1] else paragraphTextKey

                if type(paragraphTextKey) == "table" then
                    if GetFFlagEnableAuditForSso() then
                        var4 = arg2[func2(i)]
                    else
                        var4 = arg2.verificationLinkingTextTemplate
                    end
                end

                tbl2[str2] = Roact.createElement(RegisterAuditContent, {
                    translationKey = translationKey,
                    translatedSourceString = var4,
                    parameters = arg1:getCachedParameters(str2, paragraphTextKey)
                })
            end

            return Roact.createElement(FitChildren.FitFrame, {
                LayoutOrder = layoutOrder,
                Size = uDim2,
                fitAxis = FitChildren.FitAxis.Height,
                BorderSizePixel = 0,
                BackgroundTransparency = 1
            }, tbl2)
        end)
    end)
end

return (RoactRodux.connect(function(arg1, _)
    return {
        formFactor = arg1.FormFactor
    }
end)(var1))
