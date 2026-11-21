-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:11:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AuthCommon = script:FindFirstAncestor("AuthCommon")
local AuthCommonParent = AuthCommon.Parent

local Roact = require(AuthCommonParent.Roact)
local RoactRodux = require(AuthCommonParent.RoactRodux)
local RoactServices = require(AuthCommonParent.RoactServices).RoactServices
local RoactNetworking = require(AuthCommonParent.RoactServiceTags).RoactNetworking

local t = require(AuthCommonParent.t)
local tutils = require(AuthCommonParent.tutils)
local ArgCheck = require(AuthCommonParent.ArgCheck)

local UIBlox = require(AuthCommonParent.UIBlox)
local withStyle = UIBlox.Style.withStyle
local withLocalization = require(AuthCommonParent.Localization).withLocalization

local Foundation = require(AuthCommonParent.Foundation)
local Icon = Foundation.Icon
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant

local FitChildren = require(AuthCommon.Components.FitChildren)
local FitTextLabel = require(AuthCommon.Components.FitTextLabel)
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local GetImageData = require(AuthCommonParent.RobloxAppAssets).GetImageData

local Logger = require(AuthCommon.Components.Logger)

local IssueCondition = require(AuthCommon.Enums.IssueCondition)
local InputValidity = require(AuthCommon.Enums.InputValidity)

local binding = Roact.createBinding(0)

local var1 = t.interface({ validateFunction = t.callback, getIssueMessageList = t.callback, getDefaultIssues = t.callback })

local var2 = Roact.PureComponent:extend("IssueTracker")

local SharedFlags = require(AuthCommonParent.SharedFlags)
local FFlagSignUpTrackFailedRequest = SharedFlags.FFlagSignUpTrackFailedRequest
local FFlagAuthValidatorStyleOverrides = SharedFlags.FFlagAuthValidatorStyleOverrides
local GetFFlagIssueTrackerUseFoundationIcon = require(AuthCommon.Flags.GetFFlagIssueTrackerUseFoundationIcon)

