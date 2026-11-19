-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local UserInputService = game:GetService("UserInputService")

local InGameMenuDependencies = require(CorePackages.Packages.InGameMenuDependencies)
local Roact = InGameMenuDependencies.Roact
local t = InGameMenuDependencies.t
local UIBlox = InGameMenuDependencies.UIBlox
local Cryo = InGameMenuDependencies.Cryo

local withFoundationOrUIBloxStyle = require(CorePackages.Workspace.Packages.CoreGuiCommon).withFoundationOrUIBloxStyle
local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images

local Foundation = require(CorePackages.Packages.Foundation)
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local normalizeFontFace = Foundation.Utility.normalizeFontFace
local FFlagCoreUiMigrateUIBloxToFoundation = require(CorePackages.Workspace.Packages.SharedFlags).FFlagCoreUiMigrateUIBloxToFoundation

local scriptParentParent = script.Parent.Parent
local withLocalization = require(scriptParentParent.Localization.withLocalization)

local var1 = Roact.PureComponent:extend("SearchBar")

var1.validateProps = t.interface({
    size = t.UDim2,
    text = t.optional(t.string),
    onTextChanged = t.optional(t.callback),
    onFocused = t.optional(t.callback),
    onCancelled = t.optional(t.callback),
    onFocusLost = t.optional(t.callback),
    autoCaptureFocus = t.optional(t.boolean),
    zIndex = t.optional(t.number),
    visible = t.optional(t.boolean)
})

var1.defaultProps = {
    size = UDim2.fromScale(1, 1),
    autoCaptureFocus = false,
    visible = true
}

function var1.init(arg1)
    arg1.textboxRef = Roact.createRef()

    function arg1.onAbsoluteSizeChanged(arg2)
        local bool1

        if arg1.width == arg2.AbsoluteSize.X then
            bool1 = false
        else
            arg1.width = arg2.AbsoluteSize.X
            bool1 = true
        end

        if arg1.height ~= arg2.AbsoluteSize.Y then
            arg1.height = arg2.AbsoluteSize.Y
            bool1 = true
        end

        if bool1 then
            arg1:setState({ width = arg1.width - 2, height = arg1.height - 2 })
        end
    end

    function arg1.searchTextChanged(arg2)
        if arg1.props.onTextChanged then
            arg1.props.onTextChanged(arg2.Text)
        end
    end

    function arg1.searchBoxFocused(_)
        if arg1.props.onFocused then
            arg1.props.onFocused()
        end
    end

    function arg1.searchCancel()
        if arg1.props.onCancelled then
            arg1.props.onCancelled()
        end
    end

    function arg1.onFocusLost()
        if arg1.props.onFocusLost then
            arg1.props.onFocusLost()
        end
    end

    function arg1.onTextboxTouchTap()
        if arg1.props.onTextboxTouchTap then
            arg1.props.onTextboxTouchTap()
        end
    end
end

function var1.willUpdate(arg1, arg2)
    if arg1.props.autoCaptureFocus and arg1.props.visible == false and arg2.visible then
        arg1:focus()
    end
end

function var1.didMount(arg1)
    if arg1.props.autoCaptureFocus and arg1.props.visible then
        arg1:focus()
    end
end

function var1.focus(arg1)
    if arg1.textboxRef then
        arg1.textboxRef.current:CaptureFocus()
    end
end

function var1.render(arg1)
    return withFoundationOrUIBloxStyle(function(tokens)
        return {
            Tokens = tokens,
            Theme = {
                TextEmphasis = {
                    Color = tokens.Color.Content.Emphasis.Color3,
                    Transparency = tokens.Color.Content.Emphasis.Transparency
                },
                TextDefault = {
                    Color = tokens.Color.Content.Default.Color3,
                    Transparency = tokens.Color.Content.Default.Transparency
                }
            },
            Font = {
                BaseSize = 1,
                Body = {
                    Font = tokens.Typography.BodyLarge.Font,
                    RelativeSize = tokens.Typography.BodyLarge.FontSize
                }
            }
        }
    end, function(arg2)
        return withLocalization({ search = "CoreScripts.InGameMenu.InviteFriends.Search", cancel = "CoreScripts.InGameMenu.Cancel" })(
            function(arg3)
                local body = arg2.Font.Body
                local textSize = arg2.Font.BaseSize * body.RelativeSize
                local body2 = arg2.Font.Body
                local var2 = arg2.Font.BaseSize * body2.RelativeSize

                local tbl1 = {
                    BackgroundTransparency = 1,
                    GroupTransparency = 0.5,
                    Size = arg1.props.size,
                    ZIndex = arg1.props.zIndex,
                    Visible = arg1.props.visible,
                    [Roact.Ref] = arg1.props.forwardRef or Roact.createRef()
                }
                local textInputType = if UserInputService:GetPlatform() == Enum.Platform.Android then Enum.TextInputType.PasswordShown else Enum.TextInputType.NoSuggestions
                local createElement = Roact.createElement
                local str1 = "CanvasGroup"
                local tbl2 = {
                    SearchPanelLayout = Roact.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 9)
                    }),
                    SearchBorder = 0,
                    CancelButton = 0
                }
                local createElement2 = Roact.createElement
                local str2 = "Frame"
                local tbl3 = {
                    Size = UDim2.new(1, -66, 0, 38),
                    BackgroundColor3 = Color3.new(136, 136, 136),
                    BackgroundTransparency = 0.8,
                    [Roact.Change.AbsoluteSize] = arg1.onAbsoluteSizeChanged
                }
                local tbl4 = {
                    BorderRadius = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    SearchContainer = 0
                }
                local createElement3 = Roact.createElement
                local str3 = "Frame"
                local tbl5 = {
                    BackgroundTransparency = 0,
                    Size = UDim2.fromOffset(arg1.state.width, arg1.state.height),
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    Position = UDim2.fromOffset(1, 1)
                }
                local tbl6 = {
                    SearchContainerLayout = Roact.createElement("UIListLayout", {
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        Padding = UDim.new(0, 10)
                    }),
                    Padding = Roact.createElement("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }),
                    BorderRadius = Roact.createElement("UICorner", { CornerRadius = UDim.new(0, 4) }),
                    SearchImage = if FFlagCoreUiMigrateUIBloxToFoundation then Roact.createElement(Icon, { name = "icons/common/search_small", size = IconSize.Medium, LayoutOrder = 1 }) else Roact.createElement(
                        ImageSetLabel,
                        {
                            LayoutOrder = 1,
                            BackgroundTransparency = 1,
                            Image = Images["icons/common/search_small"],
                            Size = UDim2.fromOffset(18, 18)
                        }
                    ),
                    SearchInput = Roact.createElement("TextBox", {
                        LayoutOrder = 2,
                        BackgroundTransparency = 1,
                        Size = UDim2.new(1, -28, 0, 20),
                        FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
                        Text = arg1.props.text or "",
                        TextInputType = textInputType,
                        TextSize = var2,
                        TextColor3 = arg2.Theme.TextEmphasis.Color,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        PlaceholderText = arg3.search,
                        PlaceholderColor3 = arg2.Theme.TextDefault.Color,
                        ClearTextOnFocus = false,
                        ClipsDescendants = true,
                        [Roact.Change.Text] = arg1.searchTextChanged,
                        [Roact.Event.Focused] = arg1.searchBoxFocused,
                        [Roact.Event.FocusLost] = arg1.onFocusLost,
                        [Roact.Ref] = arg1.textboxRef,
                        [Roact.Event.TouchTap] = arg1.onTextboxTouchTap
                    })
                }
                tbl4.SearchContainer = createElement3(str3, tbl5, tbl6)
                tbl2.SearchBorder = createElement2(str2, tbl3, tbl4)

                tbl2.CancelButton = Roact.createElement("TextButton", {
                    LayoutOrder = 2,
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(57, 20),
                    FontFace = normalizeFontFace(arg2.Tokens.Typography.BodyLarge.Font),
                    TextSize = textSize,
                    Text = arg3.cancel,
                    TextColor3 = arg2.Theme.TextEmphasis.Color,
                    [Roact.Event.Activated] = arg1.searchCancel
                })
                return createElement(str1, tbl1, tbl2)
            end
        )
    end)
end

return Roact.forwardRef(function(arg1, forwardRef)
    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { forwardRef = forwardRef }))
end)