function var2.init(arg1)
    local validator = arg1.props.validator

    assert(var1(validator))

    local issueMessageList = validator.getIssueMessageList()
    local issueCondition = validator.getDefaultIssues()

    local listOfIssuesOnDisplay = ({})
    for k in pairs(issueMessageList) do
        listOfIssuesOnDisplay[k] = issueCondition[k] ~= IssueCondition.Hidden
    end

    arg1.state = {
        listOfIssuesOnDisplay = listOfIssuesOnDisplay,
        issueMessageList = issueMessageList,
        issueCondition = issueCondition,
        inputValidity = InputValidity.Unvalidated
    }

    arg1.isMounted = false
    arg1.containerRef = Roact.createRef()

    function arg1.validateText()
        local networking = arg1.props.networking

        local textToValidate = arg1.props.textToValidate
        local validate = arg1.props.validate
        local validatorAdditionalProps = arg1.props.validatorAdditionalProps
        local issueCondition = arg1.state.issueCondition

        assert(var1(validator))

        validate(networking, validator.validateFunction, textToValidate, issueCondition, validatorAdditionalProps):andThen(
            function(arg2)
                spawn(function()
                    local onTextValidated = arg1.props.onTextValidated
                    local textToValidate2 = arg1.props.textToValidate
                    local invalid = InputValidity.Invalid

                    if not arg1.isMounted or arg2.Input ~= textToValidate2 then
                        return
                    end

                    if textToValidate2 == "" then
                        invalid = InputValidity.Unvalidated
                    elseif arg2.InputValid then
                        invalid = InputValidity.Valid
                    end

                    if onTextValidated then
                        if FFlagSignUpTrackFailedRequest then
                            onTextValidated(arg2.Input, invalid, arg2.hasRequestFailed)
                        else
                            onTextValidated(arg2.Input, invalid)
                        end
                    end

                    arg1:setState({ issueCondition = arg2.IssueCondition, inputValidity = invalid })

                    if arg1.props.updateIssueCondition then
                        arg1.props.updateIssueCondition(arg2.IssueCondition)
                    end
                end)
            end,
            function(error)
                Logger:warning(string.format("Input issueTracker error: %s", tostring(error)))
                arg1:setState({ inputValidity = InputValidity.Unvalidated })
            end
        )
    end

    function arg1.updateListOfIssuesOnDisplay()
        local height = arg1.props.height

        local issueMessageList2 = arg1.state.issueMessageList
        local issueCondition = arg1.state.issueCondition

        local num1 = 0
        local tbl1 = ({})

        local tbl3 = {}

        local tbl4 = {}

        local tbl5 = {}

        local var3 = arg1.containerRef.current and arg1.containerRef.current:GetChildren() or {}
        for _, value in pairs(var3) do
            if value:IsA("GuiObject") then
                tbl5[value.Name] = value.AbsoluteSize.Y
            end
        end

        for k in pairs(issueMessageList2) do
            tbl1[k] = false

            local bool1 = issueCondition[k] == IssueCondition.Problematic
            if issueCondition[k] == IssueCondition.Hidden then
                continue
            end

            local var4 = tbl5[k] or 0
            table.insert(tbl3, k)
            num1 += var4

            if not bool1 then
                table.insert(tbl4, #tbl3)
            end
        end

        local var4 = num1 + (#tbl3 - 1) * 5

        if height then
            for i = #tbl4, 1, -1 do
                if not (height < var4) then
                    break
                end

                local var5 = tbl4[i]
                var4 = var4 - (tbl5[tbl3[var5]] or 0) - 5
                table.remove(tbl3, var5)
            end

            for i = #tbl3, 1, -1 do
                if not (height < var4) then
                    break
                end

                var4 = var4 - (tbl5[tbl3[i]] or 0) - 5
                table.remove(tbl3, i)
            end
        end

        for _, value in pairs(tbl3) do
            tbl1[value] = true
        end

        spawn(function()
            if arg1.isMounted and not tutils.shallowEqual(tbl1, arg1.state.listOfIssuesOnDisplay) then
                arg1:setState({ listOfIssuesOnDisplay = tbl1 })
            end
        end)
    end
end

function var2.didMount(arg1)
    arg1.isMounted = true
    arg1.updateListOfIssuesOnDisplay()
end

function var2.willUnmount(arg1)
    arg1.isMounted = false
end

function var2.didUpdate(arg1, arg2, _)
    local validator = arg1.props.validator
    local validatorAdditionalProps = arg1.props.validatorAdditionalProps
    local textToValidate = arg1.props.textToValidate

    if validator ~= arg2.validator then
        ArgCheck.assert(validator == arg2.validator, "IssueTracker expects the validator to never change")
    end

    if textToValidate ~= arg2.textToValidate
        or not tutils.shallowEqual(validatorAdditionalProps, arg2.validatorAdditionalProps)
    then
        spawn(function()
            if FFlagSignUpTrackFailedRequest then
                task.wait(if arg1.props.debounceTime then arg1.props.debounceTime else 0.3)
            else
                wait(0.3)
            end
            local textToValidate2 = arg1.props.textToValidate
            if textToValidate == textToValidate2 then
                arg1.validateText()
            end
        end)
    end

    arg1.updateListOfIssuesOnDisplay()
end

function var2.render(arg1)
    local height = arg1.props.height

    local issueMessageList = arg1.state.issueMessageList
    local issueCondition = arg1.state.issueCondition

    local listOfIssuesOnDisplay = arg1.state.listOfIssuesOnDisplay

    return withStyle(function(arg2)
        local font = arg2.Font.CaptionBody.Font
        local textSize = arg2.Font.BaseSize * arg2.Font.CaptionBody.RelativeSize
        local contentTransparency = arg1.props.contentTransparency
        local checkmark = arg1.props.checkmarkTransparency or binding
        local var5 = if FFlagAuthValidatorStyleOverrides and arg1.props.colorContentOverride then arg1.props.colorContentOverride else arg2.Theme.TextDefault.Color

        if not contentTransparency then
            local textDefaultTransparency = arg2.Theme.TextDefault.Transparency
            if textDefaultTransparency ~= arg1.textDefaultTransparency then
                arg1.textDefaultTransparency = textDefaultTransparency
                arg1.textDefaultTransparencyBinding = Roact.createBinding(textDefaultTransparency)
            end
            contentTransparency = arg1.textDefaultTransparencyBinding
        end

        local var6 = Roact.joinBindings({ content = contentTransparency, checkmark = checkmark })

        local tbl1 = {}
        for k in pairs(issueMessageList) do
            table.insert(tbl1, k)
        end
        if arg1.props.sortProblematicIssues then
            table.sort(tbl1, function(arg3, arg4): boolean
                return issueCondition[arg3] == IssueCondition.Problematic and issueCondition[arg4] ~= IssueCondition.Problematic
            end)
        end

        return withLocalization(issueMessageList)(function(arg3)
            local tbl2 = { Roact.createElement("UIListLayout", {
                    Padding = UDim.new(0, 5),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    [Roact.Change.AbsoluteContentSize] = arg1.updateListOfIssuesOnDisplay
                }) }

            for layoutOrder, value in ipairs(tbl1) do
                local bool1 = issueCondition[value] == IssueCondition.Problematic
                local bool2 = bool1 and arg1.state.inputValidity ~= InputValidity.Unvalidated

                local createElement = Roact.createElement
                local fitFrame = FitChildren.FitFrame
                local tbl3 = {
                    Size = UDim2.new(1, 0, 0, 0),
                    fitAxis = FitChildren.FitAxis.Height,
                    BackgroundTransparency = 1,
                    LayoutOrder = layoutOrder,
                    Visible = listOfIssuesOnDisplay[value]
                }
                local tbl4 = {
                    List = Roact.createElement(
                        "UIListLayout",
                        {
                            FillDirection = Enum.FillDirection.Horizontal,
                            Padding = UDim.new(0, 7),
                            SortOrder = Enum.SortOrder.LayoutOrder
                        }
                    ),
                    CheckHolder = 0,
                    IssueLabel = 0
                }
                local createElement2 = Roact.createElement
                local str1 = "Frame"
                local tbl5 = {
                    Size = UDim2.new(0, 12, 0, 12),
                    LayoutOrder = 1,
                    BackgroundTransparency = 1
                }

                local tbl6 = { CheckMark = 0 }
                local var7

                if GetFFlagIssueTrackerUseFoundationIcon() then
                    local createElement3 = Roact.createElement
                    local var8 = Icon

                    local tbl7 = {
                        name = if bool1 then IconName.X else IconName.Check,
                        variant = IconVariant.Filled,
                        size = IconSize.XSmall,
                        style = var6:map(function(arg4)
                            return {
                                Color3 = bool2 and arg2.Theme.Alert.Color or var5,
                                Transparency = (arg4.content - 1) * (1 - arg4.checkmark) + 1
                            }
                        end),
                        Position = UDim2.new(0.5, 0, 0.65, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5)
                    }

                    var7 = createElement3(var8, tbl7)
                else
                    local createElement3 = Roact.createElement
                    local var8 = ImageSetLabel

                    local tbl7 = {
                        BackgroundTransparency = 1,
                        Image = if bool1 then GetImageData("LuaApp/icons/navigation/close") or "LuaApp/icons/navigation/close" else GetImageData("LuaApp/icons/progress_small") or "LuaApp/icons/progress_small",
                        ImageColor3 = bool2 and arg2.Theme.Alert.Color or var5,
                        ImageTransparency = var6:map(function(arg4)
                            return (arg4.content - 1) * (1 - arg4.checkmark) + 1
                        end),
                        Size = UDim2.new(1, 0, 1, 0),
                        Position = UDim2.new(0.5, 0, 0.65, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5)
                    }

                    var7 = createElement3(var8, tbl7)
                end

                tbl6.CheckMark = var7
                tbl4.CheckHolder = createElement2(str1, tbl5, tbl6)

                tbl4.IssueLabel = Roact.createElement(FitTextLabel, {
                    LayoutOrder = 2,
                    Size = UDim2.new(1, 0, 0, 0),
                    fitAxis = FitChildren.FitAxis.Height,
                    BackgroundTransparency = 1,
                    Text = arg3[value],
                    TextWrapped = true,
                    Font = font,
                    TextSize = textSize,
                    TextColor3 = bool2 and arg2.Theme.Alert.Color or var5,
                    TextTransparency = contentTransparency,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                tbl2[value] = createElement(fitFrame, tbl3, tbl4)
            end

            if height then
                local createElement = Roact.createElement

                local tbl3 = {
                    Size = UDim2.new(1, 0, 0, height),
                    BackgroundTransparency = 1,
                    [Roact.Ref] = arg1.containerRef,
                    Position = checkmark:map(function(arg4): UDim2
                        return UDim2.new(0, 19 * -arg4, 0, 0)
                    end)
                }

                return createElement("Frame", tbl3, tbl2)
            end

            local createElement = Roact.createElement
            local fitFrame = FitChildren.FitFrame

            local tbl3 = {
                Size = UDim2.new(1, 0, 0, 0),
                fitAxis = FitChildren.FitAxis.Height,
                BackgroundTransparency = 1,
                [Roact.Ref] = arg1.containerRef,
                Position = checkmark:map(function(arg4): UDim2
                    return UDim2.new(0, 19 * -arg4, 0, 0)
                end)
            }

            return createElement(fitFrame, tbl3, tbl2)
        end)
    end)
end

local var3 = RoactRodux.connect(nil, function(arg1)
    return {
        validate = function(arg2, arg3, arg4, arg5, arg6)
            return arg1(arg3(arg2, arg4, arg5, arg6))
        end
    }
end)(var2)

return (RoactServices.connect({ networking = RoactNetworking })(var3))
